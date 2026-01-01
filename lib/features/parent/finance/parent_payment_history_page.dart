import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ParentPaymentHistoryPage extends StatefulWidget {
  const ParentPaymentHistoryPage({super.key});

  @override
  State<ParentPaymentHistoryPage> createState() =>
      _ParentPaymentHistoryPageState();
}

class _ParentPaymentHistoryPageState extends State<ParentPaymentHistoryPage> {
  static const Color primary = Color(0xFF2bee6c);
  static const Color backgroundLight = Color(0xFFf6f8f6);
  static const Color backgroundDark = Color(0xFF102216);
  static const Color surfaceLight = Color(0xFFffffff);
  static const Color surfaceDark = Color(0xFF1a2c20);
  static const Color textMainLight = Color(0xFF0d1b12);
  static const Color textMainDark = Color(0xFFe0e7e3);
  static const Color textSubLight = Color(0xFF4e6d97);

  final List<Map<String, dynamic>> _payments = [
    {
      'date': 'Oct 01, 2023',
      'amount': '\$1,200.00',
      'description': 'Tuition Fee - October',
      'status': 'Paid',
      'invoice': '#INV-2023-1001',
      'method': 'Visa ending in 4242',
    },
    {
      'date': 'Sep 01, 2023',
      'amount': '\$1,200.00',
      'description': 'Tuition Fee - September',
      'status': 'Paid',
      'invoice': '#INV-2023-0901',
      'method': 'Visa ending in 4242',
    },
    {
      'date': 'Aug 15, 2023',
      'amount': '\$450.00',
      'description': 'Annual Supplies Fee',
      'status': 'Paid',
      'invoice': '#INV-2023-0815',
      'method': 'Visa ending in 4242',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode ? backgroundDark : backgroundLight;
    final surfaceColor = isDarkMode ? surfaceDark : surfaceLight;
    final textColor = isDarkMode ? textMainDark : textMainLight;
    final subTextColor = isDarkMode ? Colors.grey[400] : textSubLight;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          'Payment History',
          style: GoogleFonts.lexend(fontWeight: FontWeight.bold),
        ),
        backgroundColor: bgColor,
        foregroundColor: textColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Next Due Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDarkMode
                      ? [const Color(0xFF1a2c20), const Color(0xFF102216)]
                      : [Colors.blue, Colors.purple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Next Payment Due',
                        style: GoogleFonts.lexend(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Nov 01',
                          style: GoogleFonts.lexend(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$1,200.00',
                    style: GoogleFonts.lexend(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Pay Now',
                        style: GoogleFonts.lexend(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // History List
            Row(
              children: [
                Text(
                  'History',
                  style: GoogleFonts.lexend(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.download),
                  onPressed: () {},
                  tooltip: 'Statement',
                ),
              ],
            ),

            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _payments.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final payment = _payments[index];
                return _buildPaymentCard(
                  payment,
                  isDarkMode,
                  surfaceColor,
                  textColor,
                  subTextColor!,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentCard(
    Map<String, dynamic> payment,
    bool isDarkMode,
    Color surfaceColor,
    Color textColor,
    Color subTextColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                payment['date'],
                style: GoogleFonts.lexend(
                  color: subTextColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  payment['status'],
                  style: GoogleFonts.lexend(
                    color: Colors.green,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.white10 : Colors.grey[100],
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.receipt_long, color: textColor),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      payment['description'],
                      style: GoogleFonts.lexend(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      payment['amount'],
                      style: GoogleFonts.lexend(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${payment['method']} • ${payment['invoice']}',
                      style: GoogleFonts.lexend(
                        fontSize: 12,
                        color: subTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.download_rounded, color: primary),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
