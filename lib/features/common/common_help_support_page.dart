import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class CommonHelpSupportPage extends StatelessWidget {
  const CommonHelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Help & Support',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: isDarkMode ? AppColors.textMainDark : AppColors.textMainLight,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // FAQs
          Text(
            'Frequently Asked Questions',
            style: AppTextStyles.headingMedium(isDarkMode),
          ),
          const SizedBox(height: 16),
          _buildFaqItem(
            'How do I reset my password?',
            'Go to Settings > Change Password.',
            isDarkMode,
          ),
          _buildFaqItem(
            'How do I pay fees?',
            'Navigate to Fees > Pay Now.',
            isDarkMode,
          ),
          _buildFaqItem(
            'Where are report cards?',
            'Check the "Academics" tab on your dashboard.',
            isDarkMode,
          ),

          const SizedBox(height: 32),
          Text(
            'Contact Support',
            style: AppTextStyles.headingMedium(isDarkMode),
          ),
          const SizedBox(height: 16),

          Card(
            color: isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.email, color: Colors.blue),
                    ),
                    title: Text(
                      'Email Us',
                      style: AppTextStyles.bodyLarge(
                        isDarkMode,
                      ).copyWith(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text('support@displayschool.com'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {},
                  ),
                  const Divider(),
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.phone, color: Colors.green),
                    ),
                    title: Text(
                      'Call Helpline',
                      style: AppTextStyles.bodyLarge(
                        isDarkMode,
                      ).copyWith(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text('+1 800 123 4567'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 32),
          PrimaryButton(
            label: 'Start Live Chat',
            icon: Icons.chat,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Connecting to Support Agent...')),
              );
            },
            width: double.infinity,
          ),
        ],
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer, bool isDarkMode) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isDarkMode ? Colors.white24 : Colors.grey[300]!,
        ),
      ),
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        title: Text(
          question,
          style: AppTextStyles.bodyLarge(
            isDarkMode,
          ).copyWith(fontWeight: FontWeight.bold),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(answer, style: AppTextStyles.bodyMedium(isDarkMode)),
          ),
        ],
      ),
    );
  }
}
