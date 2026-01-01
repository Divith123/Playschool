import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';

class StaffClassSwitcherPage extends StatelessWidget {
  const StaffClassSwitcherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final List<String> classes = [
      'Class 2B (Primary)',
      'Class 3A (Substitute)',
      'Art Club (After School)',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Switch Class View',
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
        itemCount: classes.length,
        separatorBuilder: (ctx, i) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final cls = classes[index];
          final isSelected = index == 0;
          return InkWell(
            onTap: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Switched to $cls')));
              Navigator.pop(context); // Go back to dashboard with new context
            },
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withOpacity(0.1)
                    : (isDarkMode
                          ? AppColors.surfaceDark
                          : AppColors.surfaceLight),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? AppColors.primary : Colors.grey[200]!,
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: isSelected
                        ? AppColors.primary
                        : Colors.grey[300],
                    child: Icon(
                      Icons.class_,
                      color: isSelected ? Colors.black : Colors.grey[600],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      cls,
                      style: AppTextStyles.headingMedium(
                        isDarkMode,
                      ).copyWith(fontSize: 18),
                    ),
                  ),
                  if (isSelected)
                    const Icon(Icons.check_circle, color: AppColors.primary),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
