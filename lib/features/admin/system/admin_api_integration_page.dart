import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class AdminApiIntegrationPage extends StatefulWidget {
  const AdminApiIntegrationPage({super.key});

  @override
  State<AdminApiIntegrationPage> createState() =>
      _AdminApiIntegrationPageState();
}

class _AdminApiIntegrationPageState extends State<AdminApiIntegrationPage> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode
        ? AppColors.backgroundDark
        : AppColors.backgroundLight;
    final surfaceColor = isDarkMode
        ? AppColors.surfaceDark
        : AppColors.surfaceLight;
    final textColor = isDarkMode
        ? AppColors.textMainDark
        : AppColors.textMainLight;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          'API & Integrations',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildIntegrationCard(
              'Stripe Payments',
              'Active',
              'Last synced: 2 mins ago',
              Icons.payment,
              AppColors.success,
              surfaceColor,
              textColor,
            ),
            const SizedBox(height: 16),
            _buildIntegrationCard(
              'Twilio SMS',
              'Active',
              'Balance: \$45.00',
              Icons.message,
              AppColors.success,
              surfaceColor,
              textColor,
            ),
            const SizedBox(height: 16),
            _buildIntegrationCard(
              'Google Authenticator',
              'Inactive',
              'Setup Required',
              Icons.security,
              Colors.grey,
              surfaceColor,
              textColor,
            ),
            const SizedBox(height: 32),

            Container(
              padding: const EdgeInsets.all(24),
              width: double.infinity,
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Developer Webhooks',
                    style: GoogleFonts.lexend(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    style: TextStyle(color: textColor),
                    decoration: InputDecoration(
                      labelText: 'Webhook URL',
                      hintText: 'https://myserver.com/hooks',
                      filled: true,
                      fillColor: bgColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  PrimaryButton(
                    label: 'Save & Test Webhook',
                    onPressed: () {},
                    width: double.infinity,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIntegrationCard(
    String title,
    String status,
    String subtext,
    IconData icon,
    Color color,
    Color surfaceColor,
    Color textColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.lexend(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: textColor,
                  ),
                ),
                Text(
                  subtext,
                  style: GoogleFonts.lexend(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),
          Switch(
            value: status == 'Active',
            activeThumbColor: AppColors.primary,
            onChanged: (val) {},
          ),
        ],
      ),
    );
  }
}
