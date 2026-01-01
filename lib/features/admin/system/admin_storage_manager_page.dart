import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class AdminStorageManagerPage extends StatefulWidget {
  const AdminStorageManagerPage({super.key});

  @override
  State<AdminStorageManagerPage> createState() =>
      _AdminStorageManagerPageState();
}

class _AdminStorageManagerPageState extends State<AdminStorageManagerPage> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode
        ? AppColors.backgroundDark
        : AppColors.backgroundLight;

    final textColor = isDarkMode
        ? AppColors.textMainDark
        : AppColors.textMainLight;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          'Storage Manager',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Usage Circle
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CircularProgressIndicator(
                    value: 0.75,
                    strokeWidth: 20,
                    backgroundColor: Colors.grey.withValues(alpha: 0.2),
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '75%',
                      style: GoogleFonts.lexend(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    Text('Used', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),

            _buildUsageRow('Images & Media', '45 GB', Colors.blue, textColor),
            const Divider(),
            _buildUsageRow('Documents (PDF)', '15 GB', Colors.green, textColor),
            const Divider(),
            _buildUsageRow('Backups', '15 GB', Colors.purple, textColor),

            const SizedBox(height: 40),

            PrimaryButton(
              label: 'Clean Up Old Temp Files',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Cleaning up 2.3 GB of temp files...'),
                  ),
                );
              },
              width: double.infinity,
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {},
              child: const Text('Upgrade Storage Plan'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUsageRow(
    String label,
    String size,
    Color color,
    Color textColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: GoogleFonts.lexend(fontSize: 16, color: textColor),
              ),
            ],
          ),
          Text(
            size,
            style: GoogleFonts.lexend(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
