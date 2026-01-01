import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class ParentInstallmentPlannerPage extends StatefulWidget {
  const ParentInstallmentPlannerPage({super.key});

  @override
  State<ParentInstallmentPlannerPage> createState() =>
      _ParentInstallmentPlannerPageState();
}

class _ParentInstallmentPlannerPageState
    extends State<ParentInstallmentPlannerPage> {
  int _months = 3;
  final double _totalFee = 15000.0; // Annual fee

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

    double monthlyAmount = _totalFee / _months;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          'Installment Planner',
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
            // Total Fee
            Center(
              child: Column(
                children: [
                  Text(
                    'Total Annual Fee',
                    style: GoogleFonts.lexend(color: Colors.grey),
                  ),
                  Text(
                    '\$${_totalFee.toStringAsFixed(0)}',
                    style: GoogleFonts.lexend(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            Text(
              'Choose Plan Duration',
              style: GoogleFonts.lexend(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: textColor,
              ),
            ),
            const SizedBox(height: 16),
            Slider(
              value: _months.toDouble(),
              min: 1,
              max: 9,
              divisions: 8,
              activeColor: AppColors.primary,
              label: '$_months Months',
              onChanged: (val) {
                setState(() {
                  _months = val.toInt();
                });
              },
            ),
            Center(
              child: Text(
                '$_months Monthly Installments',
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Breakdown
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildRow(
                    'Installment Amount',
                    '\$${monthlyAmount.toStringAsFixed(2)}',
                    textColor,
                    true,
                  ),
                  const Divider(height: 32),
                  _buildRow('Frequency', 'Monthly', textColor, false),
                  const SizedBox(height: 12),
                  _buildRow(
                    'First Payment Due',
                    'Nov 1, 2025',
                    textColor,
                    false,
                  ),
                  const SizedBox(height: 12),
                  _buildRow(
                    'Last Payment Due',
                    _calculateEndDate(),
                    textColor,
                    false,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
            PrimaryButton(
              label: 'Confirm & Activate Plan',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Plan Activated for $_months months!'),
                    backgroundColor: AppColors.success,
                  ),
                );
                Navigator.pop(context);
              },
              width: double.infinity,
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Includes 2.5% processing fee for >6 months',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _calculateEndDate() {
    DateTime now = DateTime(2025, 11, 1);
    DateTime end = DateTime(now.year, now.month + _months, now.day);
    return '${_getMonth(end.month)} 1, ${end.year}';
  }

  String _getMonth(int m) {
    const list = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return list[m - 1];
  }

  Widget _buildRow(String label, String value, Color textColor, bool isBig) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.lexend(
            color: Colors.grey,
            fontSize: isBig ? 16 : 14,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.lexend(
            color: textColor,
            fontSize: isBig ? 24 : 14,
            fontWeight: isBig ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
