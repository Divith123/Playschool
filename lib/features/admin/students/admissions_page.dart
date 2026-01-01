import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdmissionsPage extends StatefulWidget {
  const AdmissionsPage({super.key});

  @override
  State<AdmissionsPage> createState() => _AdmissionsPageState();
}

class _AdmissionsPageState extends State<AdmissionsPage> {
  // Form controllers
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _parentNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  // Program selection
  String? _selectedProgram = 'Toddler';

  // Color palette
  static const Color primary = Color(0xFF2BEE6C);
  static const Color backgroundLight = Color(0xFFF6F8F6);
  static const Color backgroundDark = Color(0xFF102216);
  static const Color textMain = Color(0xFF111418);
  static const Color textMuted = Color(0xFF637588);
  static const Color borderLight = Color(0xFFCFE7D7);

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    _startDateController.dispose();
    _parentNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _handleBack() {
    Navigator.of(context).pop();
  }

  void _handleSendEnquiry() {
    // Show success dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).brightness == Brightness.dark 
              ? const Color(0xFF1A2C22) 
              : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: primary.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle,
                  size: 40,
                  color: primary,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Enquiry Submitted!',
                style: GoogleFonts.lexend(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark 
                      ? Colors.white 
                      : textMain,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Thank you for your interest. We will contact you soon.',
                style: GoogleFonts.notoSans(
                  fontSize: 14,
                  color: Theme.of(context).brightness == Brightness.dark 
                      ? Colors.grey[400] 
                      : textMuted,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(); // Go back to login
              },
              child: Text(
                'OK',
                style: GoogleFonts.notoSans(
                  fontWeight: FontWeight.bold,
                  color: primary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? backgroundDark : backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation
            Container(
              decoration: BoxDecoration(
                color: (isDarkMode ? backgroundDark : backgroundLight).withValues(alpha: 0.95),
                border: Border(
                  bottom: BorderSide(
                    color: isDarkMode ? Colors.grey[800]! : Colors.grey[200]!,
                    width: 1,
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: _handleBack,
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        size: 24,
                        color: isDarkMode ? Colors.white : textMain,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Admissions Enquiry',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lexend(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : textMain,
                        height: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 40), // Spacer for balance
                ],
              ),
            ),

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Content
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Enquire Now',
                            style: GoogleFonts.lexend(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : textMain,
                              height: 1.1,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "We'd love to have your little one join us! Fill out the details below to start the journey.",
                            style: GoogleFonts.notoSans(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: isDarkMode ? Colors.grey[400] : textMuted,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Section 1: Child Details
                    _buildSection(
                      title: 'Child Details',
                      children: [
                        // Name Row
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                controller: _firstNameController,
                                label: 'First Name',
                                hint: 'Noah',
                                isDarkMode: isDarkMode,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildTextField(
                                controller: _lastNameController,
                                label: 'Last Name',
                                hint: 'Smith',
                                isDarkMode: isDarkMode,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // DOB
                        _buildDateField(
                          controller: _dobController,
                          label: 'Date of Birth',
                          icon: Icons.calendar_month,
                          isDarkMode: isDarkMode,
                        ),
                        const SizedBox(height: 16),
                        // Start Date
                        _buildDateField(
                          controller: _startDateController,
                          label: 'Desired Start Date',
                          icon: Icons.event_available,
                          isDarkMode: isDarkMode,
                        ),
                      ],
                    ),

                    // Section 2: Program of Interest
                    _buildSection(
                      title: 'Program of Interest',
                      children: [
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            _buildProgramChip('Infant', isDarkMode),
                            _buildProgramChip('Toddler', isDarkMode),
                            _buildProgramChip('Preschool', isDarkMode),
                            _buildProgramChip('After School', isDarkMode),
                          ],
                        ),
                      ],
                    ),

                    // Section 3: Parent/Guardian Contact
                    _buildSection(
                      title: 'Parent/Guardian Contact',
                      children: [
                        _buildTextFieldWithIcon(
                          controller: _parentNameController,
                          label: 'Full Name',
                          hint: 'Jane Doe',
                          icon: Icons.person,
                          isDarkMode: isDarkMode,
                        ),
                        const SizedBox(height: 16),
                        _buildPhoneField(
                          controller: _phoneController,
                          label: 'Mobile Number',
                          hint: '(555) 123-4567',
                          isDarkMode: isDarkMode,
                        ),
                        const SizedBox(height: 16),
                        _buildTextFieldWithIcon(
                          controller: _emailController,
                          label: 'Email Address',
                          hint: 'jane@example.com',
                          icon: Icons.mail,
                          isDarkMode: isDarkMode,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),
                        _buildTextArea(
                          controller: _notesController,
                          label: 'Notes or Questions (Optional)',
                          hint: 'Any allergies, special needs, or specific questions?',
                          isDarkMode: isDarkMode,
                        ),
                      ],
                    ),

                    // Privacy Notice
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.lock,
                                size: 16,
                                color: isDarkMode ? Colors.grey[400] : textMuted,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Your information is secure and private.',
                                style: GoogleFonts.notoSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: isDarkMode ? Colors.grey[400] : textMuted,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Sticky Bottom CTA
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: (isDarkMode ? backgroundDark : backgroundLight).withValues(alpha: 0.9),
          border: Border(
            top: BorderSide(
              color: isDarkMode ? Colors.grey[800]! : Colors.grey[200]!,
              width: 1,
            ),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 48,
          child: ElevatedButton(
            onPressed: _handleSendEnquiry,
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              foregroundColor: const Color(0xFF102216),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              shadowColor: primary.withValues(alpha: 0.3),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Send Enquiry',
                  style: GoogleFonts.notoSans(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.send,
                  size: 20,
                  weight: 700,
                  color: const Color(0xFF102216),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 12),
          child: Text(
            title,
            style: GoogleFonts.lexend(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).brightness == Brightness.dark ? Colors.white : textMain,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool isDarkMode,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.notoSans(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isDarkMode ? Colors.grey[200] : textMain,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xFF1A2C22) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDarkMode ? Colors.grey[700]! : borderLight,
              width: 1,
            ),
          ),
          child: TextField(
            controller: controller,
            style: GoogleFonts.notoSans(
              fontSize: 16,
              color: isDarkMode ? Colors.white : textMain,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: hint,
              hintStyle: GoogleFonts.notoSans(
                fontSize: 16,
                color: isDarkMode ? Colors.grey[500] : const Color(0xFF93aabf),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool isDarkMode,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.notoSans(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isDarkMode ? Colors.grey[200] : textMain,
          ),
        ),
        const SizedBox(height: 6),
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF1A2C22) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDarkMode ? Colors.grey[700]! : borderLight,
                  width: 1,
                ),
              ),
              child: TextField(
                controller: controller,
                style: GoogleFonts.notoSans(
                  fontSize: 16,
                  color: isDarkMode ? Colors.white : textMain,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    controller.text = '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
                  }
                },
                readOnly: true,
              ),
            ),
            Positioned(
              right: 12,
              top: 12,
              child: Icon(
                icon,
                size: 20,
                color: isDarkMode ? Colors.grey[500] : textMuted,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProgramChip(String program, bool isDarkMode) {
    final isSelected = _selectedProgram == program;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedProgram = program;
        });
      },
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? primary : (isDarkMode ? const Color(0xFF1A2C22) : Colors.white),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? primary : (isDarkMode ? Colors.grey[700]! : borderLight),
            width: 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: primary.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Text(
            program,
            style: GoogleFonts.notoSans(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? const Color(0xFF102216) : (isDarkMode ? Colors.white : textMain),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFieldWithIcon({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required bool isDarkMode,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.notoSans(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isDarkMode ? Colors.grey[200] : textMain,
          ),
        ),
        const SizedBox(height: 6),
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF1A2C22) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDarkMode ? Colors.grey[700]! : borderLight,
                  width: 1,
                ),
              ),
              child: TextField(
                controller: controller,
                keyboardType: keyboardType,
                style: GoogleFonts.notoSans(
                  fontSize: 16,
                  color: isDarkMode ? Colors.white : textMain,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: hint,
                  hintStyle: GoogleFonts.notoSans(
                    fontSize: 16,
                    color: isDarkMode ? Colors.grey[500] : const Color(0xFF93aabf),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 44, vertical: 12),
                ),
              ),
            ),
            Positioned(
              left: 12,
              top: 12,
              child: Icon(
                icon,
                size: 20,
                color: isDarkMode ? Colors.grey[500] : textMuted,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPhoneField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool isDarkMode,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.notoSans(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isDarkMode ? Colors.grey[200] : textMain,
          ),
        ),
        const SizedBox(height: 6),
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF1A2C22) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDarkMode ? Colors.grey[700]! : borderLight,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 48,
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.grey[800] : Colors.grey[50],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                      border: Border(
                        right: BorderSide(
                          color: isDarkMode ? Colors.grey[700]! : borderLight,
                          width: 1,
                        ),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '+1',
                      style: GoogleFonts.notoSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isDarkMode ? Colors.grey[400] : textMuted,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      keyboardType: TextInputType.phone,
                      style: GoogleFonts.notoSans(
                        fontSize: 16,
                        color: isDarkMode ? Colors.white : textMain,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: hint,
                        hintStyle: GoogleFonts.notoSans(
                          fontSize: 16,
                          color: isDarkMode ? Colors.grey[500] : const Color(0xFF93aabf),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextArea({
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool isDarkMode,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.notoSans(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isDarkMode ? Colors.grey[200] : textMain,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xFF1A2C22) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDarkMode ? Colors.grey[700]! : borderLight,
              width: 1,
            ),
          ),
          child: TextField(
            controller: controller,
            maxLines: 4,
            style: GoogleFonts.notoSans(
              fontSize: 16,
              color: isDarkMode ? Colors.white : textMain,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: hint,
              hintStyle: GoogleFonts.notoSans(
                fontSize: 16,
                color: isDarkMode ? Colors.grey[500] : const Color(0xFF93aabf),
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ),
      ],
    );
  }
}
