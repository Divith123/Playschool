import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:http/http.dart' as http;
import 'package:ota_update/ota_update.dart';
import 'package:permission_handler/permission_handler.dart';

class UpdateService {
  // CONFIGURATION
  static const String _owner = 'Divith123'; // Replace with actual owner
  static const String _repo = 'Playschool'; // Replace with actual repo name
  static const String _releasesUrl =
      'https://api.github.com/repos/$_owner/$_repo/releases/latest';

  /// checks for update and returns Map or null
  /// returns {'tagName': 'v1.0.1', 'body': 'changelog...', 'assetUrl': '...'}
  Future<Map<String, dynamic>?> checkForUpdate() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String currentVersion = packageInfo.version;

      debugPrint('Current Version: $currentVersion');

      final response = await http.get(Uri.parse(_releasesUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        String tagName = data['tag_name'] ?? '';

        // Remove 'v' prefix if present
        String cleanTagName = tagName.replaceAll('v', '');

        if (_isNewVersion(cleanTagName, currentVersion)) {
          // Find APK asset
          List assets = data['assets'] ?? [];
          String? apkUrl;
          for (var asset in assets) {
            if (asset['name'].toString().endsWith('.apk')) {
              apkUrl = asset['browser_download_url'];
              break;
            }
          }

          if (apkUrl != null) {
            return {
              'tagName': tagName,
              'body': data['body'] ?? 'New update available.',
              'assetUrl': apkUrl,
              'currentVersion': currentVersion,
            };
          }
        }
      }
    } catch (e) {
      debugPrint('Error checking for updates: $e');
    }
    return null;
  }

  bool _isNewVersion(String newVersion, String currentVersion) {
    try {
      List<int> newV = newVersion.split('.').map((e) => int.parse(e)).toList();
      List<int> currV = currentVersion
          .split('.')
          .map((e) => int.parse(e))
          .toList();

      for (int i = 0; i < newV.length && i < currV.length; i++) {
        if (newV[i] > currV[i]) return true;
        if (newV[i] < currV[i]) return false;
      }
      return newV.length > currV.length;
    } catch (e) {
      return false; // Version format error
    }
  }

  Future<void> showUpdateDialog(BuildContext context) async {
    // Only verify on Android for now as ota_update is for Android
    if (!Platform.isAndroid) return;

    final updateData = await checkForUpdate();
    if (updateData != null && context.mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Update Available (${updateData['tagName']})'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('A new version is available for download.'),
                SizedBox(height: 8),
                Text(
                  'Changelog:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(updateData['body']),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Later'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _startUpdate(context, updateData['assetUrl']);
              },
              child: Text('Update Now'),
            ),
          ],
        ),
      );
    } else {
      // debugPrint('No update found');
    }
  }

  Future<void> _startUpdate(BuildContext context, String url) async {
    // Request storage permission if needed (Android < 10)
    // For Android 11+ scoped storage usually handles this, but install packages permission is managed by OS prompt triggered by intent?
    // Actually ota_update handles the notification and download.
    // However, we might need requestInstallPackages permission or Storage.

    // ota_update will start download.

    var status = await Permission.storage.request();
    if (status.isGranted ||
        await Permission.storage.isLimited ||
        Platform.isAndroid) {
      // Platform.isAndroid check is loose, but let's try.
      try {
        OtaUpdate()
            .execute(url, destinationFilename: 'playschool_update.apk')
            .listen((OtaEvent event) {
              // You could show a progress dialog here
              debugPrint('OTA Status: ${event.status} : ${event.value}');
            });
      } catch (e) {
        debugPrint('Failed to update: $e');
      }
    }
  }
}
