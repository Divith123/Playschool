import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/search_bar.dart';

class StaffMedicalWaiverManagerPage extends StatefulWidget {
  const StaffMedicalWaiverManagerPage({super.key});

  @override
  State<StaffMedicalWaiverManagerPage> createState() =>
      _StaffMedicalWaiverManagerPageState();
}

class _StaffMedicalWaiverManagerPageState
    extends State<StaffMedicalWaiverManagerPage> {
  final List<Map<String, dynamic>> _students = [
    {
      'name': 'Alice Wonder',
      'photo': true,
      'sunscreen': true,
      'tylenol': false,
      'diaper': true,
      'image': 'https://placehold.co/100x100/png?text=A',
    },
    {
      'name': 'Bob Builder',
      'photo': false,
      'sunscreen': true,
      'tylenol': true,
      'diaper': false,
      'image': 'https://placehold.co/100x100/png?text=B',
    },
    {
      'name': 'Charlie Puth',
      'photo': true,
      'sunscreen': false,
      'tylenol': false,
      'diaper': true,
      'image': 'https://placehold.co/100x100/png?text=C',
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
          'Permissions & Waivers',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomSearchBar(
              hintText: 'Search student...',
              onChanged: (val) {},
              isDarkMode: isDarkMode,
            ),
          ),

          // Header Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'Student',
                    style: GoogleFonts.lexend(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                _buildHeaderIcon(Icons.camera_alt, 'Photo'),
                _buildHeaderIcon(Icons.wb_sunny, 'Sunscreen'),
                _buildHeaderIcon(Icons.medication, 'Meds'),
                _buildHeaderIcon(Icons.baby_changing_station, 'Diaper'),
              ],
            ),
          ),

          Expanded(
            child: ListView.separated(
              itemCount: _students.length,
              separatorBuilder: (ctx, i) =>
                  Divider(color: Colors.grey.withValues(alpha: 0.1), height: 1),
              itemBuilder: (context, index) {
                final student = _students[index];
                return Container(
                  color: surfaceColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundImage: NetworkImage(student['image']),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                student['name'],
                                style: GoogleFonts.lexend(
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildCheckIcon(student['photo']),
                      _buildCheckIcon(student['sunscreen']),
                      _buildCheckIcon(student['tylenol']),
                      _buildCheckIcon(student['diaper']),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderIcon(IconData icon, String tooltip) {
    return Expanded(
      flex: 1,
      child: Tooltip(
        message: tooltip,
        child: Icon(icon, size: 20, color: Colors.grey),
      ),
    );
  }

  Widget _buildCheckIcon(bool allowed) {
    return Expanded(
      flex: 1,
      child: Icon(
        allowed ? Icons.check_circle : Icons.cancel,
        color: allowed ? AppColors.success : Colors.red.withValues(alpha: 0.5),
        size: 24,
      ),
    );
  }
}
