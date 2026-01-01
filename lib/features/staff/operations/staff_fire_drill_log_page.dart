import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class StaffFireDrillLogPage extends StatefulWidget {
  const StaffFireDrillLogPage({super.key});

  @override
  State<StaffFireDrillLogPage> createState() => _StaffFireDrillLogPageState();
}

class _StaffFireDrillLogPageState extends State<StaffFireDrillLogPage> {
  String _drillType = 'Fire Drill';
  String _timeTaken = '';
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
          'Drill Log',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stopclock Visual
            Center(
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[800] : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.timer, size: 40, color: AppColors.primary),
                      const SizedBox(height: 8),
                      Text(
                        'LOG NEW',
                        style: GoogleFonts.lexend(
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),

            _buildLabel('Drill Type', textColor),
            DropdownButtonFormField<String>(
              value: _drillType,
              dropdownColor: surfaceColor,
              style: TextStyle(color: textColor),
              decoration: _buildInputDeco(surfaceColor),
              items: [
                'Fire Drill',
                'Lockdown',
                'Earthquake',
                'Tornado',
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (val) => setState(() => _drillType = val!),
            ),
            const SizedBox(height: 24),

            _buildLabel('Time Taken to Evacuate (mm:ss)', textColor),
            TextFormField(
              keyboardType: TextInputType.datetime,
              onChanged: (val) => _timeTaken = val,
              style: TextStyle(color: textColor),
              decoration: _buildInputDeco(surfaceColor).copyWith(
                hintText: 'e.g., 03:45',
                hintStyle: TextStyle(color: Colors.grey),
                suffixIcon: Icon(Icons.av_timer, color: AppColors.primary),
              ),
            ),
            const SizedBox(height: 24),

            _buildLabel('Date & Time', textColor),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.withOpacity(0.1)),
              ),
              child: Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.grey, size: 20),
                  const SizedBox(width: 12),
                  Text(
                    DateTime.now().toString().split('.')[0],
                    style: TextStyle(color: textColor),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            _buildLabel('Issues Observed (Optional)', textColor),
            TextField(
              controller: _notesController,
              maxLines: 3,
              style: TextStyle(color: textColor),
              decoration: _buildInputDeco(surfaceColor).copyWith(
                hintText: 'e.g., West exit door jammed...',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),

            const SizedBox(height: 40),
            PrimaryButton(
              label: 'Submit Official Log',
              onPressed: () {
                if (_timeTaken.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter time taken.')),
                  );
                  return;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Drill Log Submitted for Compliance.'),
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
    );
  }

  Widget _buildLabel(String label, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: GoogleFonts.lexend(
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }

  InputDecoration _buildInputDeco(Color surfaceColor) {
    return InputDecoration(
      filled: true,
      fillColor: surfaceColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }
}
