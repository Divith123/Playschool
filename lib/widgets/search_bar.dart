import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final bool isDarkMode;
  final VoidCallback? onFilterTap;

  const CustomSearchBar({
    super.key,
    this.hintText = 'Search...',
    this.onChanged,
    required this.isDarkMode,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight;
    final borderColor = isDarkMode ? Colors.white10 : Colors.grey[200]!;

    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderColor),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              onChanged: onChanged,
              style: AppTextStyles.bodyLarge(isDarkMode),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: AppTextStyles.bodyMedium(isDarkMode).copyWith(
                  color: isDarkMode ? Colors.grey[500] : Colors.grey[400],
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: isDarkMode ? Colors.grey[500] : Colors.grey[400],
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
          ),
        ),
        if (onFilterTap != null) ...[
          const SizedBox(width: 12),
          InkWell(
            onTap: onFilterTap,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: borderColor),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.filter_list,
                color: isDarkMode ? Colors.white : Colors.grey[700],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
