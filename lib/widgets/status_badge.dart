import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';

enum StatusType { success, warning, error, info, neutral }

class StatusBadge extends StatelessWidget {
  final String? label;
  final StatusType? type;
  final String? status;
  final bool isDarkMode;

  const StatusBadge({
    super.key,
    this.label,
    this.type,
    this.status,
    required this.isDarkMode,
  });

  static StatusType _getTypeFromStatus(String status) {
    final s = status.toLowerCase();
    if (s.contains('approv') ||
        s.contains('paid') ||
        s.contains('complete') ||
        s.contains('success') ||
        s.contains('signed') ||
        s.contains('present') ||
        s.contains('good') ||
        s.contains('active')) {
      return StatusType.success;
    }
    if (s.contains('pend') ||
        s.contains('wait') ||
        s.contains('progress') ||
        s.contains('upcoming') ||
        s.contains('due')) {
      return StatusType.warning;
    }
    if (s.contains('reject') ||
        s.contains('overdue') ||
        s.contains('fail') ||
        s.contains('missed') ||
        s.contains('absent') ||
        s.contains('high') ||
        s.contains('fever')) {
      return StatusType.error;
    }
    if (s.contains('info') || s.contains('neutral') || s.contains('normal')) {
      return StatusType.info;
    }
    return StatusType.neutral;
  }

  @override
  Widget build(BuildContext context) {
    // Logic to determine what to show
    final displayLabel = label ?? status ?? 'Unknown';
    // If type is not provided, derive it from the label/status
    final displayType = type ?? _getTypeFromStatus(displayLabel);

    Color bgColor;
    Color textColor;

    switch (displayType) {
      case StatusType.success:
        bgColor = isDarkMode ? Colors.green[900]! : Colors.green[100]!;
        textColor = isDarkMode ? Colors.green[100]! : Colors.green[800]!;
        break;
      case StatusType.warning:
        bgColor = isDarkMode ? Colors.orange[900]! : Colors.orange[100]!;
        textColor = isDarkMode ? Colors.orange[100]! : Colors.orange[800]!;
        break;
      case StatusType.error:
        bgColor = isDarkMode ? Colors.red[900]! : Colors.red[100]!;
        textColor = isDarkMode ? Colors.red[100]! : Colors.red[800]!;
        break;
      case StatusType.info:
        bgColor = isDarkMode ? Colors.blue[900]! : Colors.blue[100]!;
        textColor = isDarkMode ? Colors.blue[100]! : Colors.blue[800]!;
        break;
      case StatusType.neutral:
        bgColor = isDarkMode ? Colors.grey[800]! : Colors.grey[200]!;
        textColor = isDarkMode ? Colors.grey[300]! : Colors.grey[700]!;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor.withValues(alpha: isDarkMode ? 0.3 : 1.0),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: textColor.withValues(alpha: 0.2)),
      ),
      child: Text(
        displayLabel,
        style: AppTextStyles.bodyMedium(
          isDarkMode,
        ).copyWith(color: textColor, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }
}
