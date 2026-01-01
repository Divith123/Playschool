import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class DriverVehicleIncidentPage extends StatefulWidget {
  const DriverVehicleIncidentPage({super.key});

  @override
  State<DriverVehicleIncidentPage> createState() =>
      _DriverVehicleIncidentPageState();
}

class _DriverVehicleIncidentPageState extends State<DriverVehicleIncidentPage> {
  String _severity = 'Minor Delay';
  final TextEditingController _descController = TextEditingController();

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
          'Report Incident',
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
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                border: Border.all(color: Colors.red.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning_amber, color: Colors.red),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Use this only for non-emergency reporting. Call 911 for emergencies.',
                      style: GoogleFonts.lexend(color: textColor),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            _buildLabel('Incident Type', textColor),
            DropdownButtonFormField<String>(
              value: _severity,
              dropdownColor: surfaceColor,
              style: TextStyle(color: textColor),
              decoration: _buildInputDeco(surfaceColor),
              items: [
                'Minor Delay',
                'Traffic Jam',
                'Breakdown',
                'Accident',
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (val) => setState(() => _severity = val!),
            ),

            const SizedBox(height: 24),
            _buildLabel('Description', textColor),
            TextField(
              controller: _descController,
              maxLines: 4,
              style: TextStyle(color: textColor),
              decoration: _buildInputDeco(surfaceColor).copyWith(
                hintText: 'Describe what happened...',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),

            const SizedBox(height: 24),
            _buildLabel('Photos (Optional)', textColor),
            Row(
              children: [
                _buildPhotoBox(Icons.camera_alt, surfaceColor, textColor),
                const SizedBox(width: 12),
                _buildPhotoBox(Icons.add, surfaceColor, textColor),
              ],
            ),

            const SizedBox(height: 40),
            PrimaryButton(
              label: 'Submit Report',
              backgroundColor: Colors.red,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Incident Reported. Admin Notified.'),
                    backgroundColor: Colors.red,
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
      contentPadding: const EdgeInsets.all(16),
    );
  }

  Widget _buildPhotoBox(IconData icon, Color surfaceColor, Color textColor) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: Icon(icon, color: Colors.grey),
    );
  }
}
