import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';
import 'package:playschool/widgets/search_bar.dart';

class AdminVendorManagerPage extends StatefulWidget {
  const AdminVendorManagerPage({super.key});

  @override
  State<AdminVendorManagerPage> createState() => _AdminVendorManagerPageState();
}

class _AdminVendorManagerPageState extends State<AdminVendorManagerPage> {
  final List<Map<String, dynamic>> _vendors = [
    {
      'name': 'Fresh Foods Supply',
      'category': 'Catering',
      'contact': 'Bob Miller',
      'phone': '555-0100',
      'status': 'Active',
      'contractEnd': 'Dec 2025',
    },
    {
      'name': 'CleanSweep Services',
      'category': 'Janitorial',
      'contact': 'Alice Clean',
      'phone': '555-0102',
      'status': 'Active',
      'contractEnd': 'Jun 2026',
    },
    {
      'name': 'EduTech Solutions',
      'category': 'IT Support',
      'contact': 'Tech Support',
      'phone': '555-0105',
      'status': 'Review',
      'contractEnd': 'Nov 2025',
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
          'Vendor Management',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomSearchBar(
              hintText: 'Search vendors...',
              onChanged: (val) {},
              isDarkMode: isDarkMode,
            ),
          ),

          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _vendors.length,
              separatorBuilder: (ctx, i) => const SizedBox(height: 12),
              itemBuilder: (ctx, i) {
                return _buildVendorCard(
                  _vendors[i],
                  surfaceColor,
                  textColor,
                  isDarkMode,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVendorCard(
    Map<String, dynamic> vendor,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  vendor['category'],
                  style: GoogleFonts.lexend(
                    color: AppColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildStatusBadge(vendor['status']),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            vendor['name'],
            style: GoogleFonts.lexend(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: textColor,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.person_outline, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                vendor['contact'],
                style: GoogleFonts.lexend(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(width: 16),
              Icon(Icons.phone_outlined, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                vendor['phone'],
                style: GoogleFonts.lexend(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Contract ends: ${vendor['contractEnd']}',
                style: GoogleFonts.lexend(color: Colors.grey, fontSize: 12),
              ),
              TextButton(onPressed: () {}, child: const Text('View Contract')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color = status == 'Active' ? AppColors.success : Colors.orange;
    return Text(
      status,
      style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12),
    );
  }
}
