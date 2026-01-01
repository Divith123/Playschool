import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:playschool/features/admin/finance/admin_expense_tracker_page.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminFinancePage extends StatelessWidget {
  const AdminFinancePage({super.key});

  static const Color primary = Color(0xFF135bec);
  static const Color backgroundLight = Color(0xFFf6f6f8);
  static const Color backgroundDark = Color(0xFF101622);
  static const Color surfaceLight = Color(0xFFffffff);
  static const Color surfaceDark = Color(0xFF1f2937); // gray-800 approx
  static const Color textMainLight = Color(0xFF111827); // gray-900
  static const Color textMainDark = Color(0xFFffffff);
  static const Color textSubLight = Color(0xFF6b7280); // gray-500
  static const Color textSubDark = Color(0xFF9ca3af); // gray-400

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode ? backgroundDark : backgroundLight;
    final surfaceColor = isDarkMode
        ? const Color(0xFF1f2937)
        : surfaceLight; // gray-800
    final textColor = isDarkMode ? textMainDark : textMainLight;
    final subTextColor = isDarkMode ? textSubDark : textSubLight;
    final borderColor = isDarkMode
        ? const Color(0xFF374151)
        : const Color(0xFFe5e7eb); // gray-700 : gray-200

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Sticky Header Placeholder (Actual sticky header is complex in SingleChildScrollView without generic slivers,
                // but we can simulate or just put it at top. For sticky behavior, we usually use CustomScrollView + SliverAppBar
                // or a Stack. The user's other pages used a Stack for sticky header. I will use the same approach.)
                // So I will add top padding here equal to header height.
                SizedBox(height: MediaQuery.of(context).padding.top + 60),

                // Period Filter (Chips)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: Row(
                    children: [
                      _buildFilterChip('This Month', true, isDarkMode),
                      const SizedBox(width: 12),
                      _buildFilterChip('Last Month', false, isDarkMode),
                      const SizedBox(width: 12),
                      _buildFilterChip('Term 1', false, isDarkMode),
                      const SizedBox(width: 12),
                      _buildFilterChip('Term 2', false, isDarkMode),
                    ],
                  ),
                ),

                // Stats Overview
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 16, bottom: 8),
                  child: Row(
                    children: [
                      _buildStatCard(
                        'Total Billed',
                        '\$45,200',
                        '+5%',
                        Icons.receipt_long,
                        primary,
                        Colors.blue,
                        Colors.green,
                        isDarkMode,
                        surfaceColor,
                        borderColor,
                        textColor,
                        subTextColor,
                      ),
                      const SizedBox(width: 16),
                      _buildStatCard(
                        'Collected',
                        '\$32,750',
                        '+12%',
                        Icons.savings,
                        Colors.green,
                        Colors.green,
                        Colors.green,
                        isDarkMode,
                        surfaceColor,
                        borderColor,
                        textColor,
                        subTextColor,
                      ),
                      const SizedBox(width: 16),
                      _buildStatCard(
                        'Outstanding',
                        '\$12,450',
                        '-2%',
                        Icons.warning,
                        Colors.red,
                        Colors.red,
                        Colors.red,
                        isDarkMode,
                        surfaceColor,
                        borderColor,
                        textColor,
                        subTextColor,
                        trendDown: true,
                      ),
                      const SizedBox(width: 16), // Padding right
                    ],
                  ),
                ),

                // Quick Actions Grid
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.flash_on,
                            color: isDarkMode ? Colors.yellow : Colors.amber,
                            size: 20,
                          ), // Placeholder icon for "Quick Actions" logic visual
                          const SizedBox(width: 8),
                          Text(
                            'Quick Actions',
                            style: GoogleFonts.publicSans(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Column(
                        children: [
                          // Generate Invoice (Full width)
                          _buildLargeActionCard(isDarkMode),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: _buildSmallActionCard(
                                  'Add Discount',
                                  Icons.percent,
                                  Colors.orange,
                                  isDarkMode,
                                  surfaceColor,
                                  borderColor,
                                  textColor,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildSmallActionCard(
                                  'Collection Report',
                                  Icons.bar_chart,
                                  Colors.purple,
                                  isDarkMode,
                                  surfaceColor,
                                  borderColor,
                                  textColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: _buildSmallActionCard(
                                  'Expense Tracker',
                                  Icons.receipt,
                                  Colors.blueGrey,
                                  isDarkMode,
                                  surfaceColor,
                                  borderColor,
                                  textColor,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const AdminExpenseTrackerPage(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Expanded(
                                child: SizedBox(),
                              ), // Placeholder to fill row
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Recent Transactions List
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recent Invoices',
                            style: GoogleFonts.publicSans(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'View All',
                              style: GoogleFonts.publicSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildInvoiceItem(
                        'Liam Smith',
                        '\$450.00',
                        'Nursery A • Invoice #1023',
                        'Overdue',
                        Colors.red[50]!,
                        Colors.red[700]!,
                        isDarkMode,
                        surfaceColor,
                        borderColor,
                        textColor,
                        subTextColor,
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuCwNhsjsflK3EeHrAhMERxG74Mgl4AgkXLUXvWrGE388OkmTW250Xm1xXcSw979BNwJnyjdy6wj7QRd7NneZSqQhXvh2N-ln74L6F7CrnzySLqwhI6Btb2_KV8CyBJMl2nYyvKnUH0_2-26lQrTYc4NpiiyKVh9cBjwXzH8Rkk4tQ6EpF-Ockb9h5Y3Etjwm7XfsD1TG90u4uH_X1Wf8mVkv9gKpOCDCSt-WAuVvyO17Qktyh8z89crm4jqRjeVA7U11YAejXJvlVM',
                      ),
                      const SizedBox(height: 12),
                      _buildInvoiceItem(
                        'Emma Johnson',
                        '\$320.00',
                        'Toddlers B • Invoice #1024',
                        'Paid',
                        Colors.green[50]!,
                        Colors.green[700]!,
                        isDarkMode,
                        surfaceColor,
                        borderColor,
                        textColor,
                        subTextColor,
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuAbqYASRI5J9sOVLAuzCiQcaPt0jPKpuffgr3ph79rnzbDEb2y53E735ZzfaL9kz_ujea-KJWnMQB2US_Y1soHNNt-nxQo-DBnO6TF1HmJdbHfWYw1VzoFStsoD8bTMb9FimPpp5_8IbzjPA0B0s_RZl-Yt2k0H0B1WEW76dljgz032Wlj6R7xjiEPhQx-FgkFJ3798y8fdmGoIDEn7f0Zrkz3bdrtz35vKDibTR6KDS064knbJkWHrfDrMpJoC9815WKiQ2x-w4kc',
                      ),
                      const SizedBox(height: 12),
                      _buildInvoiceItem(
                        'Noah Brown',
                        '\$150.00',
                        'Preschool 1 • Invoice #1025',
                        'Partial',
                        Colors.yellow[50]!,
                        Colors.yellow[800]!,
                        isDarkMode,
                        surfaceColor,
                        borderColor,
                        textColor,
                        subTextColor,
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuBCFtW6X2Bp-2q94pFCTBTFu2uvIZhCiIP2doZS47JCIsFhNOtIVy6HyxadlRC8gi4VD3Yl4wCr0bVW1y66lGflic3QPWTNoQJptpyO4cjTT7CKISb18evi1oaxrkRAk-aKfV7TxUBQdEYN3ziqVxbMn5mfg4nsUmYgoAaw5Sakg7_iU3DNTE7fbLO1rO3PJOp3CstyQ70iCFnoLRKLTmWh8JrCcM4EKDkY1uorGXJI3B7Ey9q06pIWi5PMXi5SNE8YBcT_zUcjtEY',
                      ),
                      const SizedBox(height: 12),
                      _buildInvoiceItem(
                        'Sophia Chen',
                        '\$320.00',
                        'Toddlers B • Invoice #1026',
                        'Paid',
                        Colors.green[50]!,
                        Colors.green[700]!,
                        isDarkMode,
                        surfaceColor,
                        borderColor,
                        textColor,
                        subTextColor,
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuDUplpgB0lysq1_hrc6eFNh4vDQRDKWezT2tnWTzAH1uK6gLypYfLHzlMvGtnqhFK-Dk4CrrI2VMMleJXzZNdET27DXEDrK_UyoOD9mW_4BiL9ER-AU1r3frtCKf3fLoW2lVjwbu1dyU90F0SgiH00uHb0z0Dh03pdK3TxOQgCePP6QfMfA4dlkMa6-SjfrYXwI7D6OMc5oN9Ce2AVHt2UMYTVjXJW3efjdT9H0XTve53f0aJO8z8WIg08AnAD-WZCeIOlU5w6bVuU',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Sticky Header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                    bottom: 12,
                    left: 16,
                    right: 16,
                  ),
                  decoration: BoxDecoration(
                    color: bgColor.withValues(alpha: 0.95),
                    border: Border(bottom: BorderSide(color: borderColor)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 40,
                          height: 40,
                          alignment: Alignment.center,
                          child: Icon(Icons.arrow_back, color: textColor),
                        ),
                      ),
                      Text(
                        'Billing Dashboard',
                        style: GoogleFonts.publicSans(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 40,
                          height: 40,
                          alignment: Alignment.center,
                          child: Icon(Icons.filter_list, color: textColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Floating Action Button
          Positioned(
            bottom: 24,
            right: 24,
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withValues(alpha: 0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 32),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? primary
            : (isDarkMode ? const Color(0xFF1f2937) : Colors.white),
        borderRadius: BorderRadius.circular(20),
        border: isSelected
            ? null
            : Border.all(
                color: isDarkMode
                    ? const Color(0xFF374151)
                    : const Color(0xFFe5e7eb),
              ),
      ),
      child: Text(
        label,
        style: GoogleFonts.publicSans(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: isSelected
              ? Colors.white
              : (isDarkMode
                    ? const Color(0xFFd1d5db)
                    : const Color(0xFF4b5563)), // gray-300 : gray-600
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    String trend,
    IconData icon,
    Color primaryColor,
    Color iconBgBase,
    Color trendColor,
    bool isDarkMode,
    Color surfaceColor,
    Color borderColor,
    Color textColor,
    Color subTextColor, {
    bool trendDown = false,
  }) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? iconBgBase.withValues(alpha: 0.3)
                      : iconBgBase.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 16, color: primaryColor),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.publicSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: subTextColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.publicSans(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                trendDown ? Icons.trending_down : Icons.trending_up,
                size: 16,
                color: trendDown ? Colors.red : Colors.green,
              ),
              const SizedBox(width: 2),
              Text(
                trend,
                style: GoogleFonts.publicSans(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: trendDown ? Colors.red : Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLargeActionCard(bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add_card,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const Icon(Icons.arrow_forward, color: Colors.white70, size: 24),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Generate Invoice',
            style: GoogleFonts.publicSans(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Create monthly or recurring fees',
            style: GoogleFonts.publicSans(
              fontSize: 12,
              color: Colors.blue[100],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallActionCard(
    String label,
    IconData icon,
    Color color,
    bool isDarkMode,
    Color surfaceColor,
    Color borderColor,
    Color textColor, {
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? color.withValues(alpha: 0.3)
                    : color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: GoogleFonts.publicSans(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInvoiceItem(
    String name,
    String amount,
    String subtext,
    String status,
    Color statusBg,
    Color statusText,
    bool isDarkMode,
    Color surfaceColor,
    Color borderColor,
    Color textColor,
    Color subTextColor,
    String imageUrl,
  ) {
    // Override colors for dark mode chips if needed
    final chipBg = isDarkMode ? statusText.withValues(alpha: 0.2) : statusBg;
    final chipText = isDarkMode ? statusText.withValues(alpha: 0.8) : statusText;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200],
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.publicSans(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    Text(
                      amount,
                      style: GoogleFonts.publicSans(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      subtext.split(
                        ' • ',
                      )[0], // Truncate or keep depending on space
                      style: GoogleFonts.publicSans(
                        fontSize: 12,
                        color: subTextColor,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: chipBg,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: chipText.withValues(alpha: 0.1)),
                      ),
                      child: Text(
                        status,
                        style: GoogleFonts.publicSans(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: chipText,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
