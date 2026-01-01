import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class StaffAssessmentBuilderPage extends StatefulWidget {
  const StaffAssessmentBuilderPage({super.key});

  @override
  State<StaffAssessmentBuilderPage> createState() =>
      _StaffAssessmentBuilderPageState();
}

class _StaffAssessmentBuilderPageState
    extends State<StaffAssessmentBuilderPage> {
  final List<String> _criterias = [
    'Social Skills',
    'Motor Skills',
    'Language',
    'Creativity',
    'Math/Logic',
  ];

  final List<Map<String, dynamic>> _addedFields = [];

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
          'Assessment Builder',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
        actions: [
          TextButton(
            onPressed: () {
              // Save logic
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Blueprint Saved!'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: Text(
              'Save',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          // Sidebar (Draggable Items)
          Container(
            width: 120,
            color: isDarkMode ? Colors.grey[900] : Colors.grey[100],
            child: Column(
              children: [
                const SizedBox(height: 16),
                Text(
                  'Criteria Library',
                  style: GoogleFonts.lexend(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: _criterias.length,
                    itemBuilder: (context, index) {
                      final item = _criterias[index];
                      return Draggable<String>(
                        data: item,
                        feedback: Material(
                          color: Colors.transparent,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: Text(
                              item,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            color: surfaceColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.2),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              item,
                              style: GoogleFonts.lexend(
                                fontSize: 12,
                                color: textColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Canvas (Drop Target)
          Expanded(
            child: DragTarget<String>(
              onAccept: (data) {
                setState(() {
                  _addedFields.add({'name': data, 'maxScore': 10});
                });
              },
              builder: (context, candidates, rejects) {
                return Container(
                  color: candidates.isNotEmpty
                      ? AppColors.primary.withOpacity(0.05)
                      : Colors.transparent,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText:
                                'Enter Assessment Title (e.g., Q1 Progress)',
                            hintStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[400],
                            ),
                            border: InputBorder.none,
                          ),
                          style: GoogleFonts.lexend(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ),
                      const Divider(),
                      Expanded(
                        child: _addedFields.isEmpty
                            ? Center(
                                child: Text(
                                  'Drag criteria here to build rubric',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.all(16),
                                itemCount: _addedFields.length,
                                itemBuilder: (context, index) {
                                  final field = _addedFields[index];
                                  return _buildFieldCard(
                                    index,
                                    field,
                                    surfaceColor,
                                    textColor,
                                  );
                                },
                              ),
                      ),
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

  Widget _buildFieldCard(
    int index,
    Map<String, dynamic> field,
    Color surfaceColor,
    Color textColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                field['name'],
                style: GoogleFonts.lexend(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _addedFields.removeAt(index);
                  });
                },
                icon: const Icon(Icons.close, size: 18, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text('Max Score:', style: TextStyle(color: Colors.grey)),
              const SizedBox(width: 12),
              Container(
                width: 60,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${field['maxScore']}',
                  style: GoogleFonts.lexend(color: textColor),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              Slider(
                value: (field['maxScore'] as int).toDouble(),
                min: 5,
                max: 100,
                divisions: 19,
                activeColor: AppColors.primary,
                onChanged: (val) {
                  setState(() {
                    field['maxScore'] = val.toInt();
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
