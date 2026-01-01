import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/features/admin/students/admissions_page.dart';
import 'package:playschool/features/admin/dashboard/admin_dashboard_page.dart';
import 'package:playschool/features/parent/dashboard/parent_dashboard_page.dart';
import 'package:playschool/features/staff/dashboard/staff_dashboard_page.dart';
import 'package:playschool/features/driver/driver_login_page.dart';
import 'package:cached_network_image/cached_network_image.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Custom color palette based on the HTML design
  static const Color primary = Color(0xFF2BEE6C);
  static const Color backgroundLight = Color(0xFFF6F8F6);
  static const Color backgroundDark = Color(0xFF102216);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1A2C20);
  static const Color textMain = Color(0xFF0D1B12);
  static const Color textMuted = Color(0xFF4C9A66);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _handleLogin() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    // Admin Login
    if (email == 'admin@gmail.com' && password == 'admin') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AdminDashboardPage()),
      );
    }
    // Staff Login
    else if (email == 'staff@gmail.com' && password == 'staff') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const StaffDashboardPage()),
      );
    }
    // Default Parent Login
    else {
      // In real app, validate credentials here
      if (email.isNotEmpty && password.isNotEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ParentDashboardPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter credentials'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _handleAdmission() {
    // Navigate to admissions page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AdmissionsPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? backgroundDark : backgroundLight,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: isDarkMode
              ? Brightness.light
              : Brightness.dark,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Header Image & Decoration
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.35,
                  constraints: const BoxConstraints(
                    minHeight: 260,
                    maxHeight: 400,
                  ),
                  child: Stack(
                    children: [
                      // Background image with gradient overlay
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://lh3.googleusercontent.com/aida-public/AB6AXuDrMwBRVT6ZWuDVrDKWoOlifSPGwkV82KQYr5xIOKK_TqOYl_GiU7l30qQ4iA3ATz_-U-SBxqZ2rjYmefxaC5wtVeG6yAvJw26S1r0p_UEUIJo9Ax1AiGS8pCWbgZHFb8of5wyXypskovHLRmBNM3mgQCTfLNk7awYHSI4kiosUbHLnVIzFj18xZ8vJk5mg15YIPDN-UQY4aWZRyAiZYC54TnS-5PljnQhdbZ4LybjC__qrHecgmfzR8qFmeCx_ZVP1fTXtRWAdkIM',
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: isDarkMode
                                  ? const Color(0xFF102216)
                                  : const Color(0xFFF6F8F6),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: primary,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: isDarkMode
                                  ? const Color(0xFF102216)
                                  : const Color(0xFFF6F8F6),
                              child: Icon(
                                Icons.school,
                                size: 80,
                                color: primary.withOpacity(0.3),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Gradient overlay
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.1),
                              Colors.transparent,
                              isDarkMode ? backgroundDark : backgroundLight,
                            ],
                            stops: const [0.0, 0.5, 1.0],
                          ),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                          ),
                        ),
                      ),
                      // Logo/Branding
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 32),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: isDarkMode ? surfaceDark : surfaceLight,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(Icons.school, size: 48, color: primary),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Main Content Area
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      // Welcome Text
                      const SizedBox(height: 8),
                      Container(
                        transform: Matrix4.translationValues(0, -16, 0),
                        child: Column(
                          children: [
                            Text(
                              'Hello, Parents & Staff',
                              style: GoogleFonts.lexend(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.white : textMain,
                                height: 1.2,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Please sign in to continue.',
                              style: GoogleFonts.notoSans(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: isDarkMode
                                    ? Colors.grey[400]
                                    : textMuted,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),

                      // Login Form
                      const SizedBox(height: 16),
                      Form(
                        child: Column(
                          children: [
                            // Email/Username Field
                            _buildTextField(
                              controller: _emailController,
                              hint: 'Email or Username',
                              icon: Icons.person,
                              isPassword: false,
                              isDarkMode: isDarkMode,
                            ),

                            const SizedBox(height: 16),

                            // Password Field
                            _buildTextField(
                              controller: _passwordController,
                              hint: 'Password',
                              icon: Icons.lock,
                              isPassword: true,
                              isDarkMode: isDarkMode,
                            ),

                            // Forgot Password Link
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  // Handle forgot password
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Forgot password functionality coming soon!',
                                      ),
                                      backgroundColor: primary,
                                    ),
                                  );
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: isDarkMode
                                        ? Colors.grey[400]
                                        : textMuted,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 8),

                            // Primary Action - Log In Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _handleLogin,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primary,
                                  foregroundColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 8,
                                  shadowColor: primary.withOpacity(0.25),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Log In',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Icon(
                                      Icons.arrow_forward,
                                      size: 20,
                                      weight: 700,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Divider
                            Stack(
                              children: [
                                Positioned(
                                  child: Container(
                                    height: 1,
                                    color: isDarkMode
                                        ? Colors.grey[700]
                                        : Colors.grey[300],
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    color: isDarkMode
                                        ? backgroundDark
                                        : backgroundLight,
                                    child: Text(
                                      'New to our family?',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: isDarkMode
                                            ? Colors.grey[400]
                                            : Colors.grey[600],
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            // Secondary Action - Start Admission Button
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: _handleAdmission,
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: primary, width: 2),
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: isDarkMode
                                      ? Colors.white
                                      : textMain,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: primary.withOpacity(0.2),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.edit_document,
                                        size: 20,
                                        color: primary,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    const Text(
                                      'Start Admission',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Footer
                      const SizedBox(height: 32),
                      Column(
                        children: [
                          // Need Help Link
                          TextButton.icon(
                            onPressed: () {
                              // Handle support
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Support functionality coming soon!',
                                  ),
                                  backgroundColor: primary,
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.support_agent,
                              size: 18,
                              color: isDarkMode
                                  ? Colors.grey[400]
                                  : Colors.grey[600],
                            ),
                            label: Text(
                              'Need Help? Contact Support',
                              style: GoogleFonts.notoSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: isDarkMode
                                    ? Colors.grey[400]
                                    : Colors.grey[600],
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Biometric Hint (Visual only)
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              onPressed: () {
                                // Visual hint only
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Biometric authentication coming soon!',
                                    ),
                                    backgroundColor: primary,
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.face,
                                size: 36,
                                color: Colors.grey[400],
                              ),
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shape: const CircleBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Driver Login Link
                          TextButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DriverLoginPage(),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.directions_bus,
                              size: 20,
                              color: textMuted,
                            ),
                            label: Text(
                              'Driver Login',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: textMuted,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required bool isPassword,
    required bool isDarkMode,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hint,
          style: const TextStyle(fontSize: 0, fontWeight: FontWeight.normal),
        ),
        Container(
          decoration: BoxDecoration(
            color: isDarkMode ? surfaceDark : surfaceLight,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 52, right: 16),
                child: TextField(
                  controller: controller,
                  obscureText: isPassword ? _obscurePassword : false,
                  obscuringCharacter: '•',
                  style: TextStyle(
                    fontSize: 16,
                    color: isDarkMode ? Colors.white : textMain,
                    fontFamily: 'Noto Sans',
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: hint,
                    hintStyle: TextStyle(
                      color: isDarkMode
                          ? Colors.grey[500]?.withOpacity(0.7)
                          : textMuted.withOpacity(0.7),
                      fontSize: 16,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              // Leading Icon
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 52,
                  alignment: Alignment.center,
                  child: Icon(
                    icon,
                    size: 24,
                    color: isDarkMode ? Colors.grey[400] : textMuted,
                  ),
                ),
              ),
              // Trailing Button for Password
              if (isPassword)
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: 52,
                    alignment: Alignment.center,
                    child: IconButton(
                      onPressed: _togglePasswordVisibility,
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        size: 24,
                        color: isDarkMode ? Colors.grey[400] : textMuted,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
