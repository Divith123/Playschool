import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';

class ParentSchoolHandbookPage extends StatefulWidget {
  const ParentSchoolHandbookPage({super.key});

  @override
  State<ParentSchoolHandbookPage> createState() =>
      _ParentSchoolHandbookPageState();
}

class _ParentSchoolHandbookPageState extends State<ParentSchoolHandbookPage> {
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
          'Parent Handbook',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildChapterCard(
            'Welcome to Sunnydale',
            'Our mission, vision, and core values.',
            'Introduction',
            Icons.school,
            surfaceColor,
            textColor,
          ),
          const SizedBox(height: 16),
          _buildChapterCard(
            'Uniform Policy',
            'Dress code requirements for summer and winter.',
            'Guidelines',
            Icons.checkroom,
            surfaceColor,
            textColor,
          ),
          const SizedBox(height: 16),
          _buildChapterCard(
            'Health & Sickness',
            'When to keep your child at home, medication policies.',
            'Safety',
            Icons.medical_services,
            surfaceColor,
            textColor,
          ),
          const SizedBox(height: 16),
          _buildChapterCard(
            'Pick-up & Drop-off',
            'ID cards, authorized guardians, and gate timings.',
            'Transport',
            Icons.directions_bus,
            surfaceColor,
            textColor,
          ),
          const SizedBox(height: 16),
          _buildChapterCard(
            'Tuition & Fees',
            'Payment schedules, late fees, and scholarships.',
            'Finance',
            Icons.account_balance_wallet,
            surfaceColor,
            textColor,
          ),
        ],
      ),
    );
  }

  Widget _buildChapterCard(
    String title,
    String desc,
    String category,
    IconData icon,
    Color surfaceColor,
    Color textColor,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // Open chapter detail
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: AppColors.primary, size: 32),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.toUpperCase(),
                        style: GoogleFonts.lexend(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        title,
                        style: GoogleFonts.lexend(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        desc,
                        style: GoogleFonts.lexend(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
