import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';

class StaffDailyAgendaPage extends StatelessWidget {
  const StaffDailyAgendaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Daily Agenda',
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
          _buildTimeSlot(
            '08:00 AM',
            'Morning Assembly',
            'Main Hall',
            isDone: true,
            isDarkMode: isDarkMode,
          ),
          _buildTimeSlot(
            '09:00 AM',
            'English Class (2B)',
            'Room 101',
            isCurrent: true,
            isDarkMode: isDarkMode,
          ),
          _buildTimeSlot(
            '10:30 AM',
            'Snack Break Duty',
            'Playground',
            isDarkMode: isDarkMode,
          ),
          _buildTimeSlot(
            '11:00 AM',
            'Math Class (2B)',
            'Room 101',
            isDarkMode: isDarkMode,
          ),
          _buildTimeSlot(
            '01:00 PM',
            'Lunch Break',
            'Staff Room',
            isDarkMode: isDarkMode,
          ),
          _buildTimeSlot(
            '02:00 PM',
            'Art & Craft',
            'Art Studio',
            isDarkMode: isDarkMode,
          ),
          _buildTimeSlot(
            '03:30 PM',
            'Bus Duty',
            'Gate 2',
            isDarkMode: isDarkMode,
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSlot(
    String time,
    String activity,
    String loc, {
    bool isDone = false,
    bool isCurrent = false,
    required bool isDarkMode,
  }) {
    Color color = isDone
        ? Colors.green
        : (isCurrent ? AppColors.primary : Colors.grey);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  time,
                  style: TextStyle(fontWeight: FontWeight.bold, color: color),
                ),
                if (isCurrent)
                  Text(
                    'NOW',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              Expanded(child: Container(width: 2, color: Colors.grey[300])),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 24),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isCurrent
                    ? Colors.blue.withValues(alpha: 0.1)
                    : (isDarkMode
                          ? AppColors.surfaceDark
                          : AppColors.surfaceLight),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isCurrent
                      ? Colors.blue.withValues(alpha: 0.5)
                      : Colors.transparent,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activity,
                    style: AppTextStyles.bodyLarge(
                      isDarkMode,
                    ).copyWith(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(loc, style: AppTextStyles.bodyMedium(isDarkMode)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
