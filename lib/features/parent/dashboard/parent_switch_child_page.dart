import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/student_card.dart';

class ParentSwitchChildPage extends StatelessWidget {
  const ParentSwitchChildPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final List<Map<String, String>> children = [
      {'name': 'Leo Das', 'class': 'Class 2B', 'image': ''},
      {'name': 'Tina Das', 'class': 'KG 1', 'image': ''},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Switch Child Profile',
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
        itemCount: children.length + 1, // +1 for Add Child
        separatorBuilder: (ctx, i) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          if (index == children.length) {
            return _buildAddChildButton(isDarkMode);
          }
          final child = children[index];
          final isSelected = index == 0;
          return InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Switched to ${child['name']}')),
              );
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                border: isSelected
                    ? Border.all(color: AppColors.primary, width: 2)
                    : null,
                borderRadius: BorderRadius.circular(16),
              ),
              child: StudentCard(
                name: child['name']!,
                grade: child['class']!,
                isDarkMode: isDarkMode,
                trailing: isSelected
                    ? const Icon(Icons.check_circle, color: AppColors.primary)
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAddChildButton(bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDarkMode ? Colors.white10 : Colors.grey[300]!,
          style: BorderStyle.solid,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_circle, color: Colors.grey),
          const SizedBox(width: 8),
          Text(
            'Link Another Child',
            style: AppTextStyles.bodyMedium(
              isDarkMode,
            ).copyWith(fontWeight: FontWeight.bold, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
