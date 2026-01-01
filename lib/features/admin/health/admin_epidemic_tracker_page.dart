import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class AdminEpidemicTrackerPage extends StatefulWidget {
  const AdminEpidemicTrackerPage({super.key});

  @override
  State<AdminEpidemicTrackerPage> createState() =>
      _AdminEpidemicTrackerPageState();
}

class _AdminEpidemicTrackerPageState extends State<AdminEpidemicTrackerPage> {
  final List<Map<String, dynamic>> _symptomReports = [
    {
      'room': 'Room 1 (Toddlers)',
      'cases': 3,
      'symptom': 'Chickenpox',
      'risk': 'High',
    },
    {
      'room': 'Room 3 (Pre-K)',
      'cases': 5,
      'symptom': 'Flu/Fever',
      'risk': 'Medium',
    },
    {
      'room': 'Room 2 (Toddlers)',
      'cases': 1,
      'symptom': 'Hand-Foot-Mouth',
      'risk': 'Low',
    },
    {'room': 'Staff Room', 'cases': 2, 'symptom': 'Cold', 'risk': 'Low'},
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
          'Epidemic Tracker',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share, color: Colors.blue),
            tooltip: 'Export Report',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Alert Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.withOpacity(0.5)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.warning, color: Colors.red, size: 28),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Outbreak Alert',
                          style: GoogleFonts.lexend(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '3 new cases of Chickenpox reported in Room 1 today.',
                          style: GoogleFonts.lexend(
                            color: textColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Heatmap Simulation
            Text(
              'School Health Heatmap',
              style: GoogleFonts.lexend(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 12),
            AspectRatio(
              aspectRatio: 1.5,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: surfaceColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.withOpacity(0.1)),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          _buildRoomBox('Room 1', 3, Colors.red),
                          const SizedBox(width: 8),
                          _buildRoomBox('Room 2', 1, Colors.green),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Row(
                        children: [
                          _buildRoomBox('Room 3', 5, Colors.orange),
                          const SizedBox(width: 8),
                          _buildRoomBox('Room 4', 0, Colors.grey),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Detailed Reports
            Text(
              'Active Reports',
              style: GoogleFonts.lexend(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 12),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _symptomReports.length,
              separatorBuilder: (ctx, i) => const SizedBox(height: 12),
              itemBuilder: (ctx, i) {
                return _buildReportCard(
                  _symptomReports[i],
                  surfaceColor,
                  textColor,
                );
              },
            ),

            const SizedBox(height: 40),
            PrimaryButton(
              label: 'Notify Health Dept via Email',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Automated Report Sent to Health Dept.'),
                    backgroundColor: AppColors.success,
                  ),
                );
              },
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoomBox(String name, int cases, Color color) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.5), width: 2),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: GoogleFonts.lexend(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              if (cases > 0)
                Text(
                  '$cases Cases',
                  style: GoogleFonts.lexend(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                )
              else
                Icon(Icons.check_circle_outline, color: color, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReportCard(
    Map<String, dynamic> report,
    Color surfaceColor,
    Color textColor,
  ) {
    Color riskColor;
    if (report['risk'] == 'High') {
      riskColor = Colors.red;
    } else if (report['risk'] == 'Medium') {
      riskColor = Colors.orange;
    } else {
      riskColor = Colors.green;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                report['room'],
                style: GoogleFonts.lexend(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    'Symptom: ',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  Text(
                    report['symptom'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: riskColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${report['cases']} Cases',
                  style: GoogleFonts.lexend(
                    color: riskColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
