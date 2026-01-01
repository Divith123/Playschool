import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';

class AdminSchoolCalendarPage extends StatefulWidget {
  const AdminSchoolCalendarPage({super.key});

  @override
  State<AdminSchoolCalendarPage> createState() =>
      _AdminSchoolCalendarPageState();
}

class _AdminSchoolCalendarPageState extends State<AdminSchoolCalendarPage> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Academic Calendar',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: isDarkMode ? AppColors.textMainDark : AppColors.textMainLight,
        ),
      ),
      body: Column(
        children: [
          CalendarDatePicker(
            initialDate: _selectedDate,
            firstDate: DateTime(2020),
            lastDate: DateTime(2030),
            onDateChanged: (date) => setState(() => _selectedDate = date),
          ),
          const Divider(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  'Events on ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                  style: AppTextStyles.headingMedium(
                    isDarkMode,
                  ).copyWith(fontSize: 18),
                ),
                const SizedBox(height: 16),
                _buildEventItem(
                  '09:00 AM',
                  'Assembly',
                  Colors.blue,
                  isDarkMode,
                ),
                _buildEventItem(
                  '11:00 AM',
                  'Staff Meeting',
                  Colors.orange,
                  isDarkMode,
                ),
                if (_selectedDate.day == 25)
                  _buildEventItem(
                    'All Day',
                    'Christmas Holiday',
                    Colors.red,
                    isDarkMode,
                  ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEventItem(
    String time,
    String title,
    Color color,
    bool isDarkMode,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: color, width: 4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            time,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(width: 16),
          Text(title, style: AppTextStyles.bodyLarge(isDarkMode)),
        ],
      ),
    );
  }
}
