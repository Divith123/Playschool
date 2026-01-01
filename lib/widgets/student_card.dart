import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';

class StudentCard extends StatelessWidget {
  final String name;
  final String grade; // e.g., "Class 2B"
  final String? avatarUrl;
  final String? status; // e.g., "Present", "Absent"
  final VoidCallback? onTap;
  final bool isDarkMode;
  final Widget? trailing;

  const StudentCard({
    super.key,
    required this.name,
    required this.grade,
    this.avatarUrl,
    this.status,
    this.onTap,
    required this.isDarkMode,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    print('Building StudentCard for $name'); // Debug print
    final bgColor = isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight;
    final borderColor = isDarkMode ? Colors.white10 : Colors.grey[200]!;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Avatar
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                image: avatarUrl != null
                    ? DecorationImage(
                        image: NetworkImage(avatarUrl!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: avatarUrl == null
                  ? Center(
                      child: Text(
                        name.substring(0, 1),
                        style: AppTextStyles.headingMedium(isDarkMode),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTextStyles.bodyLarge(
                      isDarkMode,
                    ).copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(grade, style: AppTextStyles.bodyMedium(isDarkMode)),
                ],
              ),
            ),
            // Status/Trailing
            if (trailing != null)
              trailing!
            else if (status != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? AppColors.primary.withOpacity(0.2)
                      : AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status!,
                  style: AppTextStyles.bodyMedium(isDarkMode).copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
