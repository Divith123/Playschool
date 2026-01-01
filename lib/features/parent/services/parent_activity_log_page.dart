import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ParentActivityLogPage extends StatefulWidget {
  const ParentActivityLogPage({super.key});

  @override
  State<ParentActivityLogPage> createState() => _ParentActivityLogPageState();
}

class _ParentActivityLogPageState extends State<ParentActivityLogPage> {
  // Color palette
  static const Color primary = Color(0xFF2BEE6C);
  static const Color backgroundLight = Color(0xFFF6F8F6);
  static const Color backgroundDark = Color(0xFF102216);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1A2E22);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode ? backgroundDark : backgroundLight;
    final surfaceColor = isDarkMode ? surfaceDark : surfaceLight;
    final textColor = isDarkMode ? Colors.white : Colors.grey[900];
    final secondaryText = isDarkMode ? Colors.grey[400] : Colors.grey[500];
    final borderColor = isDarkMode ? Colors.grey[800]! : Colors.grey[100]!;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              "Leo's Day",
              style: GoogleFonts.lexend(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            Text(
              "Oct 24, Today",
              style: GoogleFonts.lexend(
                fontSize: 12,
                color: secondaryText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: isDarkMode
            ? backgroundDark.withValues(alpha: 0.9)
            : backgroundLight.withValues(alpha: 0.9),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () =>
              Navigator.of(context).pop(), // Backup navigation if needed
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_month, color: textColor),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: _buildDateStrip(isDarkMode, primary, surfaceColor),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
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
                    Stack(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isDarkMode
                                  ? Colors.grey[700]!
                                  : Colors.white,
                              width: 2,
                            ),
                            image: const DecorationImage(
                              image: NetworkImage(
                                'https://lh3.googleusercontent.com/aida-public/AB6AXuBb5OVYR_YzN14xrn98dTIns0KurBT2oExul3y5RJu0_zRQjFrecXkltEST7fDvKHVyq3cBnBFPRzOJmoeIVc-4I9fG4cgWT5Wh9srdG6P-Nn2OvziktsU_LpOjAN-WcY_5LzUu3B6ojtq2kZl7TjsTUdR-YjLwTgDZ7C6-raARSrnCZLlc9Q4gRK43uy619aivPnLXFOntJ9PHAmX_AYLMlYiXioB3r7kN0PEIhy0BoEN2g_cQunbsnDia1CiDpm3mmrQKtbEc6cw',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: primary,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isDarkMode
                                    ? Colors.grey[700]!
                                    : Colors.white,
                                width: 2,
                              ),
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
                            'Leo Johnson',
                            style: GoogleFonts.lexend(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Wrap(
                            spacing: 8,
                            children: [
                              _buildStatusChip(
                                'Currently: Nap Time',
                                primary.withValues(alpha: 0.2),
                                isDarkMode
                                    ? Colors.green[300]!
                                    : Colors.green[800]!,
                              ),
                              _buildStatusChip(
                                'In: 8:00 AM',
                                isDarkMode
                                    ? Colors.grey[800]!
                                    : Colors.grey[100]!,
                                isDarkMode
                                    ? Colors.grey[400]!
                                    : Colors.grey[600]!,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: primary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: primary.withValues(alpha: 0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.chat_bubble_outline,
                        color: Color(0xFF102216),
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Filter Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildFilterChip(
                    Icons.check_circle,
                    'All',
                    true,
                    isDarkMode,
                    primary,
                  ),
                  const SizedBox(width: 8),
                  _buildFilterChip(
                    Icons.restaurant,
                    'Meals',
                    false,
                    isDarkMode,
                    primary,
                  ),
                  const SizedBox(width: 8),
                  _buildFilterChip(
                    Icons.bedtime,
                    'Nap',
                    false,
                    isDarkMode,
                    primary,
                  ),
                  const SizedBox(width: 8),
                  _buildFilterChip(
                    Icons.photo_camera,
                    'Photos',
                    false,
                    isDarkMode,
                    primary,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Timeline Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildTimelineItem(
                    icon: Icons.brush,
                    iconBg: isDarkMode
                        ? Colors.purple[900]!.withValues(alpha: 0.3)
                        : Colors.purple[100]!,
                    iconColor: isDarkMode
                        ? Colors.purple[300]!
                        : Colors.purple[600]!,
                    title: 'Creative Arts',
                    time: '1:00 PM',
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 160,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: const DecorationImage(
                              image: NetworkImage(
                                'https://lh3.googleusercontent.com/aida-public/AB6AXuD31awerUhkUIvHLytRlsZvettddUrZcEjcgQGvJihE2peI5DnKCz8ylEBHfHDSxzSNeqmWuBPKv3nmubGwF2YO1KCyHqL2mzUN1NdDloisTPu57UBhCYOuT7G_eWCZ8-3w3gu3yLJEdaJnIYtC32wD1M2IpkwWoyddxAL1APshRkw7TFaO4W7QqYwzagrAN4V6r0GftJMAIDPTehHvtcO7c8ewhsiQ0soTm9eenBuPCQtuTTRrjNwR15IwgGesP_cHDjrd364rkVc',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black.withValues(alpha: 0.6),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 12,
                                left: 16,
                                right: 16,
                                child: Text(
                                  'Finger Painting Fun!',
                                  style: GoogleFonts.lexend(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Leo loved mixing the blue and red paints today. He made a big mess but had so much fun!",
                          style: GoogleFonts.lexend(
                            fontSize: 14,
                            color: isDarkMode
                                ? Colors.grey[300]
                                : Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 12,
                              backgroundImage: NetworkImage(
                                'https://lh3.googleusercontent.com/aida-public/AB6AXuB0AwAejjgkArQm3w8Hha23cBKD5uegPiB_gO8y9P3VJG1Vhzfpe9K1jJrqwwnVwZkPyyApF13YV7RNySiVQOahsunn5-9OjwMftydPXJNfTKWbqGoizta4WKFZ-fWScM_vp85vkIj5FSKgnL-ysuN8PHIMcoehDIFAzrMC6lhLgFHx-i8EJQi2cTP2_AuZguPrHP2CDjBFOTxcSSDZvbr6XsYXAUqZCePmh9kFLr9yAeDWh7lzXeFX5PtcFvI2bbAkn2-KmS09U4o',
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Ms. Sarah',
                              style: GoogleFonts.lexend(
                                fontSize: 12,
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    isDarkMode: isDarkMode,
                    bgColor: surfaceColor,
                    borderColor: borderColor,
                  ),
                  _buildTimelineItem(
                    icon: Icons.bedtime,
                    iconBg: isDarkMode
                        ? Colors.blue[900]!.withValues(alpha: 0.3)
                        : Colors.blue[100]!,
                    iconColor: isDarkMode
                        ? Colors.blue[300]!
                        : Colors.blue[600]!,
                    title: 'Nap Time',
                    time: '11:30 AM',
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? Colors.blue[900]!.withValues(alpha: 0.2)
                                : Colors.blue[50],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '1h 30m',
                            style: GoogleFonts.lexend(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: isDarkMode
                                  ? Colors.blue[300]
                                  : Colors.blue[700],
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Fell asleep easily while listening to soft music. Woke up refreshed.',
                          style: GoogleFonts.lexend(
                            fontSize: 14,
                            color: isDarkMode
                                ? Colors.grey[300]
                                : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    isDarkMode: isDarkMode,
                    bgColor: surfaceColor,
                    borderColor: borderColor,
                  ),
                  _buildTimelineItem(
                    icon: Icons.restaurant,
                    iconBg: isDarkMode
                        ? Colors.orange[900]!.withValues(alpha: 0.3)
                        : Colors.orange[100]!,
                    iconColor: isDarkMode
                        ? Colors.orange[300]!
                        : Colors.orange[600]!,
                    title: 'Morning Snack',
                    time: '10:00 AM',
                    content: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? Colors.orange[900]!.withValues(alpha: 0.2)
                                : Colors.orange[50],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.check_circle_outline,
                            color: isDarkMode
                                ? Colors.orange[300]
                                : Colors.orange[500],
                          ), // Approximate 'nutrition' icon
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Apple slices & Milk',
                                style: GoogleFonts.lexend(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                'Ate all apple slices, drank half milk.',
                                style: GoogleFonts.lexend(
                                  fontSize: 12,
                                  color: secondaryText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    isDarkMode: isDarkMode,
                    bgColor: surfaceColor,
                    borderColor: borderColor,
                  ),
                  _buildTimelineItem(
                    icon: Icons.water_drop,
                    iconBg: isDarkMode
                        ? Colors.teal[900]!.withValues(alpha: 0.3)
                        : Colors.teal[100]!,
                    iconColor: isDarkMode
                        ? Colors.teal[300]!
                        : Colors.teal[600]!,
                    title: 'Diaper Change',
                    time: '9:15 AM',
                    content: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.teal,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Wet',
                          style: GoogleFonts.lexend(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: isDarkMode
                                ? Colors.grey[200]
                                : Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    isDarkMode: isDarkMode,
                    bgColor: surfaceColor,
                    borderColor: borderColor,
                  ),
                  _buildTimelineItem(
                    icon: Icons.sentiment_satisfied,
                    iconBg: isDarkMode
                        ? Colors.yellow[900]!.withValues(alpha: 0.3)
                        : Colors.yellow[100]!,
                    iconColor: isDarkMode
                        ? Colors.yellow[300]!
                        : Colors.yellow[600]!,
                    title: 'Morning Mood',
                    time: '8:30 AM',
                    content: Text(
                      'Arrived happy and energetic. Started playing with blocks immediately.',
                      style: GoogleFonts.lexend(
                        fontSize: 14,
                        color: isDarkMode ? Colors.grey[300] : Colors.grey[600],
                      ),
                    ),
                    isDarkMode: isDarkMode,
                    bgColor: surfaceColor,
                    borderColor: borderColor,
                  ),
                  _buildTimelineItem(
                    icon: Icons.login,
                    iconBg: primary,
                    iconColor: const Color(0xFF102216),
                    title: 'Check In',
                    time: '8:00 AM',
                    content: null,
                    isDarkMode: isDarkMode,
                    bgColor: surfaceColor,
                    borderColor: borderColor,
                    isLast: true,
                    hideCard: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateStrip(bool isDarkMode, Color primary, Color surfaceColor) {
    return Container(
      height: 70,
      padding: const EdgeInsets.only(bottom: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildDate('Mon', '21', false, isDarkMode, primary),
          const SizedBox(width: 12),
          _buildDate('Tue', '22', false, isDarkMode, primary),
          const SizedBox(width: 12),
          _buildDate('Wed', '23', false, isDarkMode, primary),
          const SizedBox(width: 12),
          _buildDate('Thu', '24', true, isDarkMode, primary),
          const SizedBox(width: 12),
          _buildDate('Fri', '25', false, isDarkMode, primary),
          const SizedBox(width: 12),
          _buildDate('Sat', '26', false, isDarkMode, primary),
        ],
      ),
    );
  }

  Widget _buildDate(
    String day,
    String date,
    bool isSelected,
    bool isDarkMode,
    Color primary,
  ) {
    // final color = isSelected
    //     ? primary
    //     : (isDarkMode ? Colors.grey[500] : Colors.grey[400]);
    final textColor = isSelected
        ? const Color(0xFF102216)
        : (isDarkMode ? Colors.grey[500] : Colors.grey[400]);

    return Opacity(
      opacity: isSelected ? 1.0 : 0.5,
      child: Column(
        children: [
          Text(
            day,
            style: GoogleFonts.lexend(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isDarkMode && !isSelected
                  ? Colors.grey[400]
                  : (isSelected ? primary : Colors.black),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isSelected ? primary : Colors.transparent,
              shape: BoxShape.circle,
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
            child: Center(
              child: Text(
                date,
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String label, Color bg, Color text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: GoogleFonts.lexend(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: text,
        ),
      ),
    );
  }

  Widget _buildFilterChip(
    IconData icon,
    String label,
    bool isSelected,
    bool isDarkMode,
    Color primary,
  ) {
    final bg = isSelected
        ? (isDarkMode ? Colors.white : const Color(0xFF111827))
        : (isDarkMode ? const Color(0xFF1A2E22) : Colors.white);
    final text = isSelected
        ? (isDarkMode ? Colors.black : Colors.white)
        : (isDarkMode ? Colors.grey[300] : Colors.grey[700]);
    final iconColor = isSelected
        ? (isDarkMode ? Colors.black : Colors.white)
        : Colors.grey[500];
    final border = isSelected
        ? Colors.transparent
        : (isDarkMode ? Colors.grey[700]! : Colors.grey[200]!);

    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: border),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: iconColor),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: text,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String time,
    Widget? content,
    required bool isDarkMode,
    required Color bgColor,
    required Color borderColor,
    bool isLast = false,
    bool hideCard = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline Column
          SizedBox(
            width: 48,
            child: Column(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  margin: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    color: iconBg,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isDarkMode
                          ? const Color(0xFF102216)
                          : const Color(0xFFF6F8F6),
                      width: 4,
                    ),
                  ),
                  child: Icon(icon, size: 18, color: iconColor),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                      margin: const EdgeInsets.symmetric(vertical: 0),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Content Column
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32, top: 4),
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
                          color: isDarkMode ? Colors.white : Colors.grey[900],
                        ),
                      ),
                      Text(
                        time,
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
                  if (!hideCard && content != null) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: borderColor),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: content,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
