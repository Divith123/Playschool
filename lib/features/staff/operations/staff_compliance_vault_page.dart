import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';

class StaffComplianceVaultPage extends StatelessWidget {
  const StaffComplianceVaultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Compliance Vault',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: isDarkMode ? AppColors.textMainDark : AppColors.textMainLight,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCategory('Documents', [
            'Teacher Certification.pdf',
            'Backround Check Clearance.pdf',
            'First Aid Training Certificate.png',
          ], isDarkMode),
          _buildCategory('Policies', [
            'Child Protection Policy v2.pdf',
            'Staff Code of Conduct.pdf',
            'Emergency Evacuation Plan.pdf',
          ], isDarkMode),
          _buildCategory('Training', [
            'Diversity Workshop - Completed',
            'Fire Safety Drill - Pending',
          ], isDarkMode),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.upload_file),
      ),
    );
  }

  Widget _buildCategory(String title, List<String> items, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.headingMedium(isDarkMode).copyWith(fontSize: 18),
        ),
        const SizedBox(height: 12),
        ...items.map((item) => _buildDocItem(item, isDarkMode)).toList(),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildDocItem(String name, bool isDarkMode) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode ? Colors.white10 : Colors.grey[200]!,
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.description, color: Colors.blue),
          const SizedBox(width: 12),
          Expanded(
            child: Text(name, style: AppTextStyles.bodyMedium(isDarkMode)),
          ),
          Icon(Icons.download, color: Colors.grey, size: 20),
        ],
      ),
    );
  }
}
