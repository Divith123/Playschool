import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';

class AdminStudentAddEditPage extends StatefulWidget {
  final bool isEdit;
  const AdminStudentAddEditPage({super.key, this.isEdit = false});

  @override
  State<AdminStudentAddEditPage> createState() =>
      _AdminStudentAddEditPageState();
}

class _AdminStudentAddEditPageState extends State<AdminStudentAddEditPage> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit ? 'Edit Student' : 'Add New Student',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: isDarkMode ? AppColors.textMainDark : AppColors.textMainLight,
        ),
      ),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < 2) {
            setState(() => _currentStep++);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Student Record Saved!')),
            );
            Navigator.pop(context);
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) setState(() => _currentStep--);
        },
        steps: [
          Step(
            title: const Text('Personal'),
            content: Column(
              children: [
                _buildTextField('Full Name', isDarkMode),
                const SizedBox(height: 16),
                _buildTextField('Date of Birth', isDarkMode),
                const SizedBox(height: 16),
                _buildTextField('Gender', isDarkMode),
              ],
            ),
            isActive: _currentStep >= 0,
          ),
          Step(
            title: const Text('Parents'),
            content: Column(
              children: [
                _buildTextField('Father\'s Name', isDarkMode),
                const SizedBox(height: 16),
                _buildTextField('Mother\'s Name', isDarkMode),
                const SizedBox(height: 16),
                _buildTextField('Emergency Contact', isDarkMode),
              ],
            ),
            isActive: _currentStep >= 1,
          ),
          Step(
            title: const Text('Medical'),
            content: Column(
              children: [
                _buildTextField('Allergies', isDarkMode),
                const SizedBox(height: 16),
                _buildTextField('Blood Group', isDarkMode),
                const SizedBox(height: 16),
                _buildTextField('Pediatrician Contact', isDarkMode),
              ],
            ),
            isActive: _currentStep >= 2,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, bool isDarkMode) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
