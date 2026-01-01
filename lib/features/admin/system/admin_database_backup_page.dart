import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class AdminDatabaseBackupPage extends StatelessWidget {
  const AdminDatabaseBackupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Database Health',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: isDarkMode ? AppColors.textMainDark : AppColors.textMainLight,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.cloud_done, size: 80, color: Colors.green),
            ),
            const SizedBox(height: 24),
            Text(
              'System is Healthy',
              style: AppTextStyles.headingLarge(isDarkMode),
            ),
            Text(
              'Last Backup: 2 hours ago',
              style: AppTextStyles.bodyMedium(isDarkMode),
            ),

            const SizedBox(height: 48),

            _buildActionCard(
              title: 'Manual Backup',
              desc: 'Create an immediate snapshot of the current database.',
              btnLabel: 'Backup Now',
              icon: Icons.save,
              isDarkMode: isDarkMode,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Backup Started...')),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildActionCard(
              title: 'Restore Data',
              desc:
                  'Restore database from a previous checkpoint. Warning: Data loss may occur.',
              btnLabel: 'Restore',
              icon: Icons.history,
              isDarkMode: isDarkMode,
              isDanger: true,
              onPressed: () {
                // Warning Dialog
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required String title,
    required String desc,
    required String btnLabel,
    required IconData icon,
    required bool isDarkMode,
    required VoidCallback onPressed,
    bool isDanger = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDanger
              ? Colors.red.withOpacity(0.3)
              : (isDarkMode ? Colors.white10 : Colors.grey[200]!),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: isDanger ? Colors.red : AppColors.primary),
              const SizedBox(width: 12),
              Text(
                title,
                style: AppTextStyles.headingMedium(
                  isDarkMode,
                ).copyWith(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(desc, style: AppTextStyles.bodyMedium(isDarkMode)),
          const SizedBox(height: 16),
          isDanger
              ? OutlinedButton(
                  onPressed: onPressed,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(btnLabel),
                )
              : PrimaryButton(
                  label: btnLabel,
                  onPressed: onPressed,
                  width: 140,
                ),
        ],
      ),
    );
  }
}
