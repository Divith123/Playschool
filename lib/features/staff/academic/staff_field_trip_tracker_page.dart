import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';
import 'package:playschool/widgets/student_card.dart';

class StaffFieldTripTrackerPage extends StatefulWidget {
  const StaffFieldTripTrackerPage({super.key});

  @override
  State<StaffFieldTripTrackerPage> createState() =>
      _StaffFieldTripTrackerPageState();
}

class _StaffFieldTripTrackerPageState extends State<StaffFieldTripTrackerPage> {
  final List<Map<String, dynamic>> _students = [
    {
      'name': 'Alice Wonder',
      'grade': 'Grade 1',
      'isPresent': true,
      'image': 'https://placehold.co/100x100/png?text=A',
    },
    {
      'name': 'Bob Builder',
      'grade': 'Grade 1',
      'isPresent': true,
      'image': 'https://placehold.co/100x100/png?text=B',
    },
    {
      'name': 'Charlie Puth',
      'grade': 'Grade 1',
      'isPresent': false,
      'image': 'https://placehold.co/100x100/png?text=C',
    },
    {
      'name': 'Dora Explorer',
      'grade': 'Grade 1',
      'isPresent': true,
      'image': 'https://placehold.co/100x100/png?text=D',
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Field Trip: City Zoo',
              style: AppTextStyles.headingMedium(
                isDarkMode,
              ).copyWith(fontSize: 18),
            ),
            Text(
              '${_students.where((s) => s['isPresent']).length}/${_students.length} Present',
              style: GoogleFonts.lexend(fontSize: 12, color: Colors.green),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.refresh, color: textColor),
          ),
        ],
      ),
      body: Column(
        children: [
          // Panic Button Section
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.red.withOpacity(0.1),
            child: Row(
              children: [
                Icon(Icons.warning_amber_rounded, color: Colors.red, size: 32),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Emergency?',
                        style: GoogleFonts.lexend(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        'Share Live GPS with Admin',
                        style: GoogleFonts.lexend(
                          fontSize: 12,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Trigger emergency
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('SOS Alert Sent to Admin with Location!'),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 5),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'PANIC',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Student List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _students.length,
              separatorBuilder: (ctx, i) => const SizedBox(height: 12),
              itemBuilder: (ctx, i) {
                final student = _students[i];
                return _buildRollCallCard(
                  student,
                  surfaceColor,
                  textColor,
                  isDarkMode,
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: surfaceColor,
        child: PrimaryButton(
          label: 'Submit Roll Call Log',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Roll Call Logged Successfully!'),
                backgroundColor: AppColors.success,
              ),
            );
          },
          width: double.infinity,
        ),
      ),
    );
  }

  Widget _buildRollCallCard(
    Map<String, dynamic> student,
    Color surfaceColor,
    Color textColor,
    bool isDarkMode,
  ) {
    bool isPresent = student['isPresent'];

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPresent ? Colors.transparent : Colors.red.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(student['image']),
            radius: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student['name'],
                  style: GoogleFonts.lexend(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                Text(
                  student['grade'],
                  style: GoogleFonts.lexend(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          Switch(
            value: isPresent,
            onChanged: (val) {
              setState(() {
                student['isPresent'] = val;
              });
            },
            activeColor: AppColors.success,
            inactiveThumbColor: Colors.red,
            inactiveTrackColor: Colors.red.withOpacity(0.2),
          ),
        ],
      ),
    );
  }
}
