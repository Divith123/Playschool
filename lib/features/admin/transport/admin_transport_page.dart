import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminTransportPage extends StatefulWidget {
  const AdminTransportPage({super.key});

  @override
  State<AdminTransportPage> createState() => _AdminTransportPageState();
}

class _AdminTransportPageState extends State<AdminTransportPage> {
  static const Color primary = Color(0xFF2bee6c);
  static const Color primaryDark = Color(0xFF23c559);
  static const Color backgroundLight = Color(0xFFf6f8f6);
  static const Color backgroundDark = Color(0xFF102216);
  static const Color surfaceLight = Color(0xFFffffff);
  static const Color surfaceDark = Color(0xFF1a3825);
  static const Color textMainLight = Color(0xFF0d1b12);
  static const Color textMainDark = Color(0xFFe0e7e3);
  static const Color textSubLight = Color(0xFF4c9a66);
  static const Color textSubDark = Color(0xFF8fcba3);

  int _selectedIndex = 0; // Bottom nav index

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode ? backgroundDark : backgroundLight;
    final surfaceColor = isDarkMode ? surfaceDark : surfaceLight;
    final textColor = isDarkMode ? textMainDark : textMainLight;
    final subTextColor = isDarkMode ? textSubDark : textSubLight;
    final borderColor = isDarkMode
        ? Colors.white.withValues(alpha: 0.05)
        : Colors.grey[100]!;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            Column(
              children: [
                // Top App Bar
                Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 8,
                    bottom: 8,
                    left: 16,
                    right: 16,
                  ),
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? backgroundDark.withValues(alpha: 0.95)
                        : backgroundLight.withValues(alpha: 0.95),
                    border: Border(bottom: BorderSide(color: borderColor)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(24),
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: textColor,
                            size: 24,
                          ),
                        ),
                      ),
                      Text(
                        'Transport Management',
                        style: GoogleFonts.lexend(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textColor,
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
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(Icons.add, color: backgroundDark, size: 24),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: Column(
                      children: [
                        // Stats
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              _buildStatCard(
                                value: '5',
                                label: 'Total Buses',
                                icon: Icons.directions_bus,
                                iconColor: Colors.blue[600]!,
                                iconBg: isDarkMode
                                    ? Colors.blue[900]!.withValues(alpha: 0.3)
                                    : Colors.blue[100]!,
                                surfaceColor: surfaceColor,
                                textColor: textColor,
                                subTextColor: subTextColor,
                                borderColor: borderColor,
                              ),
                              const SizedBox(width: 12),
                              _buildStatCard(
                                value: '120',
                                label: 'Students',
                                icon: Icons.school,
                                iconColor: Colors.orange[600]!,
                                iconBg: isDarkMode
                                    ? Colors.orange[900]!.withValues(alpha: 0.3)
                                    : Colors.orange[100]!,
                                surfaceColor: surfaceColor,
                                textColor: textColor,
                                subTextColor: subTextColor,
                                borderColor: borderColor,
                              ),
                              const SizedBox(width: 12),
                              _buildStatCard(
                                value: '98%',
                                label: 'On Time',
                                icon: Icons.schedule,
                                iconColor: Colors.green[700]!,
                                iconBg: primary.withValues(alpha: 0.2),
                                surfaceColor: surfaceColor,
                                textColor: textColor,
                                subTextColor: subTextColor,
                                borderColor: borderColor,
                              ),
                            ],
                          ),
                        ),

                        // Search Bar
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              color: surfaceColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: borderColor),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.01),
                                  blurRadius: 2,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 16,
                                    right: 8,
                                  ),
                                  child: Icon(
                                    Icons.search,
                                    color: subTextColor,
                                    size: 20,
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    style: GoogleFonts.lexend(color: textColor),
                                    decoration: InputDecoration(
                                      hintText: 'Search route, driver...',
                                      hintStyle: GoogleFonts.lexend(
                                        color: subTextColor.withValues(alpha: 0.7),
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Filter Chips
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Row(
                            children: [
                              _buildFilterChip(
                                label: 'Active Routes',
                                isActive: true,
                                isDarkMode: isDarkMode,
                                surfaceColor: surfaceColor,
                                textSubColor: subTextColor,
                              ),
                              const SizedBox(width: 12),
                              _buildFilterChip(
                                label: 'Pending',
                                isActive: false,
                                isDarkMode: isDarkMode,
                                surfaceColor: surfaceColor,
                                textSubColor: subTextColor,
                              ),
                              const SizedBox(width: 12),
                              _buildFilterChip(
                                label: 'Maintenance',
                                isActive: false,
                                isDarkMode: isDarkMode,
                                surfaceColor: surfaceColor,
                                textSubColor: subTextColor,
                              ),
                            ],
                          ),
                        ),

                        // Section Header
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'All Routes',
                                style: GoogleFonts.lexend(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  foregroundColor: isDarkMode
                                      ? primary
                                      : primaryDark,
                                  padding: EdgeInsets.zero,
                                ),
                                child: Text(
                                  'View Map',
                                  style: GoogleFonts.lexend(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Route Cards
                        _buildRouteCard(
                          isDarkMode: isDarkMode,
                          surfaceColor: surfaceColor,
                          textColor: textColor,
                          subTextColor: subTextColor,
                          borderColor: borderColor,
                          title: 'Route A - North Campus',
                          status: 'Active',
                          statusColor: Colors.green,
                          busInfo: 'Bus #42 • 2008 Ford Transit',
                          indicatorColor: primary,
                          driverName: 'Michael R.',
                          driverImage:
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuCdBkTOs-rHAYn7HXRLjy4zDWj6_9HgjzZ-Y5yh0bw2Ees15OvtxHQ8neSoiuGx3U_43-wQA4JYmF3QVjDv87hOHItWsySRfq31F-8YjG5H61PrgA9eDH1rHq46J7GkixIFupWrf5vKAMmW9SiGy1GAItwr8b2V7w3ipVmBtlVwBDyEhY0E4iSoUzh933Wp1s0f31-WyQLMWOTFp-iyGGmpSsl_mgrATEWlczg78CVW5KNInRRk3LI9cFZ7J5dWQRZghkq5nqRchfE',
                          capacityCurrent: 18,
                          capacityTotal: 20,
                          showTimeline: true,
                        ),

                        _buildRouteCard(
                          isDarkMode: isDarkMode,
                          surfaceColor: surfaceColor,
                          textColor: textColor,
                          subTextColor: subTextColor,
                          borderColor: borderColor,
                          title: 'Route B - West End',
                          status: 'Delayed',
                          statusColor: Colors.amber,
                          busInfo: 'Bus #15 • 2015 Mercedes Sprinter',
                          indicatorColor: Colors.amber,
                          driverName: 'Sarah J.',
                          driverImage:
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuDjXPaPNcLHkfk9OXGLSzFHq0uYA6DJfuWwLaF0I_zfWnPQmfuRridp8QfWUOc9ZWuu8al31SIkJlN29Jj-08cieUbEX6CfjxS83IWz4d4xAqCg3eIrMJ7_Y4AfaZ_9THxFauM9KD1gKb08Os3m56wGZRRvCUXVfy4rMbNCAsXmRZgvKciWxUv2-3PpS21Zm61iL3DRpqCNLQ2wC2Lzqrueu5dNVDqELurP9jJM_oLXg-e6sN1SPKDuYjcVksVxoAsg7elozhi58Po',
                          capacityCurrent: 0,
                          capacityTotal: 0,
                          showTimeline: false,
                          showAvatars: true,
                        ),

                        _buildRouteCard(
                          isDarkMode: isDarkMode,
                          surfaceColor: surfaceColor,
                          textColor: textColor,
                          subTextColor: subTextColor,
                          borderColor: borderColor,
                          title: 'Route C - Downtown',
                          status: 'Maintenance',
                          statusColor: Colors.red,
                          busInfo: 'Bus #09 • Needs Oil Change',
                          indicatorColor: Colors.red[400]!,
                          driverName: '',
                          driverImage: '',
                          capacityCurrent: 0,
                          capacityTotal: 0,
                          showTimeline: false,
                          isMaintenance: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // FAB
            Positioned(
              bottom: 90,
              right: 16,
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: primary.withValues(alpha: 0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(Icons.add, color: backgroundDark, size: 28),
              ),
            ),

            // Bottom Nav
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? backgroundDark.withValues(alpha: 0.95)
                      : surfaceLight.withValues(alpha: 0.95),
                  border: Border(top: BorderSide(color: borderColor)),
                ),
                child: SafeArea(
                  top: false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildNavItem(Icons.alt_route, 'Routes', 0, isDarkMode),
                      _buildNavItem(
                        Icons.directions_bus,
                        'Vehicles',
                        1,
                        isDarkMode,
                      ),
                      _buildNavItem(Icons.badge, 'Drivers', 2, isDarkMode),
                      _buildNavItem(Icons.settings, 'Settings', 3, isDarkMode),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String value,
    required String label,
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required Color surfaceColor,
    required Color textColor,
    required Color subTextColor,
    required Color borderColor,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.01),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.lexend(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            Text(
              label,
              style: GoogleFonts.lexend(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: subTextColor,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool isActive,
    required bool isDarkMode,
    required Color surfaceColor,
    required Color textSubColor,
  }) {
    // Colors from context
    final bgColor = isActive
        ? primary
        : (isDarkMode ? surfaceColor : Colors.white);
    final borderColor = isActive
        ? Colors.transparent
        : (isDarkMode ? Colors.white.withValues(alpha: 0.1) : Colors.grey[200]!);
    final textColor = isActive ? backgroundDark : textSubColor;
    final fontWeight = isActive ? FontWeight.bold : FontWeight.w500;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: primary.withValues(alpha: 0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Text(
        label,
        style: GoogleFonts.lexend(
          fontSize: 14,
          fontWeight: fontWeight,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildRouteCard({
    required bool isDarkMode,
    required Color surfaceColor,
    required Color textColor,
    required Color subTextColor,
    required Color borderColor,
    required String title,
    required String status,
    required Color statusColor,
    required String busInfo,
    required Color indicatorColor,
    required String driverName,
    required String driverImage,
    required int capacityCurrent,
    required int capacityTotal,
    bool showTimeline = false,
    bool showAvatars = false,
    bool isMaintenance = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: surfaceColor.withValues(alpha: isMaintenance ? 0.8 : 1.0),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.01),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: 4,
              child: Container(color: indicatorColor),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  title,
                                  style: GoogleFonts.lexend(
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
                                    color: isDarkMode
                                        ? statusColor.withValues(alpha: 0.2)
                                        : statusColor.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    status.toUpperCase(),
                                    style: GoogleFonts.lexend(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: statusColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              busInfo,
                              style: GoogleFonts.lexend(
                                fontSize: 13,
                                color: subTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.more_vert, color: subTextColor, size: 20),
                    ],
                  ),

                  if (!isMaintenance) ...[
                    const SizedBox(height: 16),
                    // Driver & Capacity
                    Row(
                      children: [
                        // Driver Info
                        Expanded(
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: isDarkMode
                                            ? Colors.grey[700]!
                                            : Colors.grey[200]!,
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(driverImage),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: -2,
                                    right: -2,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        color: primary,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: surfaceColor,
                                          width: 2,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.call,
                                        size: 10,
                                        color: backgroundDark,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    driverName,
                                    style: GoogleFonts.lexend(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: textColor,
                                    ),
                                  ),
                                  if (status == 'Active')
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          size: 12,
                                          color: subTextColor,
                                        ),
                                        const SizedBox(width: 2),
                                        Text(
                                          '4.8 Rating',
                                          style: GoogleFonts.lexend(
                                            fontSize: 12,
                                            color: subTextColor,
                                          ),
                                        ),
                                      ],
                                    )
                                  else
                                    Text(
                                      'On Route',
                                      style: GoogleFonts.lexend(
                                        fontSize: 12,
                                        color: subTextColor,
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        if (showAvatars)
                          SizedBox(
                            width: 80,
                            height: 32,
                            child: Stack(
                              children: [
                                _buildAvatar(
                                  0,
                                  Colors.blue,
                                  'JM',
                                  surfaceColor,
                                ),
                                _buildAvatar(
                                  20,
                                  Colors.pink,
                                  'AS',
                                  surfaceColor,
                                ),
                                _buildAvatar(
                                  40,
                                  Colors.grey,
                                  '+12',
                                  surfaceColor,
                                ),
                              ],
                            ),
                          )
                        else
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.grey[800]!.withValues(alpha: 0.5)
                                  : Colors.grey[50],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Capacity',
                                  style: GoogleFonts.lexend(
                                    fontSize: 10,
                                    color: subTextColor,
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: '$capacityCurrent',
                                    style: GoogleFonts.lexend(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: textColor,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: ' / $capacityTotal',
                                        style: GoogleFonts.lexend(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: subTextColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],

                  if (showTimeline) ...[
                    const SizedBox(height: 12),
                    Divider(height: 1, color: borderColor),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _buildTimelineDot(primary, true),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Maple Street Stop',
                              style: GoogleFonts.lexend(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          '07:45 AM',
                          style: GoogleFonts.lexend(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: subTextColor,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 3.5),
                      height: 12,
                      width: 1,
                      color:
                          borderColor, // Dotted line effect simulated with light solid for now
                    ),
                    Row(
                      children: [
                        _buildTimelineDot(Colors.grey[400]!, false),
                        const SizedBox(width: 12),
                        Text(
                          'Playschool Main Gate',
                          style: GoogleFonts.lexend(
                            fontSize: 13,
                            color: subTextColor,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '08:30 AM',
                          style: GoogleFonts.lexend(
                            fontSize: 12,
                            color: subTextColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(
    double left,
    MaterialColor color,
    String text,
    Color border,
  ) {
    return Positioned(
      left: left,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: color[100],
          shape: BoxShape.circle,
          border: Border.all(color: border, width: 2),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: GoogleFonts.lexend(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: color[800],
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineDot(Color color, bool isRing) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: isRing
            ? [
                BoxShadow(
                  color: color.withValues(alpha: 0.2),
                  blurRadius: 0,
                  spreadRadius: 4,
                ),
              ]
            : null,
      ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    String label,
    int index,
    bool isDarkMode,
  ) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected
                ? primary
                : (isDarkMode ? textSubDark : textSubLight),
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.lexend(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: isSelected
                  ? primary
                  : (isDarkMode ? textSubDark : textSubLight),
            ),
          ),
        ],
      ),
    );
  }
}
