import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';
import 'package:playschool/widgets/search_bar.dart';

class AdminExpenseCategoriesPage extends StatefulWidget {
  const AdminExpenseCategoriesPage({super.key});

  @override
  State<AdminExpenseCategoriesPage> createState() =>
      _AdminExpenseCategoriesPageState();
}

class _AdminExpenseCategoriesPageState
    extends State<AdminExpenseCategoriesPage> {
  final List<Map<String, dynamic>> _budgets = [
    {
      'category': 'Rent & Facilities',
      'allocated': 5000,
      'spent': 5000,
      'percent': 1.0,
      'color': Colors.red,
    },
    {
      'category': 'Staff Salaries',
      'allocated': 15000,
      'spent': 14200,
      'percent': 0.94,
      'color': Colors.orange,
    },
    {
      'category': 'Food & Snacks',
      'allocated': 2000,
      'spent': 1200,
      'percent': 0.6,
      'color': Colors.blue,
    },
    {
      'category': 'Maintenance',
      'allocated': 1000,
      'spent': 200,
      'percent': 0.2,
      'color': Colors.green,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expense & Budgeting',
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: CustomSearchBar(
                    isDarkMode: isDarkMode,
                    hintText: 'Search Categories...',
                  ),
                ),
                const SizedBox(width: 12),
                PrimaryButton(
                  label: 'New Category',
                  icon: Icons.add,
                  width: 160,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _budgets.length,
              separatorBuilder: (ctx, i) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return _buildBudgetCard(_budgets[index], isDarkMode);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetCard(Map<String, dynamic> item, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDarkMode ? Colors.white10 : Colors.grey[200]!,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item['category'],
                style: AppTextStyles.headingMedium(
                  isDarkMode,
                ).copyWith(fontSize: 18),
              ),
              Text(
                '\$${item['spent']} / \$${item['allocated']}',
                style: AppTextStyles.bodyMedium(
                  isDarkMode,
                ).copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: item['percent'],
              minHeight: 10,
              backgroundColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(item['color']),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${(item['percent'] * 100).toInt()}% of budget used',
            style: AppTextStyles.bodyMedium(
              isDarkMode,
            ).copyWith(color: item['color'], fontSize: 12),
          ),
        ],
      ),
    );
  }
}
