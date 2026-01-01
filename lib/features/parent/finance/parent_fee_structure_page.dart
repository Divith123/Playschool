import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';
import 'package:playschool/widgets/status_badge.dart';

class ParentFeeStructurePage extends StatelessWidget {
  const ParentFeeStructurePage({super.key});

  final List<Map<String, dynamic>> _fees = const [
    {'type': 'Tuition Fee (Term 1)', 'amount': 1200, 'due': '15 Aug 2024'},
    {'type': 'Annual Material Fee', 'amount': 300, 'due': '15 Aug 2024'},
    {'type': 'Transport Fee (Aug)', 'amount': 150, 'due': '01 Aug 2024'},
    {'type': 'Meal Plan (Aug)', 'amount': 100, 'due': '01 Aug 2024'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fee Structure',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: isDarkMode ? AppColors.textMainDark : AppColors.textMainLight,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCard(isDarkMode),
            const SizedBox(height: 24),
            Text('Breakdown', style: AppTextStyles.headingMedium(isDarkMode)),
            const SizedBox(height: 16),
            ..._fees.map((f) => _buildFeeRow(f, isDarkMode)).toList(),
            const Divider(height: 48),
            Text(
              'Important Dates',
              style: AppTextStyles.headingMedium(isDarkMode),
            ),
            const SizedBox(height: 16),
            _buildTimelineItem(
              '15 Aug',
              'Term 1 Fees Due',
              isDarkMode,
              isPast: false,
            ),
            _buildTimelineItem(
              '20 Aug',
              'Late Fee applies (\$50)',
              isDarkMode,
              isPast: false,
            ),
            const SizedBox(height: 32),
            PrimaryButton(
              label: 'Pay All Due Fees (\$1750)',
              onPressed: () {},
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.secondary, Color(0xFF1e40af)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            'Total Outstanding',
            style: AppTextStyles.bodyMedium(
              false,
            ).copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 8),
          Text(
            '\$1,750.00',
            style: AppTextStyles.headingLarge(
              false,
            ).copyWith(color: Colors.white, fontSize: 36),
          ),
          const SizedBox(height: 16),
          StatusBadge(
            label: 'Payment Pending',
            type: StatusType.warning,
            isDarkMode: false,
          ),
        ],
      ),
    );
  }

  Widget _buildFeeRow(Map<String, dynamic> fee, bool isDarkMode) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode ? Colors.white10 : Colors.grey[200]!,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fee['type'],
                style: AppTextStyles.bodyLarge(
                  isDarkMode,
                ).copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                'Due: ${fee['due']}',
                style: AppTextStyles.bodyMedium(isDarkMode),
              ),
            ],
          ),
          Text(
            '\$${fee['amount']}',
            style: AppTextStyles.headingMedium(isDarkMode),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(
    String date,
    String event,
    bool isDarkMode, {
    required bool isPast,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 60,
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: isPast ? Colors.grey : AppColors.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              date,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isPast ? Colors.white : AppColors.primary,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(event, style: AppTextStyles.bodyLarge(isDarkMode)),
          ),
        ],
      ),
    );
  }
}
