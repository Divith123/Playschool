import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/services/update_service.dart';
import 'package:ota_update/ota_update.dart';

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
            activeColor: AppColors.primary,
            onChanged: (val) => setState(() => _darkMode = val),
          ),
          _buildSectionHeader('Notifications', isDarkMode),
          SwitchListTile(
            title: Text(
              'Push Notifications',
              style: AppTextStyles.bodyLarge(isDarkMode),
            ),
            value: _pushNotifications,
            activeColor: AppColors.primary,
            onChanged: (val) => setState(() => _pushNotifications = val),
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
            activeColor: AppColors.primary,
            onChanged: (val) => setState(() => _emailAlerts = val),
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
          content: Text(
            'New version ${updateInfo['latestVersion']} is available.\n\n${updateInfo['releaseNotes']}',
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
    if (url.isEmpty) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setState) {
            return StreamBuilder<OtaEvent>(
              stream: UpdateService().downloadAndInstall(url),
              builder: (context, snapshot) {
                String status = 'Starting download...';
                double progress = 0.0;

                if (snapshot.hasData) {
                  final event = snapshot.data!;
                  status = event.status.toString().split('.').last;
                  if (event.value != null && event.value!.isNotEmpty) {
                    progress = (int.tryParse(event.value!) ?? 0) / 100.0;
                  }
                }

                if (snapshot.hasError) {
                  return AlertDialog(
                    title: const Text('Update Failed'),
                    content: Text('Error: ${snapshot.error}'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('Close'),
                      ),
                    ],
                  );
                }

                return AlertDialog(
                  title: const Text('Updating...'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(status),
                      const SizedBox(height: 16),
                      LinearProgressIndicator(value: progress),
                      const SizedBox(height: 8),
                      Text('${(progress * 100).toInt()}%'),
                    ],
                  ),
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
