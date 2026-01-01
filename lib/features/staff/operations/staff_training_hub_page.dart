import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class StaffTrainingHubPage extends StatefulWidget {
  const StaffTrainingHubPage({super.key});

  @override
  State<StaffTrainingHubPage> createState() => _StaffTrainingHubPageState();
}

class _StaffTrainingHubPageState extends State<StaffTrainingHubPage> {
  final List<Map<String, dynamic>> _trainings = [
    {
      'title': 'Child Abuse Prevention',
      'category': 'Compliance',
      'duration': '45m',
      'progress': 1.0,
      'score': 95,
      'image': 'https://placehold.co/100x100/png?text=Safety',
    },
    {
      'title': 'Montessori Curriculum 101',
      'category': 'Academics',
      'duration': '1h 20m',
      'progress': 0.6,
      'score': null, // Not completed
      'image': 'https://placehold.co/100x100/png?text=Montessori',
    },
    {
      'title': 'Fire Safety & Evacuation',
      'category': 'Safety',
      'duration': '30m',
      'progress': 0.0,
      'score': null,
      'image': 'https://placehold.co/100x100/png?text=Fire',
    },
    {
      'title': 'Effective Parent Communication',
      'category': 'Soft Skills',
      'duration': '40m',
      'progress': 0.0,
      'score': null,
      'image': 'https://placehold.co/100x100/png?text=Comms',
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
          'Learning & Training',
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
            // Stats Header
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Completed',
                    '12',
                    Icons.check_circle_outline,
                    AppColors.success,
                    surfaceColor,
                    textColor,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    'Pending',
                    '3',
                    Icons.timer_outlined,
                    Colors.orange,
                    surfaceColor,
                    textColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            Text(
              'My Courses',
              style: GoogleFonts.lexend(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 16),

            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _trainings.length,
              separatorBuilder: (ctx, i) => const SizedBox(height: 16),
              itemBuilder: (ctx, i) {
                return _buildTrainingCard(
                  _trainings[i],
                  surfaceColor,
                  textColor,
                  isDarkMode,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    IconData icon,
    Color color,
    Color surfaceColor,
    Color textColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.lexend(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.lexend(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildTrainingCard(
    Map<String, dynamic> item,
    Color surfaceColor,
    Color textColor,
    bool isDarkMode,
  ) {
    final double progress = item['progress'];
    final bool isCompleted = progress == 1.0;
    final int? score = item['score'];

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              item['image'],
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        item['category'],
                        style: GoogleFonts.lexend(
                          fontSize: 10,
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (isCompleted)
                      Icon(
                        Icons.check_circle,
                        color: AppColors.success,
                        size: 16,
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  item['title'],
                  style: GoogleFonts.lexend(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 12, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      item['duration'],
                      style: GoogleFonts.lexend(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    if (score != null) ...[
                      const SizedBox(width: 12),
                      Text(
                        'Score: $score%',
                        style: GoogleFonts.lexend(
                          fontSize: 12,
                          color: AppColors.success,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: isDarkMode
                        ? Colors.grey[800]
                        : Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isCompleted ? AppColors.success : AppColors.primary,
                    ),
                    minHeight: 4,
                  ),
                ),
                if (!isCompleted) ...[
                  const SizedBox(height: 12),
                  PrimaryButton(
                    label: progress == 0.0 ? 'Start' : 'Resume',
                    onPressed: () {},
                    height: 32,
                    fontSize: 12,
                    width: double.infinity,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
