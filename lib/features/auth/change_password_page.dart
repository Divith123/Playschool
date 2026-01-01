import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change Password',
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
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.lock_reset, color: Colors.orange[800], size: 30),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Create a strong password with at least 8 characters, including a number and a symbol.',
                      style: TextStyle(color: Colors.orange[900], fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            _buildPasswordField(
              'Current Password',
              _obscureCurrent,
              (val) => setState(() => _obscureCurrent = val),
              isDarkMode,
            ),
            const SizedBox(height: 16),
            _buildPasswordField(
              'New Password',
              _obscureNew,
              (val) => setState(() => _obscureNew = val),
              isDarkMode,
            ),
            const SizedBox(height: 16),
            _buildPasswordField(
              'Confirm New Password',
              _obscureConfirm,
              (val) => setState(() => _obscureConfirm = val),
              isDarkMode,
            ),

            const SizedBox(height: 32),
            PrimaryButton(
              label: 'Update Password',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Password Updated Successfully!'),
                  ),
                );
              },
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField(
    String label,
    bool obscure,
    Function(bool) toggle,
    bool isDarkMode,
  ) {
    return TextField(
      obscureText: obscure,
      style: AppTextStyles.bodyLarge(isDarkMode),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.key, color: Colors.grey),
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: () => toggle(!obscure),
        ),
        filled: true,
        fillColor: isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDarkMode ? Colors.white10 : Colors.grey[300]!,
          ),
        ),
      ),
    );
  }
}
