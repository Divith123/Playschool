import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:ota_update/ota_update.dart';
import 'package:permission_handler/permission_handler.dart';

class UpdateService {
  // Replace with your actual GitHub username and repo name
  static const String _githubOwner = 'Divith123';
  static const String _githubRepo = 'Playschool';

  /// Enhanced version check that handles edge cases
  Future<Map<String, dynamic>?> checkForUpdate() async {
    try {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final String currentVersion = packageInfo.version;

      final Uri url = Uri.parse(
        'https://api.github.com/repos/$_githubOwner/$_githubRepo/releases/latest',
      );

      final response = await http
          .get(url)
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw Exception('Connection timeout'),
          );

      if (response.statusCode == 200) {
        final Map<String, dynamic> releaseData = json.decode(response.body);
        final String latestTag = releaseData['tag_name'] ?? 'v0.0.0';

        // Remove 'v' prefix if present for comparison
        final String cleanLatest = latestTag.replaceAll('v', '');
        final String cleanCurrent = currentVersion.replaceAll('v', '');

        if (_isNewer(cleanLatest, cleanCurrent)) {
          // Find APK asset - look for both .apk and .aab files
          String? downloadUrl;
          if (releaseData['assets'] != null) {
            for (var asset in releaseData['assets']) {
              final String assetName = asset['name'].toString().toLowerCase();
              if (assetName.endsWith('.apk') || assetName.endsWith('.aab')) {
                downloadUrl = asset['browser_download_url'];
                break;
              }
            }
          }

          if (downloadUrl != null) {
            return {
              'updateAvailable': true,
              'latestVersion': latestTag,
              'releaseNotes':
                  releaseData['body'] ?? 'No release notes available',
              'downloadUrl': downloadUrl,
              'releaseName': releaseData['name'] ?? latestTag,
            };
          }
        }
      } else if (response.statusCode == 403) {
        debugPrint('GitHub API rate limit exceeded');
      } else if (response.statusCode == 404) {
        debugPrint('Release not found - check repository name and owner');
      } else {
        debugPrint('GitHub API Error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error checking for updates: $e');
    }
    return null;
  }

  /// Simple version comparison (semver-like)
  bool _isNewer(String latest, String current) {
    try {
      List<int> l = latest.split('.').map((e) => int.tryParse(e) ?? 0).toList();
      List<int> c = current
          .split('.')
          .map((e) => int.tryParse(e) ?? 0)
          .toList();

      // Pad with zeros to ensure equal length
      while (l.length < 3) {
        l.add(0);
      }
      while (c.length < 3) {
        c.add(0);
      }

      for (int i = 0; i < 3; i++) {
        if (l[i] > c[i]) return true;
        if (l[i] < c[i]) return false;
      }
      return false;
    } catch (e) {
      debugPrint('Version comparison error: $e');
      return false;
    }
  }

  /// Get user-friendly installation instructions when auto-install fails
  Future<String> getInstallationInstructions(String downloadUrl) async {
    try {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      return '''
Update Instructions:

1. Download the update from: $downloadUrl
2. Go to your Downloads folder or notification panel
3. Tap on the downloaded APK file
4. If prompted, allow installation from unknown sources
5. Follow the installation prompts
6. Open the app once installed

Current version: ${packageInfo.version}
App name: ${packageInfo.appName}

Note: You may need to enable "Install unknown apps" in your device settings for this app.
''';
    } catch (e) {
      return '''
Manual Installation Required:

1. Download from: $downloadUrl
2. Install the APK file manually
3. Enable unknown sources if prompted
''';
    }
  }

  /// Triggers the OTA download and install with proper error handling
  Stream<OtaEvent> downloadAndInstall(String url) async* {
    try {
      // First check and request all necessary permissions
      bool hasPermissions = await requestPermissions();
      if (!hasPermissions) {
        yield OtaEvent(
          OtaStatus.PERMISSION_NOT_GRANTED_ERROR,
          'Storage and installation permissions required',
        );
        return;
      }

      // Check if URL is valid
      if (url.isEmpty || !url.startsWith('http')) {
        yield OtaEvent(OtaStatus.DOWNLOAD_ERROR, 'Invalid download URL');
        return;
      }

      // Execute OTA update with proper error handling
      // Use a try-catch around the entire execution to handle crashes
      try {
        await for (final event in OtaUpdate().execute(
          url,
          destinationFilename: 'playschool_update.apk',
        )) {
          yield event;

          // If we get a completed status, add a small delay to ensure the file is fully written
          if (event.status == OtaStatus.INSTALLATION_DONE) {
            await Future.delayed(const Duration(milliseconds: 500));
            // Double-check permissions before installation
            final permissionStatus = await getPermissionStatus();
            if (!permissionStatus['allGranted']!) {
              yield OtaEvent(
                OtaStatus.PERMISSION_NOT_GRANTED_ERROR,
                'Installation permissions not granted. Please enable "Install unknown apps" in settings.',
              );
              return;
            }
          }
        }
      } catch (installError) {
        // Handle installation-specific errors
        String errorMessage = 'Installation failed: ';
        if (installError is Exception) {
          errorMessage += installError.toString();
        } else {
          errorMessage += 'Unknown installation error';
        }

        // Check if it's a permission issue
        if (installError.toString().toLowerCase().contains('permission') ||
            installError.toString().toLowerCase().contains('denied')) {
          yield OtaEvent(
            OtaStatus.PERMISSION_NOT_GRANTED_ERROR,
            'Installation permission denied. Please enable "Install unknown apps" in device settings.',
          );
        } else {
          yield OtaEvent(OtaStatus.INSTALLATION_ERROR, errorMessage);
        }
      }
    } catch (e) {
      // Convert exceptions to proper OtaEvent
      String errorMessage = 'Update failed: ';
      if (e is Exception) {
        errorMessage += e.toString();
      } else {
        errorMessage += 'Unknown error occurred';
      }
      yield OtaEvent(OtaStatus.INSTALLATION_ERROR, errorMessage);
    }
  }

  /// Requests necessary storage permissions (Android) with comprehensive handling
  Future<bool> requestPermissions() async {
    try {
      // Request storage permission (for Android < 11)
      var storageStatus = await Permission.storage.status;
      if (!storageStatus.isGranted) {
        storageStatus = await Permission.storage.request();
      }

      // Request install packages permission (for Android 8+)
      var installStatus = await Permission.requestInstallPackages.status;
      if (!installStatus.isGranted) {
        installStatus = await Permission.requestInstallPackages.request();
      }

      // For Android 11+, we might need manage external storage
      // But let's try without it first as it's restricted
      // Only request if absolutely necessary
      bool hasStorage = storageStatus.isGranted;
      bool hasInstall = installStatus.isGranted;

      // If we have install permission, that's usually sufficient for OTA
      // Storage permission might not be needed if OtaUpdate uses internal cache
      return hasInstall || hasStorage;
    } catch (e) {
      debugPrint('Permission request error: $e');
      return false;
    }
  }

  /// Check if we have all necessary permissions without requesting
  Future<bool> hasAllPermissions() async {
    try {
      var storageStatus = await Permission.storage.status;
      var installStatus = await Permission.requestInstallPackages.status;

      return storageStatus.isGranted && installStatus.isGranted;
    } catch (e) {
      debugPrint('Permission check error: $e');
      return false;
    }
  }

  /// Get detailed permission status for better user guidance
  Future<Map<String, bool>> getPermissionStatus() async {
    try {
      var storageStatus = await Permission.storage.status;
      var installStatus = await Permission.requestInstallPackages.status;

      return {
        'storage': storageStatus.isGranted,
        'install': installStatus.isGranted,
        'allGranted': storageStatus.isGranted && installStatus.isGranted,
      };
    } catch (e) {
      debugPrint('Permission status check error: $e');
      return {'storage': false, 'install': false, 'allGranted': false};
    }
  }
}
