import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StaffIncidentReportPage extends StatefulWidget {
  const StaffIncidentReportPage({super.key});

  @override
  State<StaffIncidentReportPage> createState() =>
      _StaffIncidentReportPageState();
}

class _StaffIncidentReportPageState extends State<StaffIncidentReportPage>
    with SingleTickerProviderStateMixin {
  // Colors from HTML/Tailwind Config
  static const Color primary = Color(0xFF2bee6c);
  static const Color backgroundLight = Color(0xFFf6f8f6);
  static const Color backgroundDark = Color(0xFF102216);
  static const Color surfaceLight = Color(0xFFffffff);
  static const Color surfaceDark = Color(0xFF1c3022);
  static const Color darkText = Color(0xFF0d1b12);

  // Form State
  String selectedStudent = 'Leo Thompson';
  String incidentType = 'Fall';
  String severity = 'Low';
  bool notifyParents = true;

  // Animation for Pin
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(
      begin: 0,
      end: 10,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode ? backgroundDark : backgroundLight;
    final surfaceColor = isDarkMode ? surfaceDark : surfaceLight;
    final textColor = isDarkMode ? Colors.white : darkText;
    final subTextColor = isDarkMode ? Colors.grey[400]! : Colors.grey[500]!;

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
                  maxHeight: 70,
                  minHeight: 70,
                  child: Container(
                    color: bgColor.withValues(alpha: 0.95),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SafeArea(
                      bottom: false,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            borderRadius: BorderRadius.circular(20),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.close,
                                color: textColor,
                                size: 24,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Incident Report',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lexend(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(8),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 8,
                              ),
                              child: Text(
                                'Save Draft',
                                style: GoogleFonts.lexend(
                                  color: isDarkMode
                                      ? primary
                                      : Colors.green[700],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 100,
                  ), // Bottom padding for sticky button
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section: Who & When
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                        child: Text(
                          'Who & When?',
                          style: GoogleFonts.lexend(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                            height: 1.1,
                          ),
                        ),
                      ),

                      // Student Selector
                      Container(
                        margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: surfaceColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isDarkMode
                                ? Colors.grey[800]!
                                : Colors.grey[100]!,
                          ),
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
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: const DecorationImage(
                                  image: NetworkImage(
                                    'https://lh3.googleusercontent.com/aida-public/AB6AXuDGm8c4g-cISGtmdzVK_DSzzfmpt6FtM2pL5JQDDxBY2NioWMHibuopyKA66J521UHLeh2URt6MhpzD3VL2B0poFD8tbJF0h6ooOYMjv9Z9mg2Na62d5B5FzVDkFW3NDYb48R-hNFRBVQwggCJFBDrNtypcXNHGpQPotpTzhBUQ1r6BUVuEUAdwAV3dhLlh1F0W9LXG4kKnPuuW9fXgMgTNu-UR-hWLj7_M2Jd_9OvFbbIJKNNSpz0I5AkPT0YkZ36FVejMW2I6QtI',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                  color: isDarkMode
                                      ? Colors.grey[700]!
                                      : Colors.white,
                                  width: 2,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Leo Thompson',
                                    style: GoogleFonts.lexend(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: textColor,
                                    ),
                                  ),
                                  Text(
                                    'Class 3B • Age 5',
                                    style: GoogleFonts.lexend(
                                      fontSize: 14,
                                      color: subTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.chevron_right, color: subTextColor),
                          ],
                        ),
                      ),

                      // Date & Time
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Date',
                                    style: GoogleFonts.lexend(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: isDarkMode
                                          ? Colors.grey[300]
                                          : Colors.grey[700],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    height: 48,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: surfaceColor,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: isDarkMode
                                            ? Colors.grey[700]!
                                            : Colors.grey[200]!,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Oct 24, 2023',
                                            style: GoogleFonts.lexend(
                                              fontSize: 16,
                                              color: textColor,
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.calendar_today,
                                          size: 20,
                                          color: subTextColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Time',
                                    style: GoogleFonts.lexend(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: isDarkMode
                                          ? Colors.grey[300]
                                          : Colors.grey[700],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    height: 48,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: surfaceColor,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: isDarkMode
                                            ? Colors.grey[700]!
                                            : Colors.grey[200]!,
                                      ),
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '10:30 AM',
                                        style: GoogleFonts.lexend(
                                          fontSize: 16,
                                          color: textColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),
                      Divider(
                        height: 1,
                        color: isDarkMode ? Colors.grey[800] : Colors.grey[100],
                      ),
                      const SizedBox(height: 24),

                      // Section: What Happened
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'What Happened?',
                              style: GoogleFonts.lexend(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                                height: 1.1,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Incident Type',
                              style: GoogleFonts.lexend(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: isDarkMode
                                    ? Colors.grey[300]
                                    : Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                _buildChip('Fall', true, isDarkMode),
                                _buildChip('Bump', false, isDarkMode),
                                _buildChip('Cut/Graze', false, isDarkMode),
                                _buildChip('Bite', false, isDarkMode),
                                _buildChip('Other', false, isDarkMode),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Description',
                              style: GoogleFonts.lexend(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: isDarkMode
                                    ? Colors.grey[300]
                                    : Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 100,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: surfaceColor,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isDarkMode
                                      ? Colors.grey[700]!
                                      : Colors.grey[200]!,
                                ),
                              ),
                              child: TextField(
                                maxLines: null,
                                decoration: InputDecoration.collapsed(
                                  hintText: 'Describe exactly what happened...',
                                  hintStyle: GoogleFonts.lexend(
                                    color: isDarkMode
                                        ? Colors.grey[600]
                                        : Colors.grey[400],
                                  ),
                                ),
                                style: GoogleFonts.lexend(
                                  fontSize: 16,
                                  color: textColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            // Severity Toggle
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: surfaceColor,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isDarkMode
                                      ? Colors.grey[700]!
                                      : Colors.grey[200]!,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Severity Level',
                                    style: GoogleFonts.lexend(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: isDarkMode
                                          ? Colors.grey[300]
                                          : Colors.grey[700],
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: isDarkMode
                                          ? Colors.grey[800]
                                          : Colors.grey[100],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: LayoutBuilder(
                                      builder: (context, constraints) {
                                        return Stack(
                                          children: [
                                            AnimatedPositioned(
                                              duration: const Duration(
                                                milliseconds: 300,
                                              ),
                                              left: 4,
                                              top: 4,
                                              bottom: 4,
                                              width:
                                                  (constraints.maxWidth - 8) /
                                                  3,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: isDarkMode
                                                      ? Colors.grey[600]
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withValues(
                                                            alpha: 0.05,
                                                          ),
                                                      blurRadius: 2,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Center(
                                                    child: Text(
                                                      'Low',
                                                      style: GoogleFonts.lexend(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: textColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Center(
                                                    child: Text(
                                                      'Medium',
                                                      style: GoogleFonts.lexend(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: subTextColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Center(
                                                    child: Text(
                                                      'High',
                                                      style: GoogleFonts.lexend(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: subTextColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),
                      Divider(
                        height: 1,
                        color: isDarkMode ? Colors.grey[800] : Colors.grey[100],
                      ),
                      const SizedBox(height: 24),

                      // Section: Injury Location (Body Map)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Injury Location',
                                  style: GoogleFonts.lexend(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                    height: 1.1,
                                  ),
                                ),
                                Text(
                                  'TAP TO MARK',
                                  style: GoogleFonts.lexend(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primary,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Container(
                              // Body Map Container
                              height: 300,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: isDarkMode
                                    ? const Color(0xFF1a2e20)
                                    : const Color(0xFFeef5f0),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Custom Body Paint
                                  CustomPaint(
                                    size: const Size(100, 200),
                                    painter: BodyOutlinePainter(
                                      color: isDarkMode
                                          ? Colors.grey[600]!
                                          : Colors.grey[300]!,
                                    ),
                                  ),
                                  // Injury Pin
                                  Positioned(
                                    top: 120, // 40% of 300
                                    left:
                                        220, // 55% of width approx (assuming full width ~400 on mobile) - wait, this needs to be relative to container center or percentage.
                                    // Let's us Align for simplicity as per CSS "top: 40%, left: 55%"
                                    child: FractionalTranslation(
                                      translation: const Offset(
                                        -0.5,
                                        -0.5,
                                      ), // Center the pin
                                      child: AnimatedBuilder(
                                        animation: _animation,
                                        builder: (context, child) {
                                          return Container(
                                            width: 24,
                                            height: 24,
                                            decoration: BoxDecoration(
                                              color: primary,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 3,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: primary.withValues(
                                                    alpha:
                                                        0.7 *
                                                        (1 - _controller.value),
                                                  ),
                                                  blurRadius: _animation.value,
                                                  spreadRadius:
                                                      _animation.value / 2,
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  // Hacky positioning for "left: 55%, top: 40%" relative to container
                                  // Using a transparent overlay to position the pin exactly like CSS
                                  Positioned.fill(
                                    child: Align(
                                      alignment: const Alignment(
                                        0.1,
                                        -0.2,
                                      ), // 0,0 is center. 0.1 is slightly right (55%), -0.2 is slightly up (40%)
                                      child: SizedBox(
                                        width: 1,
                                        height: 1,
                                      ), // Anchor
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Section: Response
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Response',
                              style: GoogleFonts.lexend(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                                height: 1.1,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Action Taken / First Aid',
                              style: GoogleFonts.lexend(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: isDarkMode
                                    ? Colors.grey[300]
                                    : Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 100,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: surfaceColor,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isDarkMode
                                      ? Colors.grey[700]!
                                      : Colors.grey[200]!,
                                ),
                              ),
                              child: TextField(
                                maxLines: null,
                                decoration: InputDecoration.collapsed(
                                  hintText:
                                      'E.g. Ice applied, cleaned with water...',
                                  hintStyle: GoogleFonts.lexend(
                                    color: isDarkMode
                                        ? Colors.grey[600]
                                        : Colors.grey[400],
                                  ),
                                ),
                                style: GoogleFonts.lexend(
                                  fontSize: 16,
                                  color: textColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Witnesses (Optional)',
                              style: GoogleFonts.lexend(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: isDarkMode
                                    ? Colors.grey[300]
                                    : Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 48,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                color: surfaceColor,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isDarkMode
                                      ? Colors.grey[700]!
                                      : Colors.grey[200]!,
                                ),
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Staff or student names',
                                  hintStyle: GoogleFonts.lexend(
                                    color: isDarkMode
                                        ? Colors.grey[600]
                                        : Colors.grey[400],
                                  ),
                                ),
                                style: GoogleFonts.lexend(
                                  fontSize: 16,
                                  color: textColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Section: Communication
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: primary.withValues(
                              alpha: isDarkMode ? 0.05 : 0.1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: primary.withValues(alpha: 0.2),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: primary.withValues(alpha: 0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.notifications_active,
                                  color: isDarkMode
                                      ? primary
                                      : Colors.green[800],
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Notify Parents Now',
                                      style: GoogleFonts.lexend(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: textColor,
                                      ),
                                    ),
                                    Text(
                                      'Send immediate alert via App & SMS',
                                      style: GoogleFonts.lexend(
                                        fontSize: 12,
                                        color: subTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Switch(
                                value: notifyParents,
                                onChanged: (val) =>
                                    setState(() => notifyParents = val),
                                activeThumbColor: primary,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Sticky Bottom Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: bgColor.withValues(alpha: 0.8),
                border: Border(
                  top: BorderSide(
                    color: isDarkMode ? Colors.grey[800]! : Colors.grey[100]!,
                  ),
                ),
              ),
              child: SafeArea(
                // Ensure button isn't obscured by system gestures
                top: false,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    foregroundColor: const Color(0xFF102216),
                    fixedSize: const Size.fromHeight(56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: GoogleFonts.lexend(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    elevation: 5,
                    shadowColor: primary.withValues(alpha: 0.2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Submit Report'),
                      SizedBox(width: 8),
                      Icon(Icons.send),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String label, bool isSelected, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? primary : (isDarkMode ? surfaceDark : surfaceLight),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected
              ? Colors.transparent
              : (isDarkMode ? Colors.grey[700]! : Colors.grey[200]!),
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.lexend(
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          color: isSelected
              ? const Color(0xFF0d1b12)
              : (isDarkMode ? Colors.grey[300] : Colors.grey[600]),
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

// Custom Painter for Body Outline
class BodyOutlinePainter extends CustomPainter {
  final Color color;

  BodyOutlinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Use hardcoded values scaled to canvas size if possible, or just absolute drawing relative to center
    // We'll draw roughly centered in the container.
    // SVG was 0 0 100 200. Container height 300.

    // Scale factor
    final scale = 1.3;

    canvas.save();
    canvas.translate(
      size.width / 2 - 50 * scale,
      size.height / 2 - 100 * scale,
    );
    canvas.scale(scale);

    // Circle cx="50" cy="25" r="15"
    canvas.drawCircle(const Offset(50, 25), 15, paint);

    // Rect height="60" rx="5" width="30" x="35" y="42"
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(35, 42, 30, 60),
        const Radius.circular(5),
      ),
      paint,
    );

    // Arms
    // Rect height="50" rx="4" transform="rotate(10 15 45)" width="15" x="15" y="45"
    canvas.save();
    canvas.translate(
      15 + 7.5,
      45 + 0,
    ); // Rotate around approximate top-left pivot
    canvas.rotate(10 * 3.14159 / 180);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(-7.5, 0, 15, 50),
        const Radius.circular(4),
      ),
      paint,
    );
    canvas.restore();

    // Rect height="50" rx="4" transform="rotate(-10 70 45)" width="15" x="70" y="45"
    canvas.save();
    canvas.translate(70 + 7.5, 45 + 0);
    canvas.rotate(-10 * 3.14159 / 180);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(-7.5, 0, 15, 50),
        const Radius.circular(4),
      ),
      paint,
    );
    canvas.restore();

    // Legs
    // Rect height="70" rx="4" width="18" x="28" y="100"
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(28, 100, 18, 70),
        const Radius.circular(4),
      ),
      paint,
    );

    // Rect height="70" rx="4" width="18" x="54" y="100"
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(54, 100, 18, 70),
        const Radius.circular(4),
      ),
      paint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
