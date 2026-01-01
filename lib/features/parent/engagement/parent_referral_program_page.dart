import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/widgets/primary_button.dart';

class ParentReferralProgramPage extends StatelessWidget {
  const ParentReferralProgramPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    const String referralCode = 'LEO-2024-X9Z';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Refer & Earn',
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
            Image.network(
              'https://cdn-icons-png.flaticon.com/512/3135/3135715.png', // Placeholder gift icon
              height: 150,
            ),
            const SizedBox(height: 24),
            Text(
              'Invite Friends, Save on Fees!',
              textAlign: TextAlign.center,
              style: AppTextStyles.headingLarge(isDarkMode),
            ),
            const SizedBox(height: 12),
            Text(
              'Share your unique code with other parents. For every successful admission, you get \$100 off your next term fee.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyLarge(
                isDarkMode,
              ).copyWith(color: AppColors.textSubLight),
            ),
            const SizedBox(height: 32),

            // Code Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? AppColors.surfaceDark
                    : AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.5),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.1),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'YOUR REFERRAL CODE',
                    style: AppTextStyles.bodyMedium(
                      isDarkMode,
                    ).copyWith(letterSpacing: 2, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        referralCode,
                        style: GoogleFonts.lexend(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      IconButton(
                        icon: const Icon(Icons.copy),
                        onPressed: () {
                          Clipboard.setData(
                            const ClipboardData(text: referralCode),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Code Copied!')),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
            PrimaryButton(
              label: 'Share via WhatsApp',
              icon: Icons.share,
              onPressed: () {},
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
