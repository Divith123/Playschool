import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/status_badge.dart';

class AdminSystemAuditLogsPage extends StatelessWidget {
  const AdminSystemAuditLogsPage({super.key});

  final List<Map<String, dynamic>> _logs = const [
    {
      'action': 'User Login',
      'user': 'Admin (John)',
      'time': '10:00 AM',
      'status': StatusType.success,
      'ip': '192.168.1.1',
    },
    {
      'action': 'Fee Updated',
      'user': 'Admin (John)',
      'time': '10:05 AM',
      'status': StatusType.success,
      'ip': '192.168.1.1',
    },
    {
      'action': 'Failed Login',
      'user': 'Unknown',
      'time': '10:15 AM',
      'status': StatusType.error,
      'ip': '45.32.11.9',
    },
    {
      'action': 'Backup Created',
      'user': 'System',
      'time': '02:00 AM',
      'status': StatusType.info,
      'ip': 'localhost',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Security Audit Logs',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: isDarkMode ? AppColors.textMainDark : AppColors.textMainLight,
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _logs.length,
        separatorBuilder: (ctx, i) => const Divider(),
        itemBuilder: (context, index) {
          final log = _logs[index];
          return ListTile(
            contentPadding: EdgeInsets.zero,
            leading: _buildLogIcon(log['status']),
            title: Text(
              log['action'],
              style: AppTextStyles.bodyLarge(
                isDarkMode,
              ).copyWith(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '${log['user']} • ${log['time']} • IP: ${log['ip']}',
              style: AppTextStyles.bodyMedium(isDarkMode),
            ),
            trailing: StatusBadge(
              label: log['status'] == StatusType.success
                  ? 'Success'
                  : (log['status'] == StatusType.error ? 'Failed' : 'System'),
              type: log['status'],
              isDarkMode: isDarkMode,
            ),
          );
        },
      ),
    );
  }

  Widget _buildLogIcon(StatusType type) {
    IconData icon;
    Color color;

    switch (type) {
      case StatusType.success:
        icon = Icons.check_circle_outline;
        color = Colors.green;
        break;
      case StatusType.error:
        icon = Icons.error_outline;
        color = Colors.red;
        break;
      default:
        icon = Icons.info_outline;
        color = Colors.blue;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }
}
