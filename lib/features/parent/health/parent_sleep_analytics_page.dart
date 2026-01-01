import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';

class ParentSleepAnalyticsPage extends StatefulWidget {
  const ParentSleepAnalyticsPage({super.key});

  @override
  State<ParentSleepAnalyticsPage> createState() =>
      _ParentSleepAnalyticsPageState();
}

class _ParentSleepAnalyticsPageState extends State<ParentSleepAnalyticsPage> {
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
          'Sleep Tracker',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Daily Summary
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo.shade400, Colors.blue.shade900],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Sleep',
                        style: GoogleFonts.lexend(color: Colors.white70),
                      ),
                      Text(
                        '1h 45m',
                        style: GoogleFonts.lexend(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Quality: Good',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  Icon(Icons.bedtime, size: 64, color: Colors.white30),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Timeline Header
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Nap Timeline (Today)',
                style: GoogleFonts.lexend(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: textColor,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Timeline Chart (Visual Representation)
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  // Base Line
                  Positioned(
                    left: 20,
                    right: 20,
                    top: 50,
                    child: Container(
                      color: Colors.grey.withOpacity(0.2),
                      height: 4,
                    ),
                  ),
                  // Nap Blocks
                  _buildNapBlock(
                    context,
                    0.2,
                    0.4,
                    '10:00 - 11:30',
                  ), // Example Position
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('9 AM', style: TextStyle(color: Colors.grey)),
                  Text('12 PM', style: TextStyle(color: Colors.grey)),
                  Text('3 PM', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),

            const SizedBox(height: 32),
            _buildInsightTile(
              'Consistent Naps',
              'Your child’s nap schedule has been very consistent this week.',
              Icons.check_circle,
              AppColors.success,
              surfaceColor,
              textColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNapBlock(
    BuildContext context,
    double startPct,
    double widthPct,
    String label,
  ) {
    final screenWidth = MediaQuery.of(context).size.width - 32; // padding
    return Positioned(
      left: 20 + (screenWidth * startPct),
      top: 25,
      child: Container(
        width: screenWidth * (widthPct - startPct),
        height: 50,
        decoration: BoxDecoration(
          color: Colors.indigo.withOpacity(0.8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInsightTile(
    String title,
    String desc,
    IconData icon,
    Color color,
    Color bg,
    Color text,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.lexend(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: text,
                  ),
                ),
                Text(
                  desc,
                  style: GoogleFonts.lexend(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
