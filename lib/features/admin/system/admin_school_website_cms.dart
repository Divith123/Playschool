import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class AdminSchoolWebsiteCmsPage extends StatefulWidget {
  const AdminSchoolWebsiteCmsPage({super.key});

  @override
  State<AdminSchoolWebsiteCmsPage> createState() =>
      _AdminSchoolWebsiteCmsPageState();
}

class _AdminSchoolWebsiteCmsPageState extends State<AdminSchoolWebsiteCmsPage> {
  final TextEditingController _bannerTextController = TextEditingController(
    text: 'Admissions Open for 2026!',
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
          'Website CMS',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
        actions: [
          TextButton(onPressed: () {}, child: const Text('Live Preview')),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Hero Banner', textColor),
            const SizedBox(height: 12),
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(
                    'https://placehold.co/600x200/png?text=Hero+Image',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.camera_alt, color: Colors.white, size: 40),
                  style: IconButton.styleFrom(backgroundColor: Colors.black45),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _bannerTextController,
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                labelText: 'Hero Heading Text',
                filled: true,
                fillColor: surfaceColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 32),
            _buildSectionTitle('Latest News Ticker', textColor),
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Annual Sports Day on Nov 15th',
                style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
              ),
              trailing: Switch(
                value: true,
                activeThumbColor: AppColors.primary,
                onChanged: (v) {},
              ),
              leading: Icon(Icons.campaign, color: AppColors.primary),
            ),
            const Divider(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Holiday Notice: Oct 31st',
                style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
              ),
              trailing: Switch(value: false, onChanged: (v) {}),
              leading: Icon(Icons.campaign, color: Colors.grey),
            ),

            const SizedBox(height: 40),
            PrimaryButton(
              label: 'Publish Changes',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Website Updated Successfully!'),
                    backgroundColor: AppColors.success,
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

  Widget _buildSectionTitle(String title, Color textColor) {
    return Text(
      title,
      style: GoogleFonts.lexend(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
    );
  }
}
