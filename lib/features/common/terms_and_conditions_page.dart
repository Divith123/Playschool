import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Terms & Conditions',
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
              'Terms of Use',
              style: AppTextStyles.headingMedium(isDarkMode),
            ),
            const SizedBox(height: 16),
            Text(
              'Welcome to Playschool. By using this app, you agree to the following terms:',
              style: AppTextStyles.bodyLarge(isDarkMode),
            ),
            const SizedBox(height: 24),
            _buildTerm(
              '1. Acceptable Use',
              'You agree to use the app only for lawful purposes related to school activities.',
              isDarkMode,
            ),
            _buildTerm(
              '2. User Accounts',
              'You are responsible for maintaining the confidentiality of your account credentials.',
              isDarkMode,
            ),
            _buildTerm(
              '3. Content',
              'Users must not upload inappropriate or offensive content.',
              isDarkMode,
            ),
            _buildTerm(
              '4. Termination',
              'We reserve the right to terminate accounts that violate these terms.',
              isDarkMode,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTerm(String title, String desc, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.bodyLarge(
              isDarkMode,
            ).copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(desc, style: AppTextStyles.bodyMedium(isDarkMode)),
        ],
      ),
    );
  }
}
