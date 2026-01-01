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

  // Custom headers if the repo is private (requires PAT)
  // static const Map<String, String> _headers = {'Authorization': 'token YOUR_PAT'};

  /// Checks if a new version is available on GitHub Releases
  Future<Map<String, dynamic>?> checkForUpdate() async {
    try {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final String currentVersion = packageInfo.version;

      final Uri url = Uri.parse(
        'https://api.github.com/repos/$_githubOwner/$_githubRepo/releases/latest',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> releaseData = json.decode(response.body);
        final String latestTag = releaseData['tag_name'] ?? 'v0.0.0';

        // Remove 'v' prefix if present for comparison
        final String cleanLatest = latestTag.replaceAll('v', '');
        final String cleanCurrent = currentVersion.replaceAll('v', '');

        if (_isNewer(cleanLatest, cleanCurrent)) {
          // Find APK asset
          String? downloadUrl;
          if (releaseData['assets'] != null) {
            for (var asset in releaseData['assets']) {
              if (asset['name'].toString().endsWith('.apk')) {
                downloadUrl = asset['browser_download_url'];
                break;
              }
            }
          }

          if (downloadUrl != null) {
            return {
              'updateAvailable': true,
              'latestVersion': latestTag,
              'releaseNotes': releaseData['body'],
              'downloadUrl': downloadUrl,
            };
          }
        }
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
    List<int> l = latest.split('.').map((e) => int.tryParse(e) ?? 0).toList();
    List<int> c = current.split('.').map((e) => int.tryParse(e) ?? 0).toList();

    // Pad with zeros to ensure equal length
    while (l.length < 3) l.add(0);
    while (c.length < 3) c.add(0);

    for (int i = 0; i < 3; i++) {
      if (l[i] > c[i]) return true;
      if (l[i] < c[i]) return false;
    }
    return false;
  }

  /// Triggers the OTA download and install
  Stream<OtaEvent> downloadAndInstall(String url) {
    return OtaUpdate().execute(
      url,
      destinationFilename: 'playschool_update.apk',
    );
  }

  /// Requests necessary storage permissions (Android)
  Future<bool> requestPermissions() async {
    if (await Permission.storage.request().isGranted) {
      return true;
    }
    // For Android 11+ (Manage External Storage might be needed for some paths,
    // but usually OtaUpdate handles internal/public dir)
    // Checking requestInstallPackages for Android 8+
    if (await Permission.requestInstallPackages.request().isGranted) {
      return true;
    }
    return false;
  }
}
