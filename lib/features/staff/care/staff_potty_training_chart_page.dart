import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class StaffPottyTrainingChartPage extends StatefulWidget {
  const StaffPottyTrainingChartPage({super.key});

  @override
  State<StaffPottyTrainingChartPage> createState() =>
      _StaffPottyTrainingChartPageState();
}

class _StaffPottyTrainingChartPageState
    extends State<StaffPottyTrainingChartPage> {
  final List<Map<String, dynamic>> _records = [
    {'time': '09:30 AM', 'type': 'Wet', 'success': true},
    {'time': '11:00 AM', 'type': 'Solid', 'success': false},
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
          'Potty Training Log',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
      ),
      body: Column(
        children: [
          // Student Selector (Mock)
          Container(
            padding: const EdgeInsets.all(16),
            color: surfaceColor,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.purple.withOpacity(0.2),
                  child: Text('JS', style: TextStyle(color: Colors.purple)),
                ),
                const SizedBox(width: 12),
                Text(
                  'Jeremy Smith (Toddler A)',
                  style: GoogleFonts.lexend(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildSectionHeader('Log New Event', textColor),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildLogButton('Wet', Icons.water_drop, Colors.blue),
                    _buildLogButton('Solid', Icons.circle, Colors.brown),
                    _buildLogButton(
                      'Dry',
                      Icons.check_circle_outline,
                      Colors.green,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildSectionHeader('Today\'s History', textColor),
                const SizedBox(height: 12),
                ..._records.map(
                  (r) => _buildRecordCard(r, surfaceColor, textColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, Color textColor) {
    return Text(
      title,
      style: GoogleFonts.lexend(
        fontWeight: FontWeight.bold,
        color: textColor,
        fontSize: 18,
      ),
    );
  }

  Widget _buildLogButton(String label, IconData icon, Color color) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _records.insert(0, {
                'time': '${TimeOfDay.now().format(context)}',
                'type': label,
                'success': label != 'Dry' ? true : false,
              });
            });
          },
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(color: color.withOpacity(0.5), width: 2),
            ),
            child: Icon(icon, color: color, size: 32),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildRecordCard(
    Map<String, dynamic> record,
    Color surfaceColor,
    Color textColor,
  ) {
    bool isSuccess = record['success'];
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: Colors.grey),
              const SizedBox(width: 8),
              Text(
                record['time'],
                style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
              ),
            ],
          ),
          Row(
            children: [
              Text(record['type'], style: TextStyle(color: textColor)),
              const SizedBox(width: 12),
              isSuccess
                  ? Icon(Icons.thumb_up, color: AppColors.success, size: 20)
                  : Icon(
                      Icons.thumb_down_off_alt,
                      color: Colors.orange,
                      size: 20,
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
