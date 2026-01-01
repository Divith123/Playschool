import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';

class AdminBusinessIntelligencePage extends StatelessWidget {
  const AdminBusinessIntelligencePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Business Intelligence',
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
          children: [
            // Revenue Chart
            _buildChartCard(
              'Revenue Growth (YTD)',
              const Icon(Icons.show_chart, size: 100, color: Colors.green),
              isDarkMode,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildMetricCard(
                    'Conversion Rate',
                    '12%',
                    '+2%',
                    Colors.blue,
                    isDarkMode,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildMetricCard(
                    'Churn Rate',
                    '4%',
                    '-1%',
                    Colors.purple,
                    isDarkMode,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildChartCard(
              'Student Attendance Trends',
              const Icon(Icons.bar_chart, size: 100, color: Colors.orange),
              isDarkMode,
            ),
            const SizedBox(height: 16),
            _buildChartCard(
              'Expense Distribution',
              const Icon(Icons.pie_chart, size: 100, color: Colors.red),
              isDarkMode,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartCard(
    String title,
    Widget chartPlaceholder,
    bool isDarkMode,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDarkMode ? Colors.white10 : Colors.grey[200]!,
        ),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.headingMedium(
              isDarkMode,
            ).copyWith(fontSize: 16),
          ),
          const SizedBox(height: 16),
          Center(child: chartPlaceholder),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildMetricCard(
    String label,
    String value,
    String change,
    Color color,
    bool isDarkMode,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(change, style: TextStyle(color: color, fontSize: 12)),
        ],
      ),
    );
  }
}
