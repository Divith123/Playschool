import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/features/common/app_settings_page.dart';

class StaffMyAttendancePage extends StatefulWidget {
  const StaffMyAttendancePage({super.key});

  @override
  State<StaffMyAttendancePage> createState() => _StaffMyAttendancePageState();
}

class _StaffMyAttendancePageState extends State<StaffMyAttendancePage> {
  static const Color primary = Color(0xFF2bee6c);
  static const Color backgroundLight = Color(0xFFf6f8f6);
  static const Color backgroundDark = Color(0xFF102216);
  static const Color surfaceLight = Color(0xFFffffff);
  static const Color surfaceDark = Color(0xFF1a2c20);
  static const Color textMainLight = Color(0xFF0d1b12);
  static const Color textMainDark = Color(0xFFe0e7e3);
  static const Color textSubLight = Color(0xFF4e6d97);

  bool _isCheckedIn = false;
  String? _checkInTime;

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
          'My Attendance',
          style: GoogleFonts.lexend(fontWeight: FontWeight.bold),
        ),
        backgroundColor: bgColor,
        foregroundColor: textColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: textColor),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppSettingsPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Clock In/Out Section
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  _isCheckedIn ? 'You are Clocked In' : 'You are Clocked Out',
                  style: GoogleFonts.lexend(
                    fontSize: 16,
                    color: subTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '08:45 AM',
                  style: GoogleFonts.lexend(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                Text(
                  'Oct 25, 2023',
                  style: GoogleFonts.lexend(fontSize: 14, color: subTextColor),
                ),
                const SizedBox(height: 32),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isCheckedIn = !_isCheckedIn;
                      _checkInTime = _isCheckedIn ? '08:45 AM' : null;
                    });
                  },
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isCheckedIn
                          ? Colors.red.withValues(alpha: 0.1)
                          : primary.withValues(alpha: 0.1),
                      border: Border.all(
                        color: _isCheckedIn ? Colors.red : primary,
                        width: 4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: (_isCheckedIn ? Colors.red : primary)
                              .withValues(alpha: 0.2),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _isCheckedIn ? Icons.exit_to_app : Icons.login,
                          size: 32,
                          color: _isCheckedIn ? Colors.red : primary,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _isCheckedIn ? 'Clock Out' : 'Clock In',
                          style: GoogleFonts.lexend(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _isCheckedIn ? Colors.red : primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (_isCheckedIn) ...[
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.history_toggle_off,
                        color: subTextColor,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Started at $_checkInTime',
                        style: GoogleFonts.lexend(
                          color: subTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                Text(
                  ' Recent Activity',
                  style: GoogleFonts.lexend(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 12),
                _buildHistoryItem(
                  'Today',
                  '08:45 AM',
                  'Active',
                  isDarkMode,
                  surfaceColor,
                  textColor,
                  subTextColor!,
                ),
                _buildHistoryItem(
                  'Yesterday',
                  '09:00 AM - 05:00 PM',
                  '8h 00m',
                  isDarkMode,
                  surfaceColor,
                  textColor,
                  subTextColor,
                ),
                _buildHistoryItem(
                  'Oct 23',
                  '08:55 AM - 05:05 PM',
                  '8h 10m',
                  isDarkMode,
                  surfaceColor,
                  textColor,
                  subTextColor,
                ),
                _buildHistoryItem(
                  'Oct 22',
                  '09:00 AM - 05:00 PM',
                  '8h 00m',
                  isDarkMode,
                  surfaceColor,
                  textColor,
                  subTextColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(
    String day,
    String time,
    String duration,
    bool isDarkMode,
    Color surfaceColor,
    Color textColor,
    Color subTextColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.white10 : Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.calendar_today,
                  size: 20,
                  color: subTextColor,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    day,
                    style: GoogleFonts.lexend(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: textColor,
                    ),
                  ),
                  Text(
                    time,
                    style: GoogleFonts.lexend(
                      fontSize: 12,
                      color: subTextColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: duration == 'Active'
                  ? primary.withValues(alpha: 0.1)
                  : (isDarkMode ? Colors.white10 : Colors.grey[100]),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              duration,
              style: GoogleFonts.lexend(
                fontWeight: FontWeight.bold,
                color: duration == 'Active' ? primary : subTextColor,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
