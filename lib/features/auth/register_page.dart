import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Account',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: isDarkMode ? AppColors.textMainDark : AppColors.textMainLight,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Join Playschool',
              style: AppTextStyles.headingLarge(
                isDarkMode,
              ).copyWith(fontSize: 32),
            ),
            Text(
              'Connect with your school community.',
              style: AppTextStyles.bodyLarge(
                isDarkMode,
              ).copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 32),

            _buildDropdown('I am a...', [
              'Parent',
              'Teacher',
              'Staff',
            ], isDarkMode),
            const SizedBox(height: 16),
            _buildTextField('Full Name', Icons.person, isDarkMode),
            const SizedBox(height: 16),
            _buildTextField('Email Address', Icons.email, isDarkMode),
            const SizedBox(height: 16),
            _buildTextField('Mobile Number', Icons.phone, isDarkMode),
            const SizedBox(height: 16),
            _buildPasswordField('Password', isDarkMode),
            const SizedBox(height: 16),
            _buildPasswordField('Confirm Password', isDarkMode),

            const SizedBox(height: 32),
            PrimaryButton(
              label: 'Sign Up',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Registration Successful! Please Login.'),
                  ),
                );
              },
              width: double.infinity,
            ),
            const SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Already have an account? Login',
                  style: TextStyle(color: AppColors.primary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, bool isDarkMode) {
    return TextField(
      style: AppTextStyles.bodyLarge(isDarkMode),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey),
        filled: true,
        fillColor: isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildPasswordField(String label, bool isDarkMode) {
    return TextField(
      obscureText: _obscurePassword,
      style: AppTextStyles.bodyLarge(isDarkMode),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.lock, color: Colors.grey),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
        ),
        filled: true,
        fillColor: isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, bool isDarkMode) {
    return DropdownButtonFormField<String>(
      initialValue: items.first,
      items: items
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: (val) {},
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.badge, color: Colors.grey),
        filled: true,
        fillColor: isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      dropdownColor: isDarkMode
          ? AppColors.surfaceDark
          : AppColors.surfaceLight,
    );
  }
}
