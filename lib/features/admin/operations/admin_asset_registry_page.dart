import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/search_bar.dart';
import 'package:playschool/widgets/status_badge.dart';

class AdminAssetRegistryPage extends StatefulWidget {
  const AdminAssetRegistryPage({super.key});

  @override
  State<AdminAssetRegistryPage> createState() => _AdminAssetRegistryPageState();
}

class _AdminAssetRegistryPageState extends State<AdminAssetRegistryPage> {
  final List<Map<String, dynamic>> _assets = [
    {
      'name': 'MacBook Air M1',
      'id': 'AST-001',
      'category': 'Electronics',
      'assignedTo': 'Principal',
      'purchaseDate': 'Jan 2024',
      'status': 'Active',
      'icon': Icons.laptop_mac,
    },
    {
      'name': 'Samsung Smart TV 55"',
      'id': 'AST-002',
      'category': 'Electronics',
      'assignedTo': 'Conf Room',
      'purchaseDate': 'Feb 2024',
      'status': 'Active',
      'icon': Icons.tv,
    },
    {
      'name': 'Wooden Desk (Large)',
      'id': 'AST-003',
      'category': 'Furniture',
      'assignedTo': 'Reception',
      'purchaseDate': 'Mar 2023',
      'status': 'Damaged',
      'icon': Icons.table_restaurant,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode
        ? AppColors.backgroundDark
        : AppColors.backgroundLight;
    final surfaceColor = isDarkMode
        ? AppColors.surfaceDark
        : AppColors.surfaceLight;
    final textColor = isDarkMode
        ? AppColors.textMainDark
        : AppColors.textMainLight;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          'Asset Registry',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.qr_code_scanner, color: textColor),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomSearchBar(
              hintText: 'Search asset id or name...',
              onChanged: (val) {},
              isDarkMode: isDarkMode,
            ),
          ),

          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _assets.length,
              separatorBuilder: (ctx, i) => const SizedBox(height: 12),
              itemBuilder: (ctx, i) {
                return _buildAssetRow(
                  _assets[i],
                  surfaceColor,
                  textColor,
                  isDarkMode,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildAssetRow(
    Map<String, dynamic> asset,
    Color surfaceColor,
    Color textColor,
    bool isDarkMode,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(asset['icon'], color: AppColors.primary, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  asset['name'],
                  style: GoogleFonts.lexend(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${asset['id']} • ${asset['category']}',
                  style: GoogleFonts.lexend(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  'Assigned: ${asset['assignedTo']}',
                  style: GoogleFonts.lexend(fontSize: 12, color: textColor),
                ),
              ],
            ),
          ),
          StatusBadge(status: asset['status'], isDarkMode: isDarkMode),
        ],
      ),
    );
  }
}
