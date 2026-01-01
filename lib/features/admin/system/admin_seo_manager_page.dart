import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class AdminSeoManagerPage extends StatefulWidget {
  const AdminSeoManagerPage({super.key});

  @override
  State<AdminSeoManagerPage> createState() => _AdminSeoManagerPageState();
}

class _AdminSeoManagerPageState extends State<AdminSeoManagerPage> {
  final TextEditingController _titleController = TextEditingController(
    text: 'Sunnydale Playschool - Best Pre-K',
  );
  final TextEditingController _descController = TextEditingController(
    text:
        'Enroll your child in Sunnydale for a world-class early learning experience.',
  );
  final TextEditingController _keywordsController = TextEditingController(
    text: 'playschool, kindergarten, education, kids',
  );

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
          'SEO Settings',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCardHeader('Global Metadata', Icons.public, textColor),
            const SizedBox(height: 16),
            _buildLabel('Meta Title', textColor),
            TextField(
              controller: _titleController,
              style: TextStyle(color: textColor),
              decoration: _buildInputDeco(surfaceColor),
            ),
            const SizedBox(height: 16),
            _buildLabel('Meta Description', textColor),
            TextField(
              controller: _descController,
              maxLines: 3,
              style: TextStyle(color: textColor),
              decoration: _buildInputDeco(surfaceColor),
            ),
            const SizedBox(height: 16),
            _buildLabel('Keywords (comma separated)', textColor),
            TextField(
              controller: _keywordsController,
              style: TextStyle(color: textColor),
              decoration: _buildInputDeco(surfaceColor),
            ),

            const SizedBox(height: 32),
            _buildCardHeader(
              'Social Preview (OG Tags)',
              Icons.share,
              textColor,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[300],
                    child: Icon(Icons.image, color: Colors.grey),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sunnydale Playschool',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        Text(
                          'Enroll today...',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.upload),
              label: const Text('Update Social Image'),
            ),

            const SizedBox(height: 40),
            PrimaryButton(
              label: 'Save SEO Settings',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('SEO Metadata Updated Successfully!'),
                    backgroundColor: AppColors.success,
                  ),
                );
              },
              width: double.infinity,
            ),

            const SizedBox(height: 16),
            Center(
              child: Text(
                'Changes may take time to reflect on search engines.',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardHeader(String title, IconData icon, Color textColor) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary),
        const SizedBox(width: 12),
        Text(
          title,
          style: GoogleFonts.lexend(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String label, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: GoogleFonts.lexend(
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }

  InputDecoration _buildInputDeco(Color surfaceColor) {
    return InputDecoration(
      filled: true,
      fillColor: surfaceColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.all(16),
    );
  }
}
