import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/services/update_service.dart';
import 'package:ota_update/ota_update.dart';
import 'package:permission_handler/permission_handler.dart';

class AppSettingsPage extends StatefulWidget {
  const AppSettingsPage({super.key});

  @override
  State<AppSettingsPage> createState() => _AppSettingsPageState();
}

class _AppSettingsPageState extends State<AppSettingsPage> {
  bool _pushNotifications = true;
  bool _emailAlerts = false;
  bool _darkMode = false; // Mock

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: AppTextStyles.headingMedium(isDarkMode)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: isDarkMode ? AppColors.textMainDark : AppColors.textMainLight,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionHeader('Preferences', isDarkMode),
          SwitchListTile(
            title: Text(
              'Dark Mode',
              style: AppTextStyles.bodyLarge(isDarkMode),
            ),
            value: _darkMode,
            activeThumbColor: AppColors.primary,
            onChanged: (val) {
              HapticFeedback.lightImpact();
              setState(() => _darkMode = val);
            },
          ),
          _buildSectionHeader('Notifications', isDarkMode),
          SwitchListTile(
            title: Text(
              'Push Notifications',
              style: AppTextStyles.bodyLarge(isDarkMode),
            ),
            value: _pushNotifications,
            activeThumbColor: AppColors.primary,
            onChanged: (val) {
              HapticFeedback.lightImpact();
              setState(() => _pushNotifications = val);
            },
          ),
          SwitchListTile(
            title: Text(
              'Email Alerts',
              style: AppTextStyles.bodyLarge(isDarkMode),
            ),
            subtitle: Text(
              'Receive weekly summaries',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            value: _emailAlerts,
            activeThumbColor: AppColors.primary,
            onChanged: (val) {
              HapticFeedback.lightImpact();
              setState(() => _emailAlerts = val);
            },
          ),
          _buildSectionHeader('About', isDarkMode),
          ListTile(
            title: Text(
              'Check for Updates',
              style: AppTextStyles.bodyLarge(isDarkMode),
            ),
            trailing: const Icon(Icons.system_update, size: 20),
            onTap: _checkForUpdates,
          ),
          ListTile(
            title: Text('Version', style: AppTextStyles.bodyLarge(isDarkMode)),
            trailing: Text('1.0.0', style: TextStyle(color: Colors.grey)),
          ),
          ListTile(
            title: Text(
              'Terms & Conditions',
              style: AppTextStyles.bodyLarge(isDarkMode),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              'Privacy Policy',
              style: AppTextStyles.bodyLarge(isDarkMode),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          const SizedBox(height: 32),
          Center(
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Log Out',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _checkForUpdates() async {
    final updateService = UpdateService();

    // First check permissions
    final hasPermissions = await updateService.requestPermissions();
    if (!mounted) return;

    if (!hasPermissions) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Storage and installation permissions required for updates',
          ),
          duration: Duration(seconds: 3),
        ),
      );

      // Show a dialog explaining permissions
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Permissions Required'),
          content: const Text(
            'To install updates, the app needs permission to:\n\n'
            '• Access storage (to download the update)\n'
            '• Install apps from unknown sources\n\n'
            'Please enable these permissions in your device settings.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Continue Anyway'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                // Open app settings
                openAppSettings();
              },
              child: const Text('Open Settings'),
            ),
          ],
        ),
      );
      if (!mounted) return;
    }

    // Show loading
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Checking for updates...')));

    final updateInfo = await updateService.checkForUpdate();

    if (!mounted) return;

    if (updateInfo != null && updateInfo['updateAvailable'] == true) {
      // Show update dialog
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Update Available'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Version: ${updateInfo['latestVersion']}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  updateInfo['releaseNotes'] ?? 'No release notes available',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Later'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                _downloadUpdate(updateInfo['downloadUrl']);
              },
              child: const Text('Update Now'),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('App is up to date!')));
    }
  }

  void _downloadUpdate(String url) {
    if (url.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Invalid download URL')));
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setState) {
            return StreamBuilder<OtaEvent>(
              stream: UpdateService().downloadAndInstall(url),
              builder: (context, snapshot) {
                String status = 'Preparing update...';
                double progress = 0.0;
                bool hasError = false;
                String errorMessage = '';
                bool showManualInstructions = false;

                if (snapshot.hasData) {
                  final event = snapshot.data!;

                  switch (event.status) {
                    case OtaStatus.DOWNLOADING:
                      status = 'Downloading...';
                      progress =
                          (int.tryParse(event.value ?? '0') ?? 0) / 100.0;
                      break;
                    case OtaStatus.INSTALLING:
                      status = 'Installing...';
                      progress = 1.0;
                      break;
                    case OtaStatus.INSTALLATION_DONE: // Was completed
                      status =
                          'Update completed! You may need to manually install.';
                      progress = 1.0;
                      showManualInstructions = true;
                      break;
                    case OtaStatus.INSTALLATION_ERROR: // Was failed
                      hasError = true;
                      errorMessage = event.value ?? 'Update failed';
                      showManualInstructions = true;
                      break;
                    case OtaStatus.PERMISSION_NOT_GRANTED_ERROR:
                      hasError = true;
                      errorMessage =
                          'Permissions required. Please enable storage and installation permissions in app settings.';
                      showManualInstructions = true;
                      break;
                    default:
                      status = event.status.toString().split('.').last;
                      if (event.value != null && event.value!.isNotEmpty) {
                        progress = (int.tryParse(event.value!) ?? 0) / 100.0;
                      }
                  }
                }

                if (snapshot.hasError || hasError) {
                  return FutureBuilder<String>(
                    future: UpdateService().getInstallationInstructions(url),
                    builder: (context, instructionsSnapshot) {
                      final instructions =
                          instructionsSnapshot.data ??
                          'Loading instructions...';

                      return AlertDialog(
                        title: const Text('Update Issue'),
                        content: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                snapshot.hasError
                                    ? 'Error: ${snapshot.error}'
                                    : errorMessage,
                                style: const TextStyle(color: Colors.red),
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'Manual installation required:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text(instructions),
                              const SizedBox(height: 8),
                              const Text(
                                'Note: After manual installation, you may need to restart the app.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: const Text('Close'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(ctx);
                              _downloadUpdate(url); // Retry
                            },
                            child: const Text('Try Again'),
                          ),
                        ],
                      );
                    },
                  );
                }

                return AlertDialog(
                  title: const Text('Updating App'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(status, textAlign: TextAlign.center),
                      const SizedBox(height: 16),
                      LinearProgressIndicator(value: progress, minHeight: 8),
                      const SizedBox(height: 8),
                      Text('${(progress * 100).toInt()}%'),
                      if (progress > 0 && progress < 1)
                        const SizedBox(height: 8),
                      if (progress > 0 && progress < 1)
                        const Text(
                          'Please do not close the app',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      if (showManualInstructions)
                        FutureBuilder<String>(
                          future: UpdateService().getInstallationInstructions(
                            url,
                          ),
                          builder: (context, instructionsSnapshot) {
                            if (instructionsSnapshot.hasData) {
                              return Column(
                                children: [
                                  const SizedBox(height: 8),
                                  Text(
                                    'Next steps:',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[700],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '1. Check your notifications\n2. Tap the downloaded file\n3. Install when prompted',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey[600],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                    ],
                  ),
                  actions: [
                    if (progress == 0)
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('Cancel'),
                      ),
                    if (progress == 1.0)
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('OK'),
                      ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildSectionHeader(String title, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        title,
        style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
      ),
    );
  }
}
