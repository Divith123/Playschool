import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/widgets/primary_button.dart';

class ParentReportCardViewPage extends StatelessWidget {
  const ParentReportCardViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Leo\'s Report Card',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: isDarkMode ? AppColors.textMainDark : AppColors.textMainLight,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.download,
              color: isDarkMode
                  ? AppColors.textMainDark
                  : AppColors.textMainLight,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Downloading Report Card...')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Header Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Text(
                      'L',
                      style: GoogleFonts.lexend(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Leo Das',
                    style: AppTextStyles.headingLarge(
                      isDarkMode,
                    ).copyWith(color: Colors.white),
                  ),
                  Text(
                    'Class 2B • Term 1 Report',
                    style: AppTextStyles.bodyMedium(
                      isDarkMode,
                    ).copyWith(color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Performance Grid
            _buildSectionTitle('Performance Summary', isDarkMode),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.5,
              children: [
                _buildScoreCard('Cognitive', 'Good', Colors.blue, isDarkMode),
                _buildScoreCard(
                  'Physical',
                  'Excellent',
                  Colors.green,
                  isDarkMode,
                ),
                _buildScoreCard(
                  'Social',
                  'Developing',
                  Colors.orange,
                  isDarkMode,
                ),
                _buildScoreCard('Language', 'Good', Colors.blue, isDarkMode),
              ],
            ),

            const SizedBox(height: 24),
            _buildSectionTitle('Teacher\'s Remarks', isDarkMode),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? AppColors.surfaceDark
                    : AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDarkMode ? Colors.white10 : Colors.grey[200]!,
                ),
              ),
              child: Text(
                'Leo contributes very well in class discussions. He is showing great improvement in his physical coordination during sports activities. Needs to focus a bit more on sharing toys with peers during playtime.',
                style: AppTextStyles.bodyLarge(
                  isDarkMode,
                ).copyWith(height: 1.5),
              ),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'Sign & Acknowledge',
              icon: Icons.draw,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Report Card Signed!')),
                );
              },
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isDarkMode) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: AppTextStyles.headingMedium(isDarkMode).copyWith(fontSize: 18),
      ),
    );
  }

  Widget _buildScoreCard(
    String subject,
    String score,
    Color color,
    bool isDarkMode,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            subject,
            style: AppTextStyles.bodyMedium(
              isDarkMode,
            ).copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            score,
            style: AppTextStyles.headingMedium(
              isDarkMode,
            ).copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
