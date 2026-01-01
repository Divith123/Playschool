import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';
import 'package:playschool/widgets/status_badge.dart';

class AdminKeyCabinetPage extends StatefulWidget {
  const AdminKeyCabinetPage({super.key});

  @override
  State<AdminKeyCabinetPage> createState() => _AdminKeyCabinetPageState();
}

class _AdminKeyCabinetPageState extends State<AdminKeyCabinetPage> {
  final List<Map<String, dynamic>> _keys = [
    {
      'keyName': 'Main Gate',
      'status': 'Issued',
      'holder': 'Security Guard',
      'timeOut': '06:00 AM',
    },
    {
      'keyName': 'Science Lab',
      'status': 'In Cabinet',
      'holder': '-',
      'timeOut': '-',
    },
    {
      'keyName': 'Server Room',
      'status': 'In Cabinet',
      'holder': '-',
      'timeOut': '-',
    },
    {
      'keyName': 'Bus #4',
      'status': 'Issued',
      'holder': 'Driver Mike',
      'timeOut': '07:30 AM',
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
          'Key Cabinet',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _keys.length,
        separatorBuilder: (ctx, i) => const SizedBox(height: 12),
        itemBuilder: (ctx, i) {
          return _buildKeyCard(_keys[i], surfaceColor, textColor, isDarkMode);
        },
      ),
    );
  }

  Widget _buildKeyCard(
    Map<String, dynamic> keyData,
    Color surfaceColor,
    Color textColor,
    bool isDarkMode,
  ) {
    final bool isIssued = keyData['status'] == 'Issued';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isIssued
                  ? Colors.orange.withOpacity(0.1)
                  : AppColors.success.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.vpn_key,
              color: isIssued ? Colors.orange : AppColors.success,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  keyData['keyName'],
                  style: GoogleFonts.lexend(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: textColor,
                  ),
                ),
                if (isIssued)
                  Text(
                    'Held by: ${keyData['holder']}',
                    style: GoogleFonts.lexend(fontSize: 12, color: Colors.red),
                  )
                else
                  Text(
                    'Available',
                    style: GoogleFonts.lexend(fontSize: 12, color: Colors.grey),
                  ),
              ],
            ),
          ),
          if (isIssued)
            TextButton(
              onPressed: () {
                // Return flow
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Key Returned')));
              },
              child: const Text('Return'),
            )
          else
            TextButton(
              onPressed: () {
                // Issue flow
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Key Issued')));
              },
              child: const Text('Issue'),
            ),
        ],
      ),
    );
  }
}
