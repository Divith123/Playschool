import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class ParentMedicalHistoryFormPage extends StatefulWidget {
  const ParentMedicalHistoryFormPage({super.key});

  @override
  State<ParentMedicalHistoryFormPage> createState() =>
      _ParentMedicalHistoryFormPageState();
}

class _ParentMedicalHistoryFormPageState
    extends State<ParentMedicalHistoryFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _bloodGroup = 'A+';
  final List<String> _allergies = [];

  final TextEditingController _allergyController = TextEditingController();

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
          'Medical History',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Emergency Contacts', textColor),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Family Doctor Name',
                icon: Icons.person_outline,
                onChanged: (val) {},
                isDarkMode: isDarkMode,
                surfaceColor: surfaceColor,
                textColor: textColor,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Doctor Phone Number',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                onChanged: (val) {},
                isDarkMode: isDarkMode,
                surfaceColor: surfaceColor,
                textColor: textColor,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Preferred Hospital',
                icon: Icons.local_hospital_outlined,
                onChanged: (val) {},
                isDarkMode: isDarkMode,
                surfaceColor: surfaceColor,
                textColor: textColor,
              ),

              const SizedBox(height: 32),
              _buildSectionTitle('Critical Details', textColor),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: surfaceColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _bloodGroup,
                    isExpanded: true,
                    dropdownColor: surfaceColor,
                    style: GoogleFonts.lexend(color: textColor, fontSize: 16),
                    items: ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (val) => setState(() => _bloodGroup = val!),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Health Insurance Policy #',
                icon: Icons.badge_outlined,
                onChanged: (val) {},
                isDarkMode: isDarkMode,
                surfaceColor: surfaceColor,
                textColor: textColor,
              ),

              const SizedBox(height: 32),
              _buildSectionTitle('Allergies', textColor),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      label: 'Add Allergy (e.g., Peanuts)',
                      icon: Icons.warning_amber_rounded,
                      controller: _allergyController, // Pass controller
                      onChanged: (val) {},
                      isDarkMode: isDarkMode,
                      surfaceColor: surfaceColor,
                      textColor: textColor,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () {
                      if (_allergyController.text.isNotEmpty) {
                        setState(() {
                          _allergies.add(_allergyController.text);
                          _allergyController.clear();
                        });
                      }
                    },
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.add, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _allergies
                    .map(
                      (a) => Chip(
                        label: Text(a),
                        backgroundColor: Colors.red.withValues(alpha: 0.1),
                        labelStyle: const TextStyle(color: Colors.red),
                        deleteIcon: const Icon(
                          Icons.close,
                          size: 14,
                          color: Colors.red,
                        ),
                        onDeleted: () {
                          setState(() => _allergies.remove(a));
                        },
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.red.withValues(alpha: 0.3),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    )
                    .toList(),
              ),

              const SizedBox(height: 40),
              PrimaryButton(
                label: 'Save Medical Profile',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Medical History Updated!'),
                        backgroundColor: AppColors.success,
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color color) {
    return Text(
      title,
      style: GoogleFonts.lexend(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    required Function(String) onChanged,
    required bool isDarkMode,
    required Color surfaceColor,
    required Color textColor,
    TextInputType keyboardType = TextInputType.text,
    TextEditingController? controller,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey),
        prefixIcon: Icon(icon, color: AppColors.primary),
        filled: true,
        fillColor: surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
        ),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          if (controller != null) return null; // Logic for allergy add field
          return 'This field is required';
        }
        return null;
      },
    );
  }
}
