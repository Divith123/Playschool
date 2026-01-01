import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminAdmissionFormPage extends StatefulWidget {
  const AdminAdmissionFormPage({super.key});

  @override
  State<AdminAdmissionFormPage> createState() => _AdminAdmissionFormPageState();
}

class _AdminAdmissionFormPageState extends State<AdminAdmissionFormPage> {
  static const Color primary = Color(0xFF196ee6);
  static const Color backgroundLight = Color(0xFFf6f7f8);
  static const Color backgroundDark = Color(0xFF111821);
  static const Color textMainLight = Color(0xFF0e131b);
  static const Color textMainDark = Color(0xFFffffff);
  static const Color textSubLight = Color(0xFF4e6d97);
  static const Color textSubDark = Color(0xFF9ca3af); // gray-400
  static const Color borderColorLight = Color(0xFFd0d9e7);
  static const Color borderColorDark = Color(0xFF1f2937); // gray-800

  bool _healthPolicyAccepted = false;
  bool _tuitionPolicyAccepted = false;
  String _gender = '';

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode ? backgroundDark : backgroundLight;
    final textColor = isDarkMode ? textMainDark : textMainLight;
    final subTextColor = isDarkMode ? textSubDark : textSubLight;
    final borderColor = isDarkMode ? borderColorDark : borderColorLight;
    final cardColor = isDarkMode
        ? const Color(0xFF1f2937)
        : Colors.white; // gray-800 : white

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: bgColor.withValues(alpha: 0.95),
                border: Border(bottom: BorderSide(color: borderColor)),
              ),
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(24),
                        child: Container(
                          width: 48,
                          height: 48,
                          alignment: Alignment.center,
                          child: Icon(Icons.arrow_back, color: textColor),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'New Admission',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lexend(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                            letterSpacing: -0.015,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.lexend(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: subTextColor,
                            letterSpacing: 0.015,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Stepper
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Line background
                        Container(
                          height: 4,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: borderColor,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        // Line progress (approx 33%)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: 4,
                            width:
                                MediaQuery.of(context).size.width * 0.33 -
                                24, // Rough approximation
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        // Steps
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildStep(
                              1,
                              'Info',
                              true,
                              isDarkMode,
                              subTextColor,
                            ),
                            _buildStep(
                              2,
                              'Docs',
                              false,
                              isDarkMode,
                              subTextColor,
                            ),
                            _buildStep(
                              3,
                              'Review',
                              false,
                              isDarkMode,
                              subTextColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),

            // Main Form Key area
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Section 1: Student Information
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Text(
                            'Student Information',
                            style: GoogleFonts.lexend(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                              letterSpacing: -0.015,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Column(
                            children: [
                              _buildTextField(
                                'Child\'s Full Name',
                                'Enter full name',
                                isDarkMode,
                                borderColor,
                                cardColor,
                                textColor,
                                subTextColor,
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildTextField(
                                      'Date of Birth',
                                      'DD/MM/YYYY',
                                      isDarkMode,
                                      borderColor,
                                      cardColor,
                                      textColor,
                                      subTextColor,
                                      icon: Icons.calendar_month,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: _buildDropdown(
                                      'Gender',
                                      ['Male', 'Female', 'Other'],
                                      isDarkMode,
                                      borderColor,
                                      cardColor,
                                      textColor,
                                      subTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Section 2: Documents
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Required Documents',
                                style: GoogleFonts.lexend(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                  letterSpacing: -0.015,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: primary.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '3 Pending',
                                  style: GoogleFonts.lexend(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Column(
                            children: [
                              _buildDocCard(
                                'Birth Certificate',
                                'PDF or JPG up to 5MB',
                                Icons.child_care,
                                primary,
                                primary.withValues(alpha: 0.1),
                                false,
                                isDarkMode,
                                borderColor,
                                cardColor,
                                textColor,
                                subTextColor,
                              ),
                              const SizedBox(height: 12),
                              _buildDocCard(
                                'Vaccination Record',
                                'Uploaded',
                                Icons.vaccines,
                                Colors.green[600]!,
                                Colors.green.withValues(alpha: 0.1),
                                true,
                                isDarkMode,
                                borderColor,
                                cardColor,
                                textColor,
                                subTextColor,
                              ),
                              const SizedBox(height: 12),
                              _buildDocCard(
                                'Parent ID',
                                'Government issued ID',
                                Icons.badge,
                                primary,
                                primary.withValues(alpha: 0.1),
                                false,
                                isDarkMode,
                                borderColor,
                                cardColor,
                                textColor,
                                subTextColor,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Section 3: Policies
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Text(
                            'School Policies',
                            style: GoogleFonts.lexend(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                              letterSpacing: -0.015,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Column(
                            children: [
                              _buildPolicyCheckbox(
                                'Health & Safety Guidelines',
                                'I acknowledge that I have read the health protocols regarding communicable diseases and emergency procedures.',
                                _healthPolicyAccepted,
                                (val) => setState(
                                  () => _healthPolicyAccepted = val!,
                                ),
                                isDarkMode,
                                borderColor,
                                cardColor,
                                textColor,
                                subTextColor,
                              ),
                              const SizedBox(height: 16),
                              _buildPolicyCheckbox(
                                'Tuition Payment Terms',
                                'I agree to the monthly payment schedule and understand the withdrawal policy.',
                                _tuitionPolicyAccepted,
                                (val) => setState(
                                  () => _tuitionPolicyAccepted = val!,
                                ),
                                isDarkMode,
                                borderColor,
                                cardColor,
                                textColor,
                                subTextColor,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 100,
                        ), // Bottom padding for fixed footer
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          color: isDarkMode ? backgroundDark : Colors.white,
          border: Border(top: BorderSide(color: borderColor)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              offset: const Offset(0, -4),
              blurRadius: 6,
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Center(
            heightFactor: 1.0,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: isDarkMode
                                ? Colors.grey[600]!
                                : const Color(0xFFd0d9e7),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: Text(
                          'Save Draft',
                          style: GoogleFonts.lexend(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          elevation: 2,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Next Step',
                              style: GoogleFonts.lexend(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.arrow_forward,
                              size: 20,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStep(
    int step,
    String label,
    bool isActive,
    bool isDarkMode,
    Color subTextColor,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isActive
                ? primary
                : (isDarkMode ? Colors.grey[800] : Colors.white),
            shape: BoxShape.circle,
            border: isActive
                ? null
                : Border.all(
                    color: isDarkMode
                        ? Colors.grey[600]!
                        : const Color(0xFFd0d9e7),
                    width: 2,
                  ),
            boxShadow: [
              BoxShadow(
                color: isDarkMode ? backgroundDark : backgroundLight,
                spreadRadius: 4,
              ),
            ], // Simulate ring
          ),
          alignment: Alignment.center,
          child: Text(
            '$step',
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isActive ? Colors.white : subTextColor,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.lexend(
            fontSize: 12,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            color: isActive ? primary : subTextColor,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
    String label,
    String hint,
    bool isDarkMode,
    Color borderColor,
    Color cardColor,
    Color textColor,
    Color subTextColor, {
    IconData? icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.lexend(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isDarkMode ? Colors.grey[200] : textMainLight,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 56,
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderColor),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: GoogleFonts.lexend(color: subTextColor),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  style: GoogleFonts.lexend(color: textColor),
                ),
              ),
              if (icon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Icon(icon, color: subTextColor),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(
    String label,
    List<String> items,
    bool isDarkMode,
    Color borderColor,
    Color cardColor,
    Color textColor,
    Color subTextColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.lexend(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isDarkMode ? Colors.grey[200] : textMainLight,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 56,
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderColor),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _gender.isEmpty ? null : _gender,
              hint: Text(
                'Select',
                style: GoogleFonts.lexend(color: subTextColor),
              ),
              icon: Icon(Icons.expand_more, color: subTextColor),
              isExpanded: true,
              dropdownColor: cardColor,
              items: items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: GoogleFonts.lexend(color: textColor),
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _gender = newValue!;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDocCard(
    String title,
    String subtitle,
    IconData icon,
    Color iconColor,
    Color iconBg,
    bool isUploaded,
    bool isDarkMode,
    Color borderColor,
    Color cardColor,
    Color textColor,
    Color subTextColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.lexend(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                isUploaded
                    ? Row(
                        children: [
                          Icon(Icons.check_circle, size: 16, color: iconColor),
                          const SizedBox(width: 4),
                          Text(
                            subtitle,
                            style: GoogleFonts.lexend(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: iconColor,
                            ),
                          ),
                        ],
                      )
                    : Text(
                        subtitle,
                        style: GoogleFonts.lexend(
                          fontSize: 14,
                          color: subTextColor,
                        ),
                      ),
              ],
            ),
          ),
          if (isUploaded)
            TextButton(
              onPressed: () {},
              child: Text(
                'Edit',
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: subTextColor,
                ),
              ),
            )
          else
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDarkMode
                    ? Colors.transparent
                    : Colors.transparent, // Default transparent
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  title == 'Parent ID' ? Icons.add_a_photo : Icons.upload_file,
                  color: subTextColor,
                ),
                hoverColor: isDarkMode
                    ? Colors.white.withValues(alpha: 0.1)
                    : backgroundLight,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPolicyCheckbox(
    String title,
    String content,
    bool value,
    ValueChanged<bool?> onChanged,
    bool isDarkMode,
    Color borderColor,
    Color cardColor,
    Color textColor,
    Color subTextColor,
  ) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: value,
                onChanged: onChanged,
                activeColor: primary,
                side: BorderSide(color: subTextColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.lexend(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    content,
                    style: GoogleFonts.lexend(
                      fontSize: 14,
                      color: subTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
