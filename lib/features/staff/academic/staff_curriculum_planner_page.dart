import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StaffCurriculumPlannerPage extends StatefulWidget {
  const StaffCurriculumPlannerPage({super.key});

  @override
  State<StaffCurriculumPlannerPage> createState() =>
      _StaffCurriculumPlannerPageState();
}

class _StaffCurriculumPlannerPageState
    extends State<StaffCurriculumPlannerPage> {
  // Color Palette
  static const Color primary = Color(0xFF2bee6c);
  static const Color backgroundLight = Color(0xFFf6f8f6);
  static const Color backgroundDark = Color(0xFF102216);
  static const Color surfaceLight = Color(0xFFffffff);
  static const Color surfaceDark = Color(
    0xFF1c3022,
  ); // Slightly lighter for cards
  static const Color darkText = Color(0xFF0d1b12);

  // State
  int selectedDay = 17;
  String selectedView = 'Daily';

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode ? backgroundDark : backgroundLight;
    final surfaceColor = isDarkMode ? surfaceDark : surfaceLight;
    final textColor = isDarkMode ? Colors.white : darkText;

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // Sticky Header
              SliverPersistentHeader(
                pinned: true,
                delegate: _PlannerHeaderDelegate(
                  maxHeight: 220, // Height for header + chips + dates
                  minHeight: 180, // Collapsed height
                  child: Container(
                    color: bgColor.withValues(alpha: 0.95),
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: SafeArea(
                      bottom: false,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Top Bar
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () => Navigator.pop(context),
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isDarkMode
                                        ? Colors.white.withValues(alpha: 0.1)
                                        : Colors.black.withValues(alpha: 0.05),
                                  ),
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: textColor,
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Curriculum Planner',
                                    style: GoogleFonts.lexend(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: textColor,
                                    ),
                                  ),
                                  Text(
                                    'Class: Toddlers 2B',
                                    style: GoogleFonts.lexend(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: isDarkMode
                                          ? Colors.grey[400]
                                          : Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: const DecorationImage(
                                    image: NetworkImage(
                                      'https://lh3.googleusercontent.com/aida-public/AB6AXuADVOkWLGcMB-MmVK-hlZsAHTHdlOqkiJeJKwUzevHxCtlwBU0g9YirjyrHTYGmSdUEGIDpZQ7v2ItofDwf6m2HE7tjy5NkacDReWalNnFJUarGNddcNZahJ3h46jU1WP7Ut5N08wcg81kczHTpsFkw3dbxaefQc20IILQMM5bdqpNUf5cK_EHuV5zGM9knU6MUNofjooU6p5YLKs0TEQSXxAEO6bdV_uJG9RhV7sk0fxCuvr68-qfyPdO0PBbveT7rs3hJ-M5s7Tc',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  color: Colors.grey[300],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // View Toggle (Chips)
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.grey[800]
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                _buildViewChip('Daily', isDarkMode),
                                _buildViewChip('Weekly', isDarkMode),
                                _buildViewChip('Monthly', isDarkMode),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Horizontal Date Picker
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                _buildDateCard('Mon', 16, false, isDarkMode),
                                const SizedBox(width: 12),
                                _buildDateCard(
                                  'Tue',
                                  17,
                                  true,
                                  isDarkMode,
                                ), // Selected
                                const SizedBox(width: 12),
                                _buildDateCard('Wed', 18, false, isDarkMode),
                                const SizedBox(width: 12),
                                _buildDateCard('Thu', 19, false, isDarkMode),
                                const SizedBox(width: 12),
                                _buildDateCard('Fri', 20, false, isDarkMode),
                                const SizedBox(width: 12),
                                _buildDateCard('Sat', 21, false, isDarkMode),
                              ],
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
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                  child: Column(
                    children: [
                      // Theme of the Week Card
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: primary.withValues(alpha: 0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Stack(
                          clipBehavior: Clip.antiAlias,
                          children: [
                            Positioned(
                              top: -16,
                              right: -16,
                              child: Container(
                                width: 128,
                                height: 128,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withValues(alpha: 0.2),
                                ),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 10,
                                    sigmaY: 10,
                                  ),
                                  child: Container(),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: -32,
                              left: 40,
                              child: Container(
                                width: 160,
                                height: 160,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black.withValues(alpha: 0.05),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                            "This Week's Theme",
                                            style: GoogleFonts.lexend(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: darkText.withValues(alpha: 0.7),
                                              letterSpacing: 0.5,
                                              height: 1.5,
                                            ),
                                          ),
                                          Text(
                                            "Space Exploration 🚀",
                                            style: GoogleFonts.lexend(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: darkText,
                                              height: 1.2,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            "Focus on planets, stars, and rockets.",
                                            style: GoogleFonts.lexend(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: darkText.withValues(alpha: 0.8),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: 48,
                                        height: 48,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withValues(alpha: 0.3),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.rocket_launch,
                                          color: darkText,
                                          size: 28,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),

                                  // Progress
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Planning Progress",
                                        style: GoogleFonts.lexend(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: darkText,
                                        ),
                                      ),
                                      Text(
                                        "60%",
                                        style: GoogleFonts.lexend(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: darkText,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    height: 10,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: darkText.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: FractionallySizedBox(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: 0.6,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: darkText,
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "3/5 Days Planned",
                                      style: GoogleFonts.lexend(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: darkText.withValues(alpha: 0.7),
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

                      // Timeline Title
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tuesday's Schedule",
                            style: GoogleFonts.lexend(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          Text(
                            "View All",
                            style: GoogleFonts.lexend(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Activity Timeline
                      Stack(
                        children: [
                          // Vertical Line
                          Positioned(
                            left: 68,
                            top: 24,
                            bottom: 0,
                            width: 1,
                            child: Container(
                              color: isDarkMode
                                  ? Colors.grey[800]
                                  : Colors.grey[200],
                            ),
                          ),

                          Column(
                            children: [
                              _buildTimelineItem(
                                time: '09:00',
                                ampm: 'AM',
                                title: 'Circle Time & Attendance',
                                description:
                                    'Morning greeting song and discussing the day\'s space theme. "Good morning, Astronauts!"',
                                statusIcon: Icons.check_circle,
                                statusColor: primary,
                                tags: ['Social', 'Music'],
                                isDarkMode: isDarkMode,
                                surfaceColor: surfaceColor,
                                textColor: textColor,
                                connectorColor: primary,
                              ),
                              const SizedBox(height: 24),
                              _buildTimelineItem(
                                time: '09:30',
                                ampm: 'AM',
                                title: 'Rocket Ship Crafts',
                                description:
                                    'Using cardboard tubes and foil to build mini rockets.',
                                rightIcon: Icons.visibility,
                                tags: ['Art', 'Motor Skills'],
                                attachments: true,
                                isDarkMode: isDarkMode,
                                surfaceColor: surfaceColor,
                                textColor: textColor,
                                connectorColor: isDarkMode
                                    ? Colors.grey[600]!
                                    : Colors.grey[300]!,
                                borderSide: BorderSide(
                                  color: primary,
                                  width: 4,
                                ), // Left border accent
                              ),
                              const SizedBox(height: 24),
                              _buildTimelineItem(
                                time: '10:30',
                                ampm: 'AM',
                                title: 'Snack Time',
                                description: 'Apples & Crackers',
                                rightIcon: Icons.schedule,
                                isDashed: true,
                                isDarkMode: isDarkMode,
                                surfaceColor: isDarkMode
                                    ? Colors.grey[800]!.withValues(alpha: 0.6)
                                    : Colors.white.withValues(alpha: 0.6),
                                textColor: isDarkMode
                                    ? Colors.grey[300]!
                                    : Colors.grey[700]!,
                                connectorColor: isDarkMode
                                    ? Colors.grey[700]!
                                    : Colors.grey[200]!,
                              ),
                              const SizedBox(height: 24),
                              _buildEmptySlot('11:00', isDarkMode),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Floating Action Button
          Positioned(
            bottom: 100, // Adjusted to sit above bottom nav visual
            right: 16,
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: primary.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.add, color: darkText, size: 32),
            ),
          ),

          // Bottom Navigation Visual
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: surfaceColor,
                border: Border(
                  top: BorderSide(
                    color: isDarkMode ? Colors.grey[800]! : Colors.grey[200]!,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(Icons.home, 'Home', false, isDarkMode),
                  _buildNavItem(Icons.groups, 'Students', false, isDarkMode),
                  _buildNavItem(
                    Icons.calendar_month,
                    'Planning',
                    true,
                    isDarkMode,
                  ),
                  _buildNavItem(
                    Icons.chat_bubble,
                    'Messages',
                    false,
                    isDarkMode,
                    badgeCount: 2,
                  ),
                  _buildNavItem(
                    Icons.restaurant_menu,
                    'Menu',
                    false,
                    isDarkMode,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewChip(String label, bool isDarkMode) {
    final isSelected = label == selectedView;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedView = label),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? (isDarkMode ? Colors.grey[700] : Colors.white)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 2,
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected
                  ? (isDarkMode ? Colors.white : Colors.black)
                  : (isDarkMode ? Colors.grey[400] : Colors.grey[500]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateCard(
    String day,
    int date,
    bool isSelected,
    bool isDarkMode,
  ) {
    return Container(
      width: 60,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: isSelected
            ? primary
            : (isDarkMode ? Colors.grey[800] : Colors.white),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? primary : Colors.transparent,
          width: 2,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: primary.withValues(alpha: 0.2),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ]
            : [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4)],
      ),
      child: Column(
        children: [
          Text(
            day,
            style: GoogleFonts.lexend(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isSelected
                  ? const Color(0xFF0d1b12)
                  : (isDarkMode ? Colors.grey[400] : Colors.grey[500]),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            date.toString(),
            style: GoogleFonts.lexend(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isSelected
                  ? const Color(0xFF0d1b12)
                  : (isDarkMode ? Colors.white : Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required String time,
    required String ampm,
    required String title,
    required String description,
    IconData? statusIcon,
    Color? statusColor,
    IconData? rightIcon,
    List<String>? tags,
    bool attachments = false,
    bool isDashed = false,
    required bool isDarkMode,
    required Color surfaceColor,
    required Color textColor,
    required Color connectorColor,
    BorderSide? borderSide,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time,
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
              Text(
                ampm,
                style: GoogleFonts.lexend(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 20,
          height: 20,
          child: Center(
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: connectorColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isDarkMode ? Colors.black : Colors.white,
                  width: 3,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(16),
              border: isDashed
                  ? null // Dashed border usually requires custom painting or DottedBorder package
                  : Border(
                      left: borderSide ?? BorderSide.none,
                      top: BorderSide(
                        color: isDarkMode
                            ? Colors.grey[800]!
                            : Colors.grey[100]!,
                      ),
                      right: BorderSide(
                        color: isDarkMode
                            ? Colors.grey[800]!
                            : Colors.grey[100]!,
                      ),
                      bottom: BorderSide(
                        color: isDarkMode
                            ? Colors.grey[800]!
                            : Colors.grey[100]!,
                      ),
                    ),
              boxShadow: isDashed
                  ? null
                  : [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
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
                    Text(
                      title,
                      style: GoogleFonts.lexend(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    if (statusIcon != null)
                      Icon(statusIcon, color: statusColor, size: 20),
                    if (rightIcon != null)
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? Colors.grey[700]
                              : Colors.grey[100],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          rightIcon,
                          size: 16,
                          color: isDarkMode
                              ? Colors.grey[300]
                              : Colors.grey[500],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: GoogleFonts.lexend(
                    fontSize: 14,
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[500],
                  ),
                ),
                if (attachments) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildAttachmentIcon(Icons.image, isDarkMode),
                      const SizedBox(width: 8),
                      _buildAttachmentIcon(Icons.description, isDarkMode),
                    ],
                  ),
                ],
                if (tags != null) ...[
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: tags
                        .map((tag) => _buildTag(tag, isDarkMode))
                        .toList(),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptySlot(String time, bool isDarkMode) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time,
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 20,
          height: 20,
          child: Center(
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[700] : Colors.grey[300],
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
                style: BorderStyle
                    .none, // Can't easily do dashed border without package
              ),
              color: isDarkMode
                  ? Colors.grey[800]!.withValues(alpha: 0.3)
                  : Colors.grey[50], // Fallback visual
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_circle_outline,
                    color: Colors.grey[400],
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Add Activity',
                    style: GoogleFonts.lexend(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAttachmentIcon(IconData icon, bool isDarkMode) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[700] : Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: Colors.grey[400], size: 20),
    );
  }

  Widget _buildTag(String label, bool isDarkMode) {
    Color bg, text;
    if (label == 'Social') {
      bg = isDarkMode
          ? Colors.purple[900]!.withValues(alpha: 0.3)
          : Colors.purple[50]!;
      text = isDarkMode ? Colors.purple[300]! : Colors.purple[700]!;
    } else if (label == 'Music') {
      bg = isDarkMode ? Colors.blue[900]!.withValues(alpha: 0.3) : Colors.blue[50]!;
      text = isDarkMode ? Colors.blue[300]! : Colors.blue[700]!;
    } else if (label == 'Art') {
      bg = isDarkMode ? Colors.pink[900]!.withValues(alpha: 0.3) : Colors.pink[50]!;
      text = isDarkMode ? Colors.pink[300]! : Colors.pink[700]!;
    } else {
      bg = isDarkMode
          ? Colors.yellow[900]!.withValues(alpha: 0.3)
          : Colors.yellow[50]!;
      text = isDarkMode ? Colors.yellow[300]! : Colors.yellow[700]!;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: text.withValues(alpha: 0.1)),
      ),
      child: Text(
        label,
        style: GoogleFonts.lexend(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: text,
        ),
      ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    String label,
    bool isSelected,
    bool isDarkMode, {
    int? badgeCount,
  }) {
    final color = isSelected
        ? primary
        : (isDarkMode ? Colors.grey[500] : Colors.grey[400]);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(icon, color: color, size: 24),
            if (badgeCount != null)
              Positioned(
                right: -4,
                top: -4,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: Text(
                    badgeCount.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.lexend(
            fontSize: 10,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: color,
          ),
        ),
      ],
    );
  }
}

class _PlannerHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double maxHeight;
  final double minHeight;

  _PlannerHeaderDelegate({
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
  bool shouldRebuild(_PlannerHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
