import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class ParentEditProfilePage extends StatefulWidget {
  const ParentEditProfilePage({super.key});

  @override
  State<ParentEditProfilePage> createState() => _ParentEditProfilePageState();
}

class _ParentEditProfilePageState extends State<ParentEditProfilePage> {
  final _nameController = TextEditingController(text: 'Joseph Das');
  final _emailController = TextEditingController(text: 'joseph@example.com');
  final _phoneController = TextEditingController(text: '+1 987 654 3210');

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
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
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.person, size: 50, color: Colors.grey[600]),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: AppColors.primary,
                    child: const Icon(
                      Icons.camera_alt,
                      size: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildTextField('Full Name', _nameController, isDarkMode),
            const SizedBox(height: 16),
            _buildTextField('Email Address', _emailController, isDarkMode),
            const SizedBox(height: 16),
            _buildTextField('Phone Number', _phoneController, isDarkMode),
            const SizedBox(height: 32),
            PrimaryButton(
              label: 'Save Changes',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile Updated!')),
                );
              },
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    bool isDarkMode,
  ) {
    return TextField(
      controller: controller,
      style: AppTextStyles.bodyLarge(isDarkMode),
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
