import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class ParentScholarshipApplyPage extends StatefulWidget {
  const ParentScholarshipApplyPage({super.key});

  @override
  State<ParentScholarshipApplyPage> createState() =>
      _ParentScholarshipApplyPageState();
}

class _ParentScholarshipApplyPageState
    extends State<ParentScholarshipApplyPage> {
  int _currentStep = 0;
  String _scholarshipType = 'Merit-Based';

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
          'Scholarship Application',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < 2) {
            setState(() => _currentStep += 1);
          } else {
            // Submit
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Application Submitted Successfully!'),
                backgroundColor: AppColors.success,
              ),
            );
            Navigator.pop(context);
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() => _currentStep -= 1);
          }
        },
        controlsBuilder: (context, details) {
          return Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    label: _currentStep == 2
                        ? 'Submit Application'
                        : 'Next Step',
                    onPressed: details.onStepContinue!,
                  ),
                ),
                if (_currentStep > 0) ...[
                  const SizedBox(width: 12),
                  TextButton(
                    onPressed: details.onStepCancel!,
                    child: Text('Back', style: TextStyle(color: textColor)),
                  ),
                ],
              ],
            ),
          );
        },
        steps: [
          Step(
            title: Text(
              'Program Selection',
              style: GoogleFonts.lexend(color: textColor),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRadioOption(
                  'Merit-Based',
                  'For students with exceptional academic/extracurricular achievements.',
                  textColor,
                ),
                _buildRadioOption(
                  'Financial Aid',
                  'Support for families demonstrating financial need.',
                  textColor,
                ),
                _buildRadioOption(
                  'Sibling Discount',
                  'For families with 2+ children enrolled.',
                  textColor,
                ),
              ],
            ),
            isActive: _currentStep >= 0,
            state: _currentStep > 0 ? StepState.complete : StepState.editing,
          ),
          Step(
            title: Text(
              'Student Detail',
              style: GoogleFonts.lexend(color: textColor),
            ),
            content: TextField(
              style: TextStyle(color: textColor),
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Statement of Purpose / Reason',
                hintText: 'Explain why you are applying...',
                filled: true,
                fillColor: surfaceColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            isActive: _currentStep >= 1,
            state: _currentStep > 1 ? StepState.complete : StepState.editing,
          ),
          Step(
            title: Text(
              'Documents',
              style: GoogleFonts.lexend(color: textColor),
            ),
            content: Column(
              children: [
                _buildUploadBox('Income Proof (Tax Return)', isDarkMode),
                const SizedBox(height: 12),
                _buildUploadBox('Report Card (Last Year)', isDarkMode),
              ],
            ),
            isActive: _currentStep >= 2,
            state: StepState.indexed,
          ),
        ],
      ),
    );
  }

  Widget _buildRadioOption(String value, String subtitle, Color textColor) {
    return RadioListTile<String>(
      title: Text(
        value,
        style: GoogleFonts.lexend(
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.lexend(fontSize: 12, color: Colors.grey),
      ),
      value: value,
      groupValue: _scholarshipType,
      activeColor: AppColors.primary,
      contentPadding: EdgeInsets.zero,
      onChanged: (val) => setState(() => _scholarshipType = val!),
    );
  }

  Widget _buildUploadBox(String label, bool isDarkMode) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[900] : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey,
          style: BorderStyle.solid,
        ), // Dotted border ideally
      ),
      child: Column(
        children: [
          Icon(Icons.cloud_upload_outlined, size: 32, color: Colors.grey),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          Text(
            'Tap to upload PDF/JPG',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
