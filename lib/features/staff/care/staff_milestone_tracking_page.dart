import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StaffMilestoneTrackingPage extends StatefulWidget {
  const StaffMilestoneTrackingPage({super.key});

  @override
  State<StaffMilestoneTrackingPage> createState() =>
      _StaffMilestoneTrackingPageState();
}

class _StaffMilestoneTrackingPageState
    extends State<StaffMilestoneTrackingPage> {
  // Color Palette
  static const Color primary = Color(0xFF2bee6c);
  static const Color primaryDark = Color(0xFF22bd56);
  static const Color backgroundLight = Color(0xFFf6f8f6);
  static const Color backgroundDark = Color(0xFF102216);
  static const Color surfaceLight = Color(0xFFffffff);
  static const Color surfaceDark = Color(0xFF1a3322);
  static const Color textMainLight = Color(0xFF0d1b12);
  static const Color textMainDark = Color(0xFFf0fdf4);
  static const Color textSubLight = Color(0xFF4c9a66);
  static const Color textSubDark = Color(0xFF8fc7a6);

  String selectedDomain = 'Physical';

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode ? backgroundDark : backgroundLight;
    final surfaceColor = isDarkMode ? surfaceDark : surfaceLight;
    final textMain = isDarkMode ? textMainDark : textMainLight;
    final textSub = isDarkMode ? textSubDark : textSubLight;

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // Sticky Header
              SliverAppBar(
                pinned: true,
                backgroundColor: bgColor.withValues(alpha: 0.95),
                elevation: 0,
                leading: Center(
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDarkMode ? Colors.grey[800] : Colors.grey[100],
                      ),
                      child: Icon(Icons.arrow_back, color: textMain),
                    ),
                  ),
                ),
                title: Text(
                  'Milestone Tracking',
                  style: GoogleFonts.lexend(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textMain,
                  ),
                ),
                actions: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? Colors.grey[800]
                                : Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'History',
                            style: GoogleFonts.lexend(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? primary : primaryDark,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(1.0),
                  child: Container(
                    color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                    height: 1.0,
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Column(
                  children: [
                    // Profile Header
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: surfaceColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isDarkMode
                                ? Colors.grey[800]!
                                : Colors.grey[100]!,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: primary, width: 2),
                                image: const DecorationImage(
                                  image: NetworkImage(
                                    'https://lh3.googleusercontent.com/aida-public/AB6AXuDpmnQyHRNiLB4UQoUScPylzPL1y9LardjiPw0unnbrFpVP5rP7M47WfLSQqS8WFk4NsbTk5KdRi2k5Nn6rllSw7Z7Jq_2vVmtEcXdPlrCqwvQhajCFczovO0xDAEeWlaiUMGJpnhr5MDyTtG0awk3ZK3SrBpCWALbHXL2qLXc9Ab4oA482pEtlFFFnNrxTK9ZTLu7cFe7-Xr-g8RMEeUqqlpdba8z7KiW5sbyID5MXzSiqB4CudpfOrKr4qi2EmkPTymRNhNw99ug',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Leo Das',
                                        style: GoogleFonts.lexend(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: textMain,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: primary.withValues(alpha: 0.2),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Text(
                                          'Present',
                                          style: GoogleFonts.lexend(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: isDarkMode
                                                ? Colors.green[100]
                                                : Colors.green[800],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '3 Years Old • Class 2B',
                                    style: GoogleFonts.lexend(
                                      fontSize: 14,
                                      color: textSub,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Term: Fall 2023',
                                    style: GoogleFonts.lexend(
                                      fontSize: 12,
                                      color: textSub,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Progress Bar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Curriculum Progress',
                                style: GoogleFonts.lexend(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: textMain.withValues(alpha: 0.8),
                                ),
                              ),
                              Text(
                                '65%',
                                style: GoogleFonts.lexend(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: isDarkMode ? primary : primaryDark,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 10,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.grey[800]
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: 0.65,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: primary,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),

              // Domain Chips (Horizontal Scroll)
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  minHeight: 60.0,
                  maxHeight: 60.0,
                  child: Container(
                    color: bgColor, // Keep background opaque for sticky effect
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          _buildDomainChip(
                            'Physical',
                            Icons.directions_run,
                            true,
                            isDarkMode,
                          ),
                          const SizedBox(width: 12),
                          _buildDomainChip(
                            'Social',
                            Icons.sentiment_satisfied,
                            false,
                            isDarkMode,
                          ),
                          const SizedBox(width: 12),
                          _buildDomainChip(
                            'Language',
                            Icons.translate,
                            false,
                            isDarkMode,
                          ),
                          const SizedBox(width: 12),
                          _buildDomainChip(
                            'Literacy',
                            Icons.menu_book,
                            false,
                            isDarkMode,
                          ),
                          const SizedBox(width: 12),
                          _buildDomainChip(
                            'Math',
                            Icons.calculate,
                            false,
                            isDarkMode,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Section Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Physical Development',
                          style: GoogleFonts.lexend(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: textMain,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? Colors.grey[800]
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '2/5 Completed',
                            style: GoogleFonts.lexend(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: textMain,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Milestone Card 1: Completed
                    _buildMilestoneCard(
                      title: 'Demonstrates hand-eye coordination',
                      description: 'Expected: Able to catch a large ball.',
                      status: 'Mastered',
                      isCompleted: true,
                      evidenceImage:
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuACYWK1CR-VZK-71k4u3W4gAdWRBDN4n7Oq4klEm0O01x3zyQqfOzLanHsQkHGn_5bH-Yzny7i1fA3PHOSccjA_9U68VyLwi4ATabE1_CsuzJjZF-mEAsEFDRdyi9kyRKATh4QPivP_NrjyuwL5gXZsWOQnNfAMxYo4hQffba-hYmBRw5zoTi41DA_hHnTNmdKVCIyuFSwN9oEgZGdN7uqOCav9fKatLF0gcFZsZyhMauAXIDd6_YK-baKiV_uwiMkxsQlLydxHk8Q',
                      note: '"Caught the ball 3/3 times today!"',
                      isDarkMode: isDarkMode,
                      surfaceColor: surfaceColor,
                      textMain: textMain,
                      textSub: textSub,
                    ),
                    const SizedBox(height: 16),

                    // Milestone Card 2: Emerging
                    _buildMilestoneCard(
                      title: 'Balances on one foot',
                      description: 'Expected: 5 seconds without support.',
                      status: 'Emerging',
                      isCompleted: false,
                      showActions: true,
                      isDarkMode: isDarkMode,
                      surfaceColor: surfaceColor,
                      textMain: textMain,
                      textSub: textSub,
                    ),
                    const SizedBox(height: 16),

                    // Milestone Card 3: Not Started
                    Opacity(
                      opacity: 0.9,
                      child: _buildMilestoneCard(
                        title: 'Walks up stairs alternating feet',
                        description: 'Without holding railing.',
                        status: 'Not Yet',
                        isCompleted: false,
                        showMoreActions: true,
                        isDarkMode: isDarkMode,
                        surfaceColor: surfaceColor,
                        textMain: textMain,
                        textSub: textSub,
                      ),
                    ),
                    const SizedBox(height: 100), // Spacing for bottom bar
                  ]),
                ),
              ),
            ],
          ),

          // Floating Action / Bottom Bar
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
                    color: isDarkMode ? Colors.grey[800]! : Colors.grey[200]!,
                  ),
                ),
              ),
              child: ClipRect(
                // Backdrop filter hack if needed, or just opacity
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              color: isDarkMode ? surfaceDark : surfaceLight,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isDarkMode
                                    ? Colors.grey[700]!
                                    : Colors.grey[200]!,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.save, size: 20, color: textMain),
                                const SizedBox(width: 8),
                                Text(
                                  'Save Draft',
                                  style: GoogleFonts.lexend(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: textMain,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: primary.withValues(alpha: 0.2),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Update Progress',
                                  style: GoogleFonts.lexend(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.arrow_forward,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ],
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
        ],
      ),
    );
  }

  Widget _buildDomainChip(
    String label,
    IconData icon,
    bool isSelected,
    bool isDarkMode,
  ) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isSelected
            ? primary
            : (isDarkMode ? const Color(0xFF1a3322) : Colors.white),
        borderRadius: BorderRadius.circular(18), // Full rounded
        border: Border.all(
          color: isSelected
              ? Colors.transparent
              : (isDarkMode ? Colors.grey[700]! : Colors.grey[200]!),
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: primary.withValues(alpha: 0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: isSelected ? Colors.black : Colors.grey[500],
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected
                  ? Colors.black
                  : (isDarkMode ? Colors.white : Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMilestoneCard({
    required String title,
    required String description,
    required String status,
    required bool isCompleted,
    String? evidenceImage,
    String? note,
    bool showActions = false,
    bool showMoreActions = false,
    required bool isDarkMode,
    required Color surfaceColor,
    required Color textMain,
    required Color textSub,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode ? Colors.grey[800]! : Colors.grey[100]!,
        ),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 2),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.lexend(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: textMain,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: GoogleFonts.lexend(fontSize: 14, color: textSub),
                    ),
                  ],
                ),
              ),
              if (isCompleted)
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Icon(Icons.check_circle, color: primary, size: 24),
                ),
            ],
          ),
          const SizedBox(height: 16),

          // Segmented Control
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? Colors.black.withValues(alpha: 0.4)
                  : Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                _buildSegmentOption('Not Yet', status == 'Not Yet', isDarkMode),
                _buildSegmentOption(
                  'Emerging',
                  status == 'Emerging',
                  isDarkMode,
                ),
                _buildSegmentOption(
                  'Mastered',
                  status == 'Mastered',
                  isDarkMode,
                ),
              ],
            ),
          ),

          if (evidenceImage != null && note != null) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isDarkMode ? Colors.grey[700]! : Colors.grey[200]!,
                    ),
                    image: DecorationImage(
                      image: NetworkImage(evidenceImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? Colors.white.withValues(alpha: 0.05)
                          : Colors.grey[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isDarkMode
                            ? Colors.grey[800]!
                            : Colors.grey[100]!,
                      ),
                    ),
                    child: Text(
                      note,
                      style: GoogleFonts.lexend(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: textMain,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ],

          if (showActions) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    Icons.add_a_photo,
                    'Add Evidence',
                    isDarkMode,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildActionButton(
                    Icons.edit_note,
                    'Add Note',
                    isDarkMode,
                  ),
                ),
              ],
            ),
          ],

          if (showMoreActions) ...[
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () {},
                icon: Text(
                  'More Actions',
                  style: GoogleFonts.lexend(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? primary : primaryDark,
                  ),
                ),
                label: Icon(
                  Icons.expand_more,
                  size: 16,
                  color: isDarkMode ? primary : primaryDark,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSegmentOption(String label, bool isSelected, bool isDarkMode) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? (label == 'Mastered'
                    ? primary
                    : (isDarkMode ? Colors.grey[700] : Colors.white))
              : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: isSelected && label != 'Mastered'
              ? Border.all(
                  color: isDarkMode ? Colors.grey[600]! : Colors.grey[200]!,
                )
              : null,
          boxShadow: isSelected && label != 'Mastered'
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 2,
                  ),
                ]
              : [],
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.lexend(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected
                ? (label == 'Mastered'
                      ? Colors.black
                      : (isDarkMode ? Colors.white : Colors.black))
                : (isDarkMode ? Colors.grey[400] : Colors.grey[500]),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, bool isDarkMode) {
    return CustomPaint(
      painter: _DashedBorderPainter(
        color: isDarkMode ? Colors.grey[600]! : Colors.grey[300]!,
        strokeWidth: 1,
        dashPattern: [6, 4],
        radius: 8,
      ),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.white.withValues(alpha: 0.05) : Colors.grey[50],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: isDarkMode ? Colors.grey[400] : Colors.grey[500],
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.lexend(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? Colors.grey[400] : Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final List<double> dashPattern;
  final double radius;

  _DashedBorderPainter({
    required this.color,
    this.strokeWidth = 1,
    this.dashPattern = const [5, 3],
    this.radius = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final Path path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(radius),
        ),
      );

    Path dashedPath = Path();
    double distance = 0.0;
    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        double len = dashPattern[0];
        if (distance + len > pathMetric.length) {
          len = pathMetric.length - distance;
        }
        dashedPath.addPath(
          pathMetric.extractPath(distance, distance + len),
          Offset.zero,
        );
        distance += dashPattern[0];
        distance += dashPattern[1];
      }
      distance = 0.0; // Reset for next contour (though RRect has only one)
    }

    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(_DashedBorderPainter oldDelegate) {
    return color != oldDelegate.color ||
        strokeWidth != oldDelegate.strokeWidth ||
        dashPattern != oldDelegate.dashPattern ||
        radius != oldDelegate.radius;
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
