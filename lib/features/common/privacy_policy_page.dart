import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Privacy Policy',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy for Playschool App',
              style: AppTextStyles.headingMedium(isDarkMode),
            ),
            const SizedBox(height: 16),
            Text(
              'Last updated: January 2026',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Text(
              '1. Information Collection',
              style: AppTextStyles.headingMedium(
                isDarkMode,
              ).copyWith(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'We collect information solely for the purpose of school management and student safety. This includes names, contacts, and health logs.',
              style: AppTextStyles.bodyLarge(isDarkMode),
            ),

            const SizedBox(height: 24),
            Text(
              '2. Data Security',
              style: AppTextStyles.headingMedium(
                isDarkMode,
              ).copyWith(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'All data is encrypted and stored securely. We do not share data with third parties.',
              style: AppTextStyles.bodyLarge(isDarkMode),
            ),

            const SizedBox(height: 24),
            Text(
              '3. Parental Rights',
              style: AppTextStyles.headingMedium(
                isDarkMode,
              ).copyWith(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Parents have the right to access and request correction of their child\'s data.',
              style: AppTextStyles.bodyLarge(isDarkMode),
            ),
          ],
        ),
      ),
    );
  }
}
