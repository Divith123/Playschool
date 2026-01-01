import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/widgets/primary_button.dart';

class ParentTransactionReceiptPage extends StatelessWidget {
  const ParentTransactionReceiptPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Receipts are usually white paper style, even in dark mode initially for realism,
    // but let's respect app theme for the container.
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transaction Receipt',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: isDarkMode ? AppColors.textMainDark : AppColors.textMainLight,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white, // Always white for "Paper" look
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        const Icon(
                          Icons.school,
                          size: 64,
                          color: AppColors.primary,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'LITTLE LEARNERS ACADEMY',
                          style: GoogleFonts.lexend(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '123 Education Lane, Cityville',
                          style: GoogleFonts.lexend(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 48, thickness: 2),

                  _buildReceiptRow('Receipt No:', '#TXN-88291'),
                  _buildReceiptRow('Date:', '01 Aug 2024'),
                  _buildReceiptRow('Student:', 'Leo Das (Class 2B)'),
                  _buildReceiptRow(
                    'Payment Method:',
                    'Credit Card (**** 4242)',
                  ),

                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Column(
                      children: [
                        _buildSummaryRow('Tuition Fee (Term 1)', '\$1,200.00'),
                        _buildSummaryRow('Material Fee', '\$300.00'),
                        const Divider(),
                        _buildSummaryRow(
                          'Total Paid',
                          '\$1,500.00',
                          isBold: true,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'PAID',
                        style: GoogleFonts.lexend(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          letterSpacing: 4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'Download PDF',
              icon: Icons.download,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Downloading Receipt...')),
                );
              },
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReceiptRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.lexend(color: Colors.grey[600], fontSize: 14),
          ),
          Text(
            value,
            style: GoogleFonts.lexend(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.lexend(
              color: Colors.black,
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.lexend(
              color: Colors.black,
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
