import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class StaffBodyMapAnalyzerPage extends StatefulWidget {
  const StaffBodyMapAnalyzerPage({super.key});

  @override
  State<StaffBodyMapAnalyzerPage> createState() =>
      _StaffBodyMapAnalyzerPageState();
}

class _StaffBodyMapAnalyzerPageState extends State<StaffBodyMapAnalyzerPage> {
  final List<Offset> _injuries = [];
  String _selectedSeverity = 'Minor Bump';
  final TextEditingController _notesController = TextEditingController();

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
          'Injury Body Map',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.primary.withValues(alpha: 0.1),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: AppColors.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Tap on the body diagram exactly where the injury is located.',
                    style: GoogleFonts.lexend(color: textColor),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return GestureDetector(
                  onTapUp: (details) {
                    setState(() {
                      _injuries.add(details.localPosition);
                    });
                  },
                  child: Stack(
                    children: [
                      // Body Silhouette (Placeholder)
                      Center(
                        child: Container(
                          width: 300,
                          height: 500,
                          decoration: BoxDecoration(
                            color: Colors.grey.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey, width: 2),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.accessibility_new,
                                  size: 200,
                                  color: Colors.grey,
                                ),
                                Text(
                                  'Body Map Visualization',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Injury Markers
                      ..._injuries.map(
                        (offset) => Positioned(
                          left: offset.dx - 12,
                          top: offset.dy - 12,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _injuries.remove(offset);
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red.withValues(alpha: 0.8),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.3),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              width: 24,
                              height: 24,
                              child: const Center(
                                child: Icon(
                                  Icons.close,
                                  size: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Controls
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Injury Details',
                  style: GoogleFonts.lexend(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: _selectedSeverity,
                  dropdownColor: surfaceColor,
                  style: TextStyle(color: textColor),
                  decoration: InputDecoration(
                    labelText: 'Severity / Type',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items:
                      [
                            'Minor Bump',
                            'Scratch/Cut',
                            'Bruise',
                            'Insect Bite',
                            'Deep Wound (Urgent)',
                          ]
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                  onChanged: (val) => setState(() => _selectedSeverity = val!),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _notesController,
                  maxLines: 2,
                  style: TextStyle(color: textColor),
                  decoration: InputDecoration(
                    labelText: 'Notes (Optional)',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                PrimaryButton(
                  label: 'Log Injury Record',
                  onPressed: _injuries.isEmpty
                      ? null
                      : () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Injury Logged Successfully'),
                              backgroundColor: AppColors.success,
                            ),
                          );
                          Navigator.pop(context);
                        },
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
