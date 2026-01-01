import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/student_card.dart';

class AdminClassManagerPage extends StatelessWidget {
  const AdminClassManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Class Manager - 2B',
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
              Icons.edit,
              color: isDarkMode
                  ? AppColors.textMainDark
                  : AppColors.textMainLight,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Stats
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStat('Total Students', '24', isDarkMode),
                _buildStat('Boys', '12', isDarkMode),
                _buildStat('Girls', '12', isDarkMode),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 10, // Mock
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: StudentCard(
                    name: 'Student ${index + 1}',
                    grade: '2B',
                    isDarkMode: isDarkMode,
                    trailing: IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {},
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value, bool isDarkMode) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.headingLarge(
            isDarkMode,
          ).copyWith(color: AppColors.primary),
        ),
        Text(label, style: AppTextStyles.bodyMedium(isDarkMode)),
      ],
    );
  }
}
