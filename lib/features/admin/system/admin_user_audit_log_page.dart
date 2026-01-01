import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/search_bar.dart';

class AdminUserAuditLogPage extends StatefulWidget {
  const AdminUserAuditLogPage({super.key});

  @override
  State<AdminUserAuditLogPage> createState() => _AdminUserAuditLogPageState();
}

class _AdminUserAuditLogPageState extends State<AdminUserAuditLogPage> {
  final List<Map<String, dynamic>> _logs = [
    {
      'user': 'Admin Admin',
      'action': 'Deleted Student Record',
      'target': 'ID: #9921',
      'time': '10:45 AM',
      'ip': '192.168.1.5',
    },
    {
      'user': 'Sarah Teacher',
      'action': 'Updated Grades',
      'target': 'Class 5B',
      'time': '09:30 AM',
      'ip': '192.168.1.12',
    },
    {
      'user': 'Driver Mike',
      'action': 'Logged Trip',
      'target': 'Route #4',
      'time': '08:15 AM',
      'ip': 'Mobile IP',
    },
  ];

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
          'Security & Audit Logs',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.download, color: textColor),
            tooltip: 'Export CSV',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomSearchBar(
              hintText: 'Search logs (User, Action, IP)...',
              onChanged: (val) {},
              isDarkMode: isDarkMode,
            ),
          ),

          Expanded(
            child: ListView.separated(
              itemCount: _logs.length,
              separatorBuilder: (ctx, i) =>
                  Divider(color: Colors.grey.withOpacity(0.1), height: 1),
              itemBuilder: (context, index) {
                final log = _logs[index];
                return Container(
                  color: surfaceColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.history,
                          color: Colors.blue,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${log['user']} • ${log['action']}',
                              style: GoogleFonts.lexend(
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                            Text(
                              'Target: ${log['target']}',
                              style: GoogleFonts.lexend(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            log['time'],
                            style: GoogleFonts.lexend(
                              fontWeight: FontWeight.bold,
                              color: textColor,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            log['ip'],
                            style: GoogleFonts.lexend(
                              color: Colors.grey,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
