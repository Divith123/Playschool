import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _isSuccess = false;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    const primary = Color(0xFF2bee6c);
    final bgColor = isDarkMode
        ? const Color(0xFF102216)
        : const Color(0xFFf6f8f6);
    final surfaceColor = isDarkMode ? const Color(0xFF1a2c20) : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.grey[900]!;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: _isSuccess
              ? _buildSuccessView(textColor)
              : _buildFormView(primary, surfaceColor, textColor, isDarkMode),
        ),
      ),
    );
  }

  Widget _buildFormView(
    Color primary,
    Color surfaceColor,
    Color textColor,
    bool isDarkMode,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Forgot Password?',
          style: GoogleFonts.lexend(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Enter your email address to receive a password reset link.',
          style: GoogleFonts.notoSans(
            fontSize: 16,
            color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
          ),
        ),
        const SizedBox(height: 32),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
          ),
          child: TextField(
            controller: _emailController,
            style: TextStyle(color: textColor),
            decoration: InputDecoration(
              border: InputBorder.none,
              icon: Icon(Icons.email_outlined, color: Colors.grey[500]),
              hintText: 'Enter your email',
              hintStyle: TextStyle(color: Colors.grey[500]),
            ),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: _isLoading ? null : _handleReset,
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: _isLoading
                ? const CircularProgressIndicator()
                : Text(
                    'Send Reset Link',
                    style: GoogleFonts.lexend(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessView(Color textColor) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.check_circle_outline,
            size: 80,
            color: Color(0xFF2bee6c),
          ),
          const SizedBox(height: 24),
          Text(
            'Check your email',
            style: GoogleFonts.lexend(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'We have sent a password reset link to ${_emailController.text}',
            textAlign: TextAlign.center,
            style: GoogleFonts.notoSans(fontSize: 16, color: Colors.grey[500]),
          ),
          const SizedBox(height: 32),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Back to Login',
              style: GoogleFonts.lexend(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2bee6c),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleReset() {
    setState(() => _isLoading = true);
    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
        _isSuccess = true;
      });
    });
  }
}
