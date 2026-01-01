import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PublicEnquiryPage extends StatefulWidget {
  const PublicEnquiryPage({super.key});

  @override
  State<PublicEnquiryPage> createState() => _PublicEnquiryPageState();
}

class _PublicEnquiryPageState extends State<PublicEnquiryPage> {
  static const Color primary = Color(0xFF2bee6c);
  static const Color backgroundLight = Color(0xFFf6f8f6);
  static const Color backgroundDark = Color(0xFF102216);
  static const Color surfaceLight = Color(0xFFffffff);
  static const Color surfaceDark = Color(0xFF1a2c20);
  static const Color textMainLight = Color(0xFF0d1b12);
  static const Color textMainDark = Color(0xFFe0e7e3);

  final _formKey = GlobalKey<FormState>();
  String? selectedProgram;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode ? backgroundDark : backgroundLight;
    final surfaceColor = isDarkMode ? surfaceDark : surfaceLight;
    final textColor = isDarkMode ? textMainDark : textMainLight;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Header / Hero Section
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: primary.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.school_rounded,
                        size: 40,
                        color: primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Little Learners Academy',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lexend(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Enquiry & Campus Tour Form',
                      style: GoogleFonts.lexend(
                        fontSize: 16,
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: surfaceColor,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle('Parent Details', textColor),
                      const SizedBox(height: 16),
                      _buildTextField(
                        label: 'Full Name',
                        icon: Icons.person_outline,
                        isDarkMode: isDarkMode,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        label: 'Email Address',
                        icon: Icons.email_outlined,
                        isDarkMode: isDarkMode,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        label: 'Phone Number',
                        icon: Icons.phone_outlined,
                        isDarkMode: isDarkMode,
                      ),

                      const SizedBox(height: 32),
                      _buildSectionTitle('Child Information', textColor),
                      const SizedBox(height: 16),
                      _buildTextField(
                        label: "Child's Name",
                        icon: Icons.child_care,
                        isDarkMode: isDarkMode,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        label: "Child's Age (Years)",
                        icon: Icons.cake_outlined,
                        isDarkMode: isDarkMode,
                      ),
                      const SizedBox(height: 16),

                      // Program Selector
                      Text(
                        'Interested Program',
                        style: GoogleFonts.lexend(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isDarkMode
                              ? Colors.grey[300]
                              : Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        decoration: _inputDecoration(
                          'Select Program',
                          Icons.class_outlined,
                          isDarkMode,
                        ),
                        dropdownColor: surfaceColor,
                        style: GoogleFonts.lexend(color: textColor),
                        items: const [
                          DropdownMenuItem(
                            value: 'Toddlers',
                            child: Text('Toddlers (1.5 - 2.5 yrs)'),
                          ),
                          DropdownMenuItem(
                            value: 'Pre-K',
                            child: Text('Pre-K (2.5 - 3.5 yrs)'),
                          ),
                          DropdownMenuItem(
                            value: 'Kindergarten',
                            child: Text('Kindergarten (3.5 - 5 yrs)'),
                          ),
                          DropdownMenuItem(
                            value: 'Daycare',
                            child: Text('Daycare (After School)'),
                          ),
                        ],
                        onChanged: (val) =>
                            setState(() => selectedProgram = val),
                      ),

                      const SizedBox(height: 16),
                      _buildTextField(
                        label: "Additional Notes / Questions",
                        icon: Icons.note_alt_outlined,
                        isDarkMode: isDarkMode,
                        maxLines: 3,
                      ),

                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Submit logic placeholder
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Enquiry Submitted Successfully! We will contact you soon.',
                                  ),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primary,
                            foregroundColor: backgroundDark,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Submit Enquiry',
                            style: GoogleFonts.lexend(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color color) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            color: primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.lexend(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    required bool isDarkMode,
    int maxLines = 1,
  }) {
    return TextFormField(
      maxLines: maxLines,
      style: GoogleFonts.lexend(
        color: isDarkMode ? Colors.white : Colors.black87,
      ),
      decoration: _inputDecoration(label, icon, isDarkMode),
    );
  }

  InputDecoration _inputDecoration(
    String label,
    IconData icon,
    bool isDarkMode,
  ) {
    var borderColor = isDarkMode
        ? Colors.white.withValues(alpha: 0.1)
        : Colors.grey[200]!;
    return InputDecoration(
      labelText: label,
      labelStyle: GoogleFonts.lexend(
        color: isDarkMode ? Colors.grey[400] : Colors.grey[500],
      ),
      prefixIcon: Icon(
        icon,
        color: isDarkMode ? Colors.grey[400] : Colors.grey[500],
      ),
      filled: true,
      fillColor: isDarkMode ? Colors.black.withValues(alpha: 0.2) : Colors.grey[50]!,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primary, width: 2),
      ),
    );
  }
}
