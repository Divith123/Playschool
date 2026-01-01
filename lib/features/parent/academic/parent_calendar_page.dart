import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ParentCalendarPage extends StatefulWidget {
  const ParentCalendarPage({super.key});

  @override
  State<ParentCalendarPage> createState() => _ParentCalendarPageState();
}

class _ParentCalendarPageState extends State<ParentCalendarPage> {
  // Color palette
  static const Color primary = Color(0xFF2BEE6C);
  static const Color primaryDark = Color(0xFF22bd56);
  static const Color backgroundLight = Color(0xFFF6F8F6);
  static const Color backgroundDark = Color(0xFF102216);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1c2e22);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode ? backgroundDark : backgroundLight;
    final surfaceColor = isDarkMode ? surfaceDark : surfaceLight;
    final textColor = isDarkMode ? Colors.white : Colors.grey.shade900;
    final secondaryText = isDarkMode
        ? Colors.grey.shade400
        : Colors.grey.shade500;
    final borderColor = isDarkMode
        ? Colors.grey.shade800
        : Colors.grey.shade100;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          "School Calendar",
          style: GoogleFonts.lexend(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: isDarkMode
            ? backgroundDark.withValues(alpha: 0.95)
            : backgroundLight.withValues(alpha: 0.95),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.of(context).pop(), // Backup navigation
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: textColor),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: borderColor, height: 1.0),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              children: [
                // Calendar Picker Section
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: surfaceColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 1,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Month Selector
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.chevron_left,
                                color: secondaryText,
                              ),
                              onPressed: () {},
                            ),
                            Text(
                              "October 2023",
                              style: GoogleFonts.lexend(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.chevron_right,
                                color: secondaryText,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Days Grid
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final double itemWidth =
                                (constraints.maxWidth - (6 * 8)) /
                                7; // Gap of 8
                            return Column(
                              children: [
                                // Labels
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
                                      .map(
                                        (day) => SizedBox(
                                          width: itemWidth,
                                          child: Text(
                                            day,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.lexend(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: secondaryText,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                                const SizedBox(height: 8),
                                // Dates Grid
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    // Placeholders
                                    for (int i = 0; i < 3; i++)
                                      SizedBox(width: itemWidth, height: 40),
                                    // Days 1-4
                                    _buildDayItem(
                                      "1",
                                      false,
                                      false,
                                      null,
                                      itemWidth,
                                      textColor,
                                      isDarkMode,
                                    ),
                                    _buildDayItem(
                                      "2",
                                      false,
                                      false,
                                      Colors.blue[400]!,
                                      itemWidth,
                                      textColor,
                                      isDarkMode,
                                    ),
                                    _buildDayItem(
                                      "3",
                                      false,
                                      false,
                                      null,
                                      itemWidth,
                                      textColor,
                                      isDarkMode,
                                    ),
                                    _buildDayItem(
                                      "4",
                                      false,
                                      false,
                                      Colors.red[400]!,
                                      itemWidth,
                                      textColor,
                                      isDarkMode,
                                    ),
                                    // Selected Day 5
                                    _buildDayItem(
                                      "5",
                                      true,
                                      false,
                                      null,
                                      itemWidth,
                                      textColor,
                                      isDarkMode,
                                    ),
                                    // Days 6-14...
                                    for (int i = 6; i <= 14; i++)
                                      _buildDayItem(
                                        i.toString(),
                                        false,
                                        false,
                                        i == 9
                                            ? primary
                                            : (i == 13
                                                  ? Colors.orange[400]!
                                                  : null),
                                        itemWidth,
                                        textColor,
                                        isDarkMode,
                                      ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 8),
                        // Handle
                        Container(
                          width: 32,
                          height: 4,
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? Colors.grey[700]
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Schedule Header
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Today's Schedule",
                        style: GoogleFonts.lexend(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      Text(
                        "3 Events",
                        style: GoogleFonts.lexend(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),

                // Timeline & Cards
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 31,
                        top: 16, // approx
                        bottom: 0,
                        child: Container(
                          width: 2,
                          color: isDarkMode
                              ? Colors.grey[800]
                              : Colors.grey[200],
                        ),
                      ),
                      Column(
                        children: [
                          _buildEventCard(
                            time: "09:00",
                            period: "AM",
                            dotColor: Colors.red,
                            title: "Tuition Due",
                            tag: "Deadline",
                            tagColor: Colors.red,
                            icon: Icons.warning,
                            iconColor: Colors.red,
                            subtitle: "Payment required",
                            avatarContent: "L",
                            avatarColor: Colors.blue,
                            bottomText: "Leo",
                            isDarkMode: isDarkMode,
                            surfaceColor: surfaceColor,
                            borderColor: borderColor,
                            textColor: textColor,
                          ),
                          const SizedBox(height: 24),
                          _buildEventCard(
                            time: "10:30",
                            period: "AM",
                            dotColor: primary,
                            title: "Music Class: Rhythm Basics",
                            tag: "Activity",
                            tagColor: Colors.green,
                            icon: Icons.music_note,
                            iconColor: primaryDark,
                            subtitle: "Room 3 • Miss Mia",
                            avatars: ["M", "L"], // Mia, Leo
                            bottomText: "Mia, Leo",
                            isDarkMode: isDarkMode,
                            surfaceColor: surfaceColor,
                            borderColor: borderColor,
                            textColor: textColor,
                          ),
                          const SizedBox(height: 24),
                          _buildEventCard(
                            time: "02:00",
                            period: "PM",
                            dotColor: Colors.blue,
                            title: "Parent-Teacher Meeting",
                            tag: "Meeting",
                            tagColor: Colors.blue,
                            icon: Icons.groups,
                            iconColor: Colors.blue,
                            subtitle: "Main Office",
                            iconContent: Icons.person,
                            bottomText: "Parents Only",
                            isDarkMode: isDarkMode,
                            surfaceColor: surfaceColor,
                            borderColor: borderColor,
                            textColor: textColor,
                          ),
                          const SizedBox(height: 24),
                          // Empty State
                          Row(
                            children: [
                              SizedBox(
                                width: 64,
                                child: Column(
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: isDarkMode
                                            ? Colors.grey[700]
                                            : Colors.grey[300],
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "No more events for today",
                                  style: GoogleFonts.lexend(
                                    fontSize: 14,
                                    fontStyle: FontStyle.italic,
                                    color: secondaryText,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // FAB
          Positioned(
            bottom: 24,
            right: 16,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.sync, color: Colors.black),
                    const SizedBox(width: 12),
                    Text(
                      "Sync to Phone",
                      style: GoogleFonts.lexend(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayItem(
    String day,
    bool isSelected,
    bool hasDot,
    Color? dotColor,
    double width,
    Color textColor,
    bool isDarkMode,
  ) {
    if (isSelected) {
      return Container(
        width: width,
        height: 40,
        decoration: BoxDecoration(
          color: primary,
          borderRadius: BorderRadius.circular(20), // stadium
          boxShadow: [
            BoxShadow(
              color: primary.withValues(alpha: 0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              day,
              style: GoogleFonts.lexend(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF102216),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.4),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 2),
                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.4),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
    return SizedBox(
      width: width,
      height: 40,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day,
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
            ),
          ),
          if (dotColor != null)
            Container(
              width: 4,
              height: 4,
              margin: const EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEventCard({
    required String time,
    required String period,
    required Color dotColor,
    required String title,
    required String tag,
    required MaterialColor tagColor,
    required IconData icon,
    required Color iconColor,
    required String subtitle,
    String? avatarContent, // Single letter
    Color? avatarColor,
    IconData? iconContent,
    List<String>? avatars, // Multi letters
    required String bottomText,
    required bool isDarkMode,
    required Color surfaceColor,
    required Color borderColor,
    required Color textColor,
  }) {
    Color tagBg = isDarkMode ? tagColor[900]!.withValues(alpha: 0.3) : tagColor[50]!;
    Color tagText = isDarkMode ? tagColor[100]! : tagColor[700]!;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Time Column
        SizedBox(
          width: 64,
          child: Column(
            children: [
              Text(
                time,
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              Text(
                period,
                style: GoogleFonts.lexend(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[500],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: isDarkMode ? backgroundDark : backgroundLight,
                  shape: BoxShape.circle,
                  border: Border.all(color: dotColor, width: 2),
                ),
              ),
            ],
          ),
        ),
        // Card
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(color: dotColor, width: 4),
                    top: BorderSide(color: borderColor),
                    right: BorderSide(color: borderColor),
                    bottom: BorderSide(color: borderColor),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: GoogleFonts.lexend(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: tagBg,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            tag.toUpperCase(),
                            style: GoogleFonts.lexend(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: tagText,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(icon, size: 16, color: iconColor),
                        const SizedBox(width: 4),
                        Text(
                          subtitle,
                          style: GoogleFonts.lexend(
                            fontSize: 14,
                            color: isDarkMode
                                ? Colors.grey[400]
                                : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        if (avatarContent != null && avatarColor != null)
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: avatarColor.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              avatarContent,
                              style: GoogleFonts.lexend(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: avatarColor,
                              ),
                            ),
                          )
                        else if (iconContent != null)
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              iconContent,
                              size: 14,
                              color: Colors.grey[500],
                            ),
                          )
                        else if (avatars != null)
                          SizedBox(
                            width: 40,
                            height: 24,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    padding: const EdgeInsets.all(1),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.purple[100],
                                        shape: BoxShape.circle,
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "M",
                                        style: GoogleFonts.lexend(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.purple[700],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 16,
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    padding: const EdgeInsets.all(1),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.blue[100],
                                        shape: BoxShape.circle,
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "L",
                                        style: GoogleFonts.lexend(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue[700],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(width: 8),
                        Text(
                          bottomText,
                          style: GoogleFonts.lexend(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
