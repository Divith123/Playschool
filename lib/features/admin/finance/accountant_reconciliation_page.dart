import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class AccountantReconciliationPage extends StatefulWidget {
  const AccountantReconciliationPage({super.key});

  @override
  State<AccountantReconciliationPage> createState() =>
      _AccountantReconciliationPageState();
}

class _AccountantReconciliationPageState
    extends State<AccountantReconciliationPage> {
  final List<Map<String, dynamic>> _bankLines = [
    {
      'id': 'TXN1001',
      'desc': 'STRIPE-PAYMENT-45',
      'amount': 1200.0,
      'date': 'Oct 28',
      'matched': true,
    },
    {
      'id': 'TXN1002',
      'desc': 'CHECK DEPOSIT #88',
      'amount': 500.0,
      'date': 'Oct 28',
      'matched': false,
    },
    {
      'id': 'TXN1003',
      'desc': 'WIRE TRANSFER FEES',
      'amount': -25.0,
      'date': 'Oct 29',
      'matched': true,
    },
  ];

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
          'Bank Reconciliation',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.upload_file, color: textColor),
            tooltip: 'Upload Statement',
          ),
        ],
      ),
      body: Column(
        children: [
          // Summary
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: _buildSummaryBox(
                    'Statement Balance',
                    '\$45,200.00',
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildSummaryBox(
                    'Unreconciled',
                    '\$500.00',
                    Colors.orange,
                  ),
                ),
              ],
            ),
          ),

          // List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _bankLines.length,
              separatorBuilder: (ctx, i) => const Divider(),
              itemBuilder: (ctx, i) {
                return _buildTransactionRow(
                  _bankLines[i],
                  surfaceColor,
                  textColor,
                  isDarkMode,
                );
              },
            ),
          ),

          // Actions
          Container(
            padding: const EdgeInsets.all(16),
            color: surfaceColor,
            child: PrimaryButton(
              label: 'Reconcile All Matches',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Reconciliation Complete!')),
                );
              },
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryBox(String label, String amount, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: GoogleFonts.lexend(color: color, fontSize: 12)),
          const SizedBox(height: 4),
          Text(
            amount,
            style: GoogleFonts.lexend(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionRow(
    Map<String, dynamic> txn,
    Color surfaceColor,
    Color textColor,
    bool isDarkMode,
  ) {
    bool isMatched = txn['matched'];
    bool isCredit = txn['amount'] > 0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            isMatched ? Icons.link : Icons.link_off,
            color: isMatched ? AppColors.success : Colors.orange,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  txn['desc'],
                  style: GoogleFonts.lexend(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    fontSize: 14,
                  ),
                ),
                Text(
                  '${txn['date']} • ${txn['id']}',
                  style: GoogleFonts.lexend(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          Text(
            '${isCredit ? '+' : ''}\$${txn['amount'].abs().toStringAsFixed(2)}',
            style: GoogleFonts.lexend(
              fontWeight: FontWeight.bold,
              color: isCredit ? Colors.green : Colors.red,
            ),
          ),
          const SizedBox(width: 8),
          if (!isMatched)
            TextButton(onPressed: () {}, child: const Text('Match')),
        ],
      ),
    );
  }
}
