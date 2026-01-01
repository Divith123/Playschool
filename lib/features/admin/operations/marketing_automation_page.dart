import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';

class MarketingAutomationPage extends StatefulWidget {
  const MarketingAutomationPage({super.key});

  @override
  State<MarketingAutomationPage> createState() =>
      _MarketingAutomationPageState();
}

class _MarketingAutomationPageState extends State<MarketingAutomationPage> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lead Campaigns',
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
          _buildCampaignCard(
            'Open House Invite',
            'Email & SMS',
            'Sent to 150 prospects',
            'Completed',
            Colors.green,
            isDarkMode,
          ),
          _buildCampaignCard(
            'Summer Camp Early Bird',
            'WhatsApp',
            'Scheduled for Tomorrow',
            'Pending',
            Colors.orange,
            isDarkMode,
          ),
          _buildCampaignCard(
            'Admission Follow-up',
            'Call List',
            'Active - 25 Calls Pending',
            'In Progress',
            Colors.blue,
            isDarkMode,
          ),

          const SizedBox(height: 32),
          Text(
            'Create New Campaign',
            style: AppTextStyles.headingMedium(isDarkMode),
          ),
          const SizedBox(height: 16),
          _buildActionTile(
            Icons.email,
            'Email Blast',
            'Send newsletters or announcements',
            isDarkMode,
          ),
          _buildActionTile(
            Icons.message,
            'SMS Broadcast',
            'Urgent updates or reminders',
            isDarkMode,
          ),
          _buildActionTile(
            Icons.chat,
            'WhatsApp Campaign',
            'Rich media messages',
            isDarkMode,
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignCard(
    String title,
    String type,
    String stats,
    String status,
    Color color,
    bool isDarkMode,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppTextStyles.headingMedium(
                    isDarkMode,
                  ).copyWith(fontSize: 16),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('$type • $stats', style: AppTextStyles.bodyMedium(isDarkMode)),
          ],
        ),
      ),
    );
  }

  Widget _buildActionTile(
    IconData icon,
    String title,
    String sub,
    bool isDarkMode,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isDarkMode ? Colors.white24 : Colors.grey[300]!,
        ),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.primary),
        ),
        title: Text(
          title,
          style: AppTextStyles.bodyLarge(
            isDarkMode,
          ).copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(sub, style: AppTextStyles.bodyMedium(isDarkMode)),
        onTap: () {},
      ),
    );
  }
}
