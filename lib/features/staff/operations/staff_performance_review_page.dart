import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';

import 'package:playschool/widgets/status_badge.dart';

class StaffPerformanceReviewPage extends StatefulWidget {
  const StaffPerformanceReviewPage({super.key});

  @override
  State<StaffPerformanceReviewPage> createState() =>
      _StaffPerformanceReviewPageState();
}

class _StaffPerformanceReviewPageState
    extends State<StaffPerformanceReviewPage> {
  final Map<String, double> _ratings = {
    'Classroom Management': 4.5,
    'Punctuality': 4.8,
    'Communication': 4.2,
    'Curriculum Delivery': 4.6,
    'Peer Collaboration': 4.0,
  };

  final List<Map<String, dynamic>> _goals = [
    {
      'goal': 'Complete Montessori Certification',
      'deadline': 'Dec 2025',
      'status': 'In Progress',
    },
    {
      'goal': 'Organize Annual Science Fair',
      'deadline': 'Mar 2026',
      'status': 'Pending',
    },
    {
      'goal': 'Improve Parent Feedback Score',
      'deadline': 'Jun 2026',
      'status': 'Pending',
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
          'Performance Review',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overall Score Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withValues(alpha: 0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Overall Rating',
                        style: GoogleFonts.lexend(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '4.5',
                        style: GoogleFonts.lexend(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Exceeds Expectations',
                        style: GoogleFonts.lexend(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.star, color: Colors.white, size: 40),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Detailed Ratings
            Text(
              'Detailed Metrics',
              style: GoogleFonts.lexend(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 16),
            ..._ratings.entries.map(
              (entry) => _buildRatingRow(
                entry.key,
                entry.value,
                isDarkMode,
                textColor,
              ),
            ),

            const SizedBox(height: 32),

            // Goals Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Goals for Next Term',
                  style: GoogleFonts.lexend(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                IconButton(
                  onPressed: () {}, // Add Goal
                  icon: Icon(Icons.add_circle, color: AppColors.primary),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ..._goals.map(
              (goal) =>
                  _buildGoalCard(goal, surfaceColor, textColor, isDarkMode),
            ),

            const SizedBox(height: 40),
            Center(
              child: TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.download, color: AppColors.primary),
                label: Text(
                  'Download Full Report (PDF)',
                  style: TextStyle(color: AppColors.primary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingRow(
    String label,
    double rating,
    bool isDarkMode,
    Color textColor,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
              Text(
                rating.toString(),
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: rating / 5.0,
              backgroundColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(
                _getRatingColor(rating),
              ),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }

  Color _getRatingColor(double rating) {
    if (rating >= 4.5) return AppColors.success;
    if (rating >= 3.5) return Colors.blue;
    if (rating >= 2.5) return Colors.orange;
    return Colors.red;
  }

  Widget _buildGoalCard(
    Map<String, dynamic> goal,
    Color surfaceColor,
    Color textColor,
    bool isDarkMode,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.flag, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  goal['goal'],
                  style: GoogleFonts.lexend(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Deadline: ${goal['deadline']}',
                  style: GoogleFonts.lexend(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          StatusBadge(
            label: goal['status'],
            type: goal['status'] == 'In Progress'
                ? StatusType.info
                : StatusType.warning,
            isDarkMode: isDarkMode,
          ),
        ],
      ),
    );
  }
}
