import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:playschool/features/staff/academic/staff_attendance_page.dart';
import 'package:playschool/features/staff/care/staff_activity_page.dart';
import 'package:playschool/features/staff/care/staff_medicine_log_page.dart';
import 'package:playschool/features/staff/operations/staff_incident_report_page.dart';
import 'package:playschool/features/staff/academic/staff_lesson_planner_page.dart'; // Updated
import 'package:playschool/features/staff/care/staff_milestone_tracking_page.dart';
import 'package:playschool/features/staff/academic/staff_my_attendance_page.dart'; // Added

import 'package:playschool/features/staff/academic/staff_roster_page.dart';
import 'package:playschool/features/staff/communication/staff_messages_page.dart';

class StaffDashboardPage extends StatefulWidget {
  const StaffDashboardPage({super.key});

  @override
  State<StaffDashboardPage> createState() => _StaffDashboardPageState();
}

class _StaffDashboardPageState extends State<StaffDashboardPage> {
  static const Color primary = Color(0xFF2bee6c);
  static const Color backgroundLight = Color(0xFFf6f8f6);
  static const Color backgroundDark = Color(0xFF102216);
  static const Color surfaceLight = Color(0xFFffffff);
  static const Color surfaceDark = Color(0xFF1a2c20);

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode ? backgroundDark : backgroundLight;
    final surfaceColor = isDarkMode ? surfaceDark : surfaceLight;
    final textColor = isDarkMode ? Colors.white : Colors.grey[900]!;
    final subTextColor = isDarkMode ? Colors.grey[400]! : Colors.grey[500]!;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        bottom: false,
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            _buildHomeContent(
              isDarkMode,
              bgColor,
              surfaceColor,
              textColor,
              subTextColor,
            ),
            const StaffRosterPage(),
            const StaffMessagesPage(),
            const StaffLessonPlannerPage(), // Calendar Tab
            const StaffMyAttendancePage(), // Profile Tab
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: surfaceColor,
          border: Border(
            top: BorderSide(
              color: isDarkMode ? Colors.grey[800]! : Colors.grey[200]!,
            ),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem(Icons.home, 'Home', 0, isDarkMode),
            _buildNavItem(Icons.groups, 'Roster', 1, isDarkMode),
            _buildNavItem(
              Icons.chat_bubble_outline,
              'Messages',
              2,
              isDarkMode,
              badge: true,
            ),
            _buildNavItem(Icons.calendar_month, 'Calendar', 3, isDarkMode),
            _buildNavItem(Icons.person_outline, 'Profile', 4, isDarkMode),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeContent(
    bool isDarkMode,
    Color bgColor,
    Color surfaceColor,
    Color textColor,
    Color subTextColor,
  ) {
    return Column(
      children: [
        // Header Section
        Container(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          decoration: BoxDecoration(
            color: isDarkMode
                ? backgroundDark.withOpacity(0.95)
                : backgroundLight.withOpacity(0.95),
            border: Border(
              bottom: BorderSide(
                color: isDarkMode
                    ? Colors.grey[800]!.withOpacity(0.5)
                    : Colors.grey[200]!.withOpacity(0.5),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: primary, width: 2),
                          image: const DecorationImage(
                            image: NetworkImage(
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuDBl1O--z3eXZQnsoLNTFBQYZ-c_NcAQ2rvjSglRdJKv9fVY1i761_c6_vXUlcaInggtbmNXglkarMleeFEjNpRNuInXQtmDnE6kbhrkqRWdk5dOBOZFEUg-4NxYzr-kyn8LTJsbHyuuOY0bl1LYAq0C9VprsEeotP7h79TIJoUpjFkOnWXuGIT98TRUCmOuSodjWMU-CzyGQWAfr7S5rxSgZKNSjn7xs__rZimP2CK3qEjax0s2lZFJPV32fxJMvAl0j8fK2WvfaE',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: primary,
                            shape: BoxShape.circle,
                            border: Border.all(color: bgColor, width: 2),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good Morning, Sarah',
                        style: GoogleFonts.lexend(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const StaffMyAttendancePage(),
                            ),
                          );
                        },
                        child: Text(
                          'Checked In: 7:45 AM',
                          style: GoogleFonts.lexend(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: subTextColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: surfaceColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDarkMode ? Colors.grey[800]! : Colors.grey[100]!,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Icon(
                        Icons.notifications_outlined,
                        color: isDarkMode ? Colors.grey[200] : Colors.grey[700],
                        size: 24,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 10,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.red[500],
                          shape: BoxShape.circle,
                          border: Border.all(color: surfaceColor, width: 1.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Scrollable Content
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Alerts Section
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? Colors.orange[900]!.withOpacity(0.2)
                        : Colors.orange[50]!,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDarkMode
                          ? Colors.orange[800]!.withOpacity(0.3)
                          : Colors.orange[100]!,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.orange[800]!.withOpacity(0.4)
                                  : Colors.orange[100]!,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.mark_chat_unread_outlined,
                              color: isDarkMode
                                  ? Colors.orange[300]
                                  : Colors.orange[600],
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '2 Unread Messages',
                                style: GoogleFonts.lexend(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: isDarkMode
                                      ? Colors.grey[100]
                                      : Colors.grey[900],
                                ),
                              ),
                              Text(
                                "From Liam's Mom & Emma's Dad",
                                style: GoogleFonts.lexend(
                                  fontSize: 12,
                                  color: subTextColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Icon(Icons.chevron_right, color: subTextColor),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Attendance Summary
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Attendance Overview',
                      style: GoogleFonts.lexend(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    Text(
                      'Toddler Room B',
                      style: GoogleFonts.lexend(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildAttendanceCard(
                        label: 'Present',
                        value: '12',
                        total: '/15',
                        color: primary,
                        surfaceColor: surfaceColor,
                        textColor: textColor,
                        subTextColor: subTextColor,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildAttendanceCard(
                        label: 'Absent',
                        value: '3',
                        color: Colors.red[400]!,
                        surfaceColor: surfaceColor,
                        textColor: textColor,
                        subTextColor: subTextColor,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Quick Actions
                Text(
                  'Quick Actions',
                  style: GoogleFonts.lexend(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 12),
                GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.5,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildQuickAction(
                      title: 'Check-in',
                      subtitle: 'Scan or manual',
                      icon: Icons.qr_code_scanner,
                      bgBase: primary,
                      surfaceColor: surfaceColor,
                      textColor: textColor,
                      subTextColor: subTextColor,
                      isMain: true,
                      isDarkMode: isDarkMode,
                      onTap: () {
                        HapticFeedback.lightImpact();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StaffAttendancePage(),
                          ),
                        );
                      },
                    ),

                    _buildQuickAction(
                      title: 'Daily Log',
                      subtitle: 'Food, Nap, Play',
                      icon: Icons.edit_note,
                      bgBase: Colors.blue,
                      surfaceColor: surfaceColor,
                      textColor: textColor,
                      subTextColor: subTextColor,
                      isDarkMode: isDarkMode,
                      onTap: () {
                        HapticFeedback.lightImpact();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StaffActivityPage(),
                          ),
                        );
                      },
                    ),
                    _buildQuickAction(
                      title: 'Meds',
                      subtitle: 'Track Health',
                      icon: Icons.medication,
                      bgBase: Colors.red,
                      surfaceColor: surfaceColor,
                      textColor: textColor,
                      subTextColor: subTextColor,
                      isDarkMode: isDarkMode,
                      onTap: () {
                        HapticFeedback.lightImpact();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StaffMedicineLogPage(),
                          ),
                        );
                      },
                    ),
                    _buildQuickAction(
                      title: 'Incidents',
                      subtitle: 'Report Injury',
                      icon: Icons.warning_amber_rounded,
                      bgBase: Colors.orange,
                      surfaceColor: surfaceColor,
                      textColor: textColor,
                      subTextColor: subTextColor,
                      isDarkMode: isDarkMode,
                      onTap: () {
                        HapticFeedback.lightImpact();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const StaffIncidentReportPage(),
                          ),
                        );
                      },
                    ),
                    _buildQuickAction(
                      title: 'Planning',
                      subtitle: 'Curriculum',
                      icon: Icons.calendar_month,
                      bgBase: Colors.green,
                      surfaceColor: surfaceColor,
                      textColor: textColor,
                      subTextColor: subTextColor,
                      isDarkMode: isDarkMode,
                      onTap: () {
                        HapticFeedback.lightImpact();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const StaffLessonPlannerPage(),
                          ),
                        );
                      },
                    ),
                    _buildQuickAction(
                      title: 'Message',
                      subtitle: 'Direct chat',
                      icon: Icons.chat_bubble_outline,
                      bgBase: Colors.purple,
                      surfaceColor: surfaceColor,
                      textColor: textColor,
                      subTextColor: subTextColor,
                      isDarkMode: isDarkMode,
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Class Roster Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Class Roster',
                      style: GoogleFonts.lexend(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    Text(
                      'View All',
                      style: GoogleFonts.lexend(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDarkMode ? Colors.grey[800]! : Colors.grey[100]!,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: Stack(
                            children: [
                              for (int i = 0; i < 5; i++)
                                Positioned(
                                  left: i * 30.0,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const StaffMilestoneTrackingPage(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: surfaceColor,
                                          width: 2,
                                        ),
                                        color: Colors.grey[200],
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            [
                                              'https://lh3.googleusercontent.com/aida-public/AB6AXuCp5p7j7eB_6D7GGYU8le8bbIuZJPmxmpfA8ctbXR3zTjbCJofhRimpgK2H1TyPo9LtOpH_wMwdp2j6iJPV37buzo3Z-7jIkAzGpvYltl8QnpfnLuIwrOHsk_6gtDB9rsqD-TXdlUJ4SD0_YMv1SMmJWjSz8OMMnD9wUG5U8aU6dmxn5C9OSWDuSpzdUh4c1AwV_fdFCQ4KqRHJ51KKFpE0_7NAPmn50WPx7Rgj_a-q8Jcd-MCrc34375OB8uOMKfcoCeE2Kw6zjjw',
                                              'https://lh3.googleusercontent.com/aida-public/AB6AXuCBxAhGY3SDnMgt6mpKLQsqZHhRYWg-MGgPihkYD7Lbj_UOEsC_4wJ9zjz-6qjzJv7PDtBWg9VCYzGE-5eYyXl01GRReK_6yPldqAe7odmVguH3nR7DVYO7KIC2ojFIifZiD8R0XOKpy8vb3__QrbMlEffPhQ_fWV12l640XvJ_XowknIJpDDqb9qtM62CRSuldzrw_EKugH5Ex92yeAyGOJhCFHezAKxPBeQFoJV5HgCPmeAVAR7dqdwdtcKgARXUSjJ5OsqWHWVg',
                                              'https://lh3.googleusercontent.com/aida-public/AB6AXuCSoxrVKjN8z4U9Q7-tdYaJ-gOd8XVVS5_nGtHGNdkn5OCPwga_PcCPtwZrOKDfB8euYJENGjBfcCa5eC5k7lOfVH-Wdy0308demmldnACWXG66ojkZH9hkQCf3LhBq0dAF0xUTkg2PbeLlgsYSlpt1wpTEcwGshItnpWbeBBc2uNZsF36u4rZYedpDsSDW_YAIYpC12XLQGBxOI5odqUs5bsmsOlNaFnEEsXfWZs0GuACyEHxdWFqRZZ3e-h2o6wHlH17TVS5tx6g',
                                              'https://lh3.googleusercontent.com/aida-public/AB6AXuBdoySuUyijXT_CXbGw928B15naN6hOzqlrnnsYQn5th6Qn8UW6jSrh6KyDHcxnmAUPnXlO-popvLNdfa1uWC28rtsb-stH9QtC_Jn36Sk3aRQQ-SOtReuU8ZqjTET1q0buvUbui_Xa0bznVRh1Q2XCHgEMmBNn9H-gKQjmURoHQXktLM0tQHOMcoVuPpBoUFJ3W6Fxi2xwM1DNx102u6C1zY21igwDGwOWLIavWkzG56RtX8k_RV4Djga-wD8gMj2Bi9s5h3NeMvg',
                                              'https://lh3.googleusercontent.com/aida-public/AB6AXuC5k7LP2WTcy4vr7_BNiyHDfrwD_vI2YD7MyJxmEygnfcEPZJdszs3wjbb3b2MQaAF1TQJTE_J_cbVpBS4vmvCFATNpSAbY98jpULqrDQUCIkpnFsbwLP5PM_9dCU2sDkgLM6R5YsnVmvauEUz2x8QbO8TE6oaGsg-dwGMS-RBBKPA0nTVwaptk-elIHwvzV7mA4UpKLB8B26owrFx6o2UwN9mdM33ZebXKJbyToipEYZM1BvQPeupZIVEKynyTdI15ZBi22lDli5c',
                                            ][i],
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              Positioned(
                                left: 150,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: isDarkMode
                                        ? Colors.grey[800]
                                        : Colors.grey[100],
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: surfaceColor,
                                      width: 2,
                                    ),
                                  ),
                                  child: Text(
                                    '+7',
                                    style: GoogleFonts.lexend(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: subTextColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'All Safe',
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

                const SizedBox(height: 32),

                // Recent Activity
                Text(
                  'Recent Activity',
                  style: GoogleFonts.lexend(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 12),
                Column(
                  children: [
                    _buildActivityItem(
                      title: 'Lunch Logged',
                      subtitle: 'Whole grain pasta & veggies for 12 students',
                      time: '10m ago',
                      icon: Icons.restaurant,
                      color: Colors.blue,
                      surfaceColor: surfaceColor,
                      textColor: textColor,
                      subTextColor: subTextColor,
                      isDarkMode: isDarkMode,
                    ),
                    const SizedBox(height: 12),
                    _buildActivityItem(
                      title: 'Check-in: Liam',
                      subtitle: 'Dropped off by Mother',
                      time: '15m ago',
                      icon: Icons.check_circle_outline,
                      color: Colors.green,
                      surfaceColor: surfaceColor,
                      textColor: textColor,
                      subTextColor: subTextColor,
                      isDarkMode: isDarkMode,
                    ),
                    const SizedBox(height: 12),
                    _buildActivityItem(
                      title: 'Nap Time Started',
                      subtitle: 'Quiet time initiated for group',
                      time: '1h ago',
                      icon: Icons.bedtime_outlined,
                      color: Colors.purple,
                      surfaceColor: surfaceColor,
                      textColor: textColor,
                      subTextColor: subTextColor,
                      isDarkMode: isDarkMode,
                    ),
                  ],
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(
    IconData icon,
    String label,
    int index,
    bool isDarkMode, {
    bool badge = false,
  }) {
    final isSelected = _selectedIndex == index;
    final color = isSelected
        ? const Color(0xFF2bee6c)
        : (isDarkMode ? Colors.grey[600] : Colors.grey[400]);

    return InkWell(
      onTap: () {
        HapticFeedback.lightImpact();
        setState(() => _selectedIndex = index);
        // Implement actual navigation or tab switching here if needed
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Icon(icon, color: color, size: 24),
              if (badge)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isDarkMode
                            ? const Color(0xFF1a2c20)
                            : const Color(0xFFffffff),
                        width: 1.5,
                      ),
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
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceCard({
    required String label,
    required String value,
    required Color color,
    required Color surfaceColor,
    required Color textColor,
    required Color subTextColor,
    String? total,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 2),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Text(
                label.toUpperCase(),
                style: GoogleFonts.lexend(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: subTextColor,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: GoogleFonts.lexend(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              if (total != null)
                Text(
                  total,
                  style: GoogleFonts.lexend(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: subTextColor,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color bgBase,
    required Color surfaceColor,
    required Color textColor,
    required Color subTextColor,
    required bool isDarkMode,
    bool isMain = false,
    VoidCallback? onTap,
  }) {
    final bg = isDarkMode ? bgBase.withOpacity(0.2) : bgBase.withOpacity(0.1);
    final iconColor = isDarkMode ? bgBase.withOpacity(0.8) : bgBase;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 2),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.lexend(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.lexend(fontSize: 12, color: subTextColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem({
    required String title,
    required String subtitle,
    required String time,
    required IconData icon,
    required Color color,
    required Color surfaceColor,
    required Color textColor,
    required Color subTextColor,
    required bool isDarkMode,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? color.withOpacity(0.3)
                  : color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.lexend(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.lexend(fontSize: 12, color: subTextColor),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: GoogleFonts.lexend(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: subTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
