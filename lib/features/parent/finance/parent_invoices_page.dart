import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ParentInvoicesPage extends StatefulWidget {
  const ParentInvoicesPage({super.key});

  @override
  State<ParentInvoicesPage> createState() => _ParentInvoicesPageState();
}

class _ParentInvoicesPageState extends State<ParentInvoicesPage> {
  // Color palette matching HTML
  static const Color primary = Color(0xFF2bee6c);
  static const Color backgroundLight = Color(0xFFf6f8f6);
  static const Color backgroundDark = Color(0xFF102216);
  static const Color darkText = Color(0xFF0d1b12);
  static const Color secondaryText = Color(0xFF4c9a66);

  // Custom Green Shades for Abstract Pattern
  // static const Color greenPatternLight = Color(0xFF0d1b12);

  String activeTab = 'outstanding'; // 'outstanding' or 'history'

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode ? backgroundDark : backgroundLight;
    final textColor = isDarkMode ? Colors.white : darkText;
    final subColor = isDarkMode ? Colors.grey[400]! : secondaryText;

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // Sticky Header
              SliverPersistentHeader(
                pinned: true,
                delegate: _StickyHeaderDelegate(
                  child: Container(
                    color: bgColor.withValues(alpha: 0.95),
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: SafeArea(
                      bottom: false,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildCircleButton(
                            icon: Icons.arrow_back,
                            onTap: () => Navigator.pop(context),
                            textColor: textColor,
                            isDarkMode: isDarkMode,
                          ),
                          Text(
                            'Invoices',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          _buildCircleButton(
                            icon: Icons.filter_list,
                            onTap: () {},
                            textColor: textColor,
                            isDarkMode: isDarkMode,
                          ),
                        ],
                      ),
                    ),
                  ),
                  maxHeight: 100, // Adjusted for SafeArea
                  minHeight: 80,
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      // Summary Card
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0d1b12),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 20,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            // Soft gradient overlay
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    const Color(0xFF0d1b12).withValues(alpha: 0.8),
                                    const Color(0xFF0d1b12).withValues(alpha: 0.2),
                                  ],
                                ),
                              ),
                            ),
                            // Content
                            Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Total Outstanding',
                                            style: GoogleFonts.inter(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey[300],
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '\$575.00',
                                            style: GoogleFonts.inter(
                                              fontSize: 36,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              letterSpacing: -1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.account_balance_wallet,
                                          color: primary,
                                          size: 24,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.calendar_today,
                                                size: 18,
                                                color: primary,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                'Due Oct 5th',
                                                style: GoogleFonts.inter(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: primary,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Invoice #INV-2023-001',
                                            style: GoogleFonts.inter(
                                              fontSize: 12,
                                              color: Colors.grey[400],
                                            ),
                                          ),
                                        ],
                                      ),
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: primary,
                                          foregroundColor: const Color(
                                            0xFF0d1b12,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 24,
                                            vertical: 0,
                                          ),
                                          fixedSize: const Size.fromHeight(40),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          elevation: 5,
                                          shadowColor: primary.withValues(alpha: 0.3),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Pay All',
                                              style: GoogleFonts.inter(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            const Icon(
                                              Icons.arrow_forward,
                                              size: 18,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Tabs
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: isDarkMode
                                  ? Colors.white10
                                  : const Color(0xFFcfe7d7),
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            _buildTab(
                              'Outstanding',
                              'outstanding',
                              textColor,
                              isActive: activeTab == 'outstanding',
                            ),
                            _buildTab(
                              'History',
                              'history',
                              isDarkMode ? Colors.grey[400]! : subColor,
                              isActive: activeTab == 'history',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Active Period
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 24,
                    left: 16,
                    right: 16,
                    bottom: 8,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Current Period',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: primary.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'ACTIVE',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode
                                ? Colors.green[300]
                                : Colors.green[700],
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SliverList(
                delegate: SliverChildListDelegate([
                  _buildInvoiceItem(
                    title: 'October Tuition',
                    subtitle: 'Due in 3 days • #1024',
                    amount: '\$550.00',
                    icon: Icons.school,
                    iconBg: const Color(0xFFe7f3eb),
                    iconColor: Colors.green[800]!,
                    isDarkMode: isDarkMode,
                    textColor: textColor,
                    subColor: subColor,
                    btnLabel: 'Pay Now',
                    btnBg: primary.withValues(alpha: 0.1),
                    btnText: isDarkMode ? primary : Colors.green[700]!,
                    hoverColor: primary,
                  ),
                  Divider(
                    height: 1,
                    color: isDarkMode ? Colors.white10 : Colors.grey[100],
                  ),
                  _buildInvoiceItem(
                    title: 'Zoo Field Trip',
                    subtitle: 'Due Tomorrow • #1029',
                    amount: '\$15.00',
                    icon: Icons.directions_bus,
                    iconBg: const Color(0xFFe7f3eb),
                    iconColor: Colors.green[800]!,
                    isDarkMode: isDarkMode,
                    textColor: textColor,
                    subColor: subColor,
                    btnLabel: 'Pay Now',
                    btnBg: primary.withValues(alpha: 0.1),
                    btnText: isDarkMode ? primary : Colors.green[700]!,
                    hoverColor: primary,
                  ),
                ]),
              ),

              // Overdue
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    left: 16,
                    right: 16,
                    bottom: 8,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Attention Required',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.red[400] : Colors.red[600],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? Colors.red[900]!.withValues(alpha: 0.3)
                              : Colors.red[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '1 OVERDUE',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode
                                ? Colors.red[400]
                                : Colors.red[600],
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SliverList(
                delegate: SliverChildListDelegate([
                  _buildInvoiceItem(
                    title: 'September Late Fee',
                    subtitle: 'Overdue by 5 days',
                    subtitleColor: isDarkMode
                        ? Colors.red[400]
                        : Colors.red[500],
                    amount: '\$25.00',
                    amountColor: isDarkMode ? Colors.red[400] : Colors.red[600],
                    icon: Icons.warning,
                    iconBg: isDarkMode
                        ? Colors.red[900]!.withValues(alpha: 0.3)
                        : Colors.red[100]!,
                    iconColor: isDarkMode ? Colors.red[400]! : Colors.red[600]!,
                    isDarkMode: isDarkMode,
                    textColor: textColor,
                    subColor: subColor,
                    btnLabel: 'Pay Now',
                    btnBg: isDarkMode
                        ? Colors.red[900]!.withValues(alpha: 0.5)
                        : Colors.red[100]!,
                    btnText: isDarkMode ? Colors.red[300]! : Colors.red[700]!,
                    bgColor: isDarkMode
                        ? Colors.red[900]!.withValues(alpha: 0.05)
                        : Colors.red[50]!.withValues(alpha: 0.3),
                    isOverdue: true,
                  ),
                ]),
              ),

              // Recent History (Teaser)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 16,
                    left: 16,
                    right: 16,
                    bottom: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Payments',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      Text(
                        'View All',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primary,
                          decoration: TextDecoration
                              .none, // Can replace active navigation logic if needed
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SliverList(
                delegate: SliverChildListDelegate([
                  _buildHistoryItem(
                    title: 'September Tuition',
                    subtitle: 'Paid on Sep 1st',
                    amount: '\$550.00',
                    isDarkMode: isDarkMode,
                    textColor: Colors.grey[600]!,
                    subColor: isDarkMode ? Colors.grey[500]! : subColor,
                    darkModeTextColor: Colors.grey[300]!,
                  ),
                  const SizedBox(height: 80), // Bottom Buffer
                ]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCircleButton({
    required IconData icon,
    required VoidCallback onTap,
    required Color textColor,
    required bool isDarkMode,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
        ),
        child: Icon(icon, color: textColor),
      ),
    );
  }

  Widget _buildTab(
    String label,
    String value,
    Color color, {
    bool isActive = false,
  }) {
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => activeTab = value),
        child: Container(
          padding: const EdgeInsets.only(top: 16, bottom: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isActive ? primary : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isActive
                  ? (Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : darkText)
                  : color,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInvoiceItem({
    required String title,
    required String subtitle,
    required String amount,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required bool isDarkMode,
    required Color textColor,
    required Color subColor,
    required String btnLabel,
    required Color btnBg,
    required Color btnText,
    Color? subtitleColor,
    Color? amountColor,
    Color? bgColor,
    Color? hoverColor,
    bool isOverdue = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: bgColor ?? Colors.transparent,
        border: isOverdue
            ? const Border(left: BorderSide(color: Colors.red, width: 4))
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: iconColor, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        subtitle,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: subtitleColor ?? subColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: amountColor ?? textColor,
                ),
              ),
              const SizedBox(height: 4),
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: btnBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    btnLabel,
                    style: GoogleFonts.inter(
                      fontSize: 12, // xs
                      fontWeight: FontWeight.bold,
                      color: btnText,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem({
    required String title,
    required String subtitle,
    required String amount,
    required bool isDarkMode,
    required Color textColor,
    required Color subColor,
    required Color darkModeTextColor,
  }) {
    return Opacity(
      opacity: 0.7,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.white10 : Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.receipt_long,
                          color: isDarkMode
                              ? Colors.grey[400]
                              : Colors.grey[500],
                          size: 24,
                        ),
                      ),
                      Positioned(
                        right: -2,
                        bottom: -2,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: primary,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isDarkMode
                                  ? backgroundDark
                                  : backgroundLight,
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            Icons.check,
                            size: 10,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: isDarkMode
                                ? darkModeTextColor
                                : textColor, // gray-600 vs dark-300
                          ),
                        ),
                        Text(
                          subtitle,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: subColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  amount,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[500],
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Colors.grey[300],
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.white10 : Colors.grey[100],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.download,
                    size: 18,
                    color: isDarkMode ? Colors.white : darkText,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double maxHeight;
  final double minHeight;

  _StickyHeaderDelegate({
    required this.child,
    required this.maxHeight,
    required this.minHeight,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(_StickyHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
