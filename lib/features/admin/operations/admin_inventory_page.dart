import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';
import 'package:playschool/widgets/search_bar.dart';
import 'package:playschool/widgets/status_badge.dart';

class AdminInventoryPage extends StatefulWidget {
  const AdminInventoryPage({super.key});

  @override
  State<AdminInventoryPage> createState() => _AdminInventoryPageState();
}

class _AdminInventoryPageState extends State<AdminInventoryPage> {
  final List<Map<String, dynamic>> _inventory = [
    {
      'name': 'A4 Paper Reams',
      'qty': 45,
      'reorder': 10,
      'status': StatusType.success,
      'category': 'Stationery',
    },
    {
      'name': 'Whiteboard Markers',
      'qty': 12,
      'reorder': 15,
      'status': StatusType.warning,
      'category': 'Stationery',
    },
    {
      'name': 'Diapers (Size 4)',
      'qty': 5,
      'reorder': 20,
      'status': StatusType.error,
      'category': 'Hygiene',
    },
    {
      'name': 'Art Paint Set',
      'qty': 30,
      'reorder': 5,
      'status': StatusType.success,
      'category': 'Art Supplies',
    },
    {
      'name': 'Hand Sanitizer (5L)',
      'qty': 2,
      'reorder': 3,
      'status': StatusType.warning,
      'category': 'Hygiene',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inventory Management',
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
                Expanded(child: CustomSearchBar(isDarkMode: isDarkMode)),
                const SizedBox(width: 12),
                PrimaryButton(
                  label: 'Add Item',
                  icon: Icons.add,
                  onPressed: () {},
                  width: 140, // Compact button
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _inventory.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = _inventory[index];
                return _buildStockCard(item, isDarkMode);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStockCard(Map<String, dynamic> item, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.inventory_2, color: AppColors.primary, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'],
                  style: AppTextStyles.bodyLarge(
                    isDarkMode,
                  ).copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Qty: ${item['qty']} • Reorder Level: ${item['reorder']}',
                  style: AppTextStyles.bodyMedium(isDarkMode),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              StatusBadge(
                label: item['status'] == StatusType.error
                    ? 'Out of Stock'
                    : (item['status'] == StatusType.warning
                          ? 'Low Stock'
                          : 'In Stock'),
                type: item['status'],
                isDarkMode: isDarkMode,
              ),
              if (item['status'] == StatusType.error ||
                  item['status'] == StatusType.warning) ...[
                const SizedBox(height: 8),
                InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Purchase Request Sent to Supplier!'),
                      ),
                    );
                  },
                  child: Text(
                    'Request Purchase',
                    style: AppTextStyles.bodyMedium(isDarkMode).copyWith(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
