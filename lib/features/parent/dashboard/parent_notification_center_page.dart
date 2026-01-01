import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';

class ParentNotificationCenterPage extends StatelessWidget {
  const ParentNotificationCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final List<Map<String, dynamic>> notifications = [
      {
        'title': 'Homework Assigned',
        'body': 'Math homework "Addition" is due tomorrow.',
        'time': '2 hrs ago',
        'isRead': false,
      },
      {
        'title': 'Fee Payment Successful',
        'body': 'Receipt #1234 generated.',
        'time': 'Yesterday',
        'isRead': true,
      },
      {
        'title': 'School Closed',
        'body': 'School is closed tomorrow due to rain.',
        'time': '2 days ago',
        'isRead': true,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: isDarkMode ? AppColors.textMainDark : AppColors.textMainLight,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.done_all,
              color: isDarkMode
                  ? AppColors.textMainDark
                  : AppColors.textMainLight,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        separatorBuilder: (ctx, i) => const Divider(),
        itemBuilder: (context, index) {
          final notif = notifications[index];
          return Container(
            color: notif['isRead']
                ? Colors.transparent
                : (isDarkMode ? Colors.blue.withOpacity(0.1) : Colors.blue[50]),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: CircleAvatar(
                backgroundColor: isDarkMode
                    ? Colors.grey[800]
                    : Colors.grey[200],
                child: const Icon(Icons.notifications, size: 20),
              ),
              title: Text(
                notif['title'],
                style: AppTextStyles.bodyLarge(isDarkMode).copyWith(
                  fontWeight: notif['isRead']
                      ? FontWeight.normal
                      : FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    notif['body'],
                    style: AppTextStyles.bodyMedium(isDarkMode),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notif['time'],
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ],
              ),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
