import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/features/parent/academic/parent_calendar_page.dart';
import 'package:playschool/features/parent/communication/parent_chat_page.dart';
import 'package:playschool/features/parent/services/parent_gallery_page.dart';

import 'package:playschool/features/parent/communication/parent_messages_page.dart';
import 'package:playschool/features/parent/transport/parent_transport_tracking_page.dart';
import 'package:playschool/features/parent/dashboard/parent_profile_page.dart'; // Added
import 'package:playschool/features/parent/finance/parent_payment_history_page.dart'; // Added
import 'package:playschool/features/parent/academic/parent_homework_view_page.dart';
import 'package:playschool/features/parent/academic/parent_report_card_view_page.dart';
import 'package:playschool/features/parent/finance/parent_fee_structure_page.dart';
import 'package:playschool/features/parent/academic/parent_school_handbook_page.dart';
import 'package:playschool/features/parent/services/parent_event_registration_page.dart';
import 'package:playschool/features/parent/services/parent_gate_pass_page.dart';
import 'package:playschool/features/parent/transport/parent_transport_stop_change.dart';
import 'package:playschool/features/parent/communication/parent_transport_feedback_page.dart';
import 'package:playschool/features/parent/health/parent_sleep_analytics_page.dart';
import 'package:playschool/features/parent/health/parent_emergency_contacts_red_page.dart';
import 'package:playschool/features/parent/engagement/parent_referral_program_page.dart';
import 'dart:ui' as ui;

class ParentDashboardPage extends StatefulWidget {
  const ParentDashboardPage({super.key});

  @override
  State<ParentDashboardPage> createState() => _ParentDashboardPageState();
}

class _ParentDashboardPageState extends State<ParentDashboardPage> {
  // Color palette
  static const Color primary = Color(0xFF2BEE6C);
  static const Color backgroundLight = Color(0xFFF6F8F6);
  static const Color backgroundDark = Color(0xFF102216);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1A2E22);

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Screens for each tab
    final List<Widget> screens = [
      _buildDashboardContent(isDarkMode), // Home
      const ParentCalendarPage(), // Calendar (Index 1)
      const Center(
        child: Text('Add'),
      ), // Placeholder for Middle button (handled separately)
      const ParentMessagesPage(), // Messages Page (Index 3)
      const ParentProfilePage(), // Profile
    ];

    return Scaffold(
      backgroundColor: isDarkMode ? backgroundDark : backgroundLight,
      body: SafeArea(child: screens[_selectedIndex]),
      // Bottom Navigation
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDarkMode ? surfaceDark : surfaceLight,
          border: Border(
            top: BorderSide(
              color: isDarkMode ? Colors.grey[800]! : Colors.grey[100]!,
              width: 1,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        padding: const EdgeInsets.only(top: 8, bottom: 24, left: 24, right: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildBottomNavItem(
              index: 0,
              icon: Icons.home, // Changed to home icon
              label: 'Home',
              isDarkMode: isDarkMode,
            ),
            _buildBottomNavItem(
              index: 1,
              icon: Icons.calendar_month, // Calendar Icon
              label: 'Calendar',
              isDarkMode: isDarkMode,
            ),
            // Central Action Button
            Transform.translate(
              offset: const Offset(0, -20), // Lifted up
              child: GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  // Handle FAB tap (e.g., show add menu)
                },
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: primary.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 28,
                    color: Color(0xFF14532d), // green-900
                    weight: 700,
                  ),
                ),
              ),
            ),
            _buildBottomNavItem(
              index: 3, // Skip 2 (FAB)
              icon: Icons.chat_bubble_outline,
              label: 'Msg', // Changed label
              isDarkMode: isDarkMode,
            ),
            _buildBottomNavItem(
              index: 4,
              icon: Icons.person_outline,
              label: 'Profile',
              isDarkMode: isDarkMode,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavItem({
    required int index,
    required IconData icon,
    required String label,
    required bool isDarkMode,
  }) {
    final isActive = _selectedIndex == index;
    return InkWell(
      onTap: () {
        HapticFeedback.lightImpact();
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 24,
            color: isActive
                ? primary
                : (isDarkMode ? Colors.grey[500] : const Color(0xFF637588)),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.notoSans(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: isActive
                  ? primary
                  : (isDarkMode ? Colors.grey[500] : const Color(0xFF637588)),
            ),
          ),
        ],
      ),
    );
  }

  // Moved original dashboard content here
  Widget _buildDashboardContent(bool isDarkMode) {
    return Column(
      children: [
        // Top App Bar
        Container(
          decoration: BoxDecoration(
            color: (isDarkMode ? backgroundDark : backgroundLight).withOpacity(
              0.95,
            ),
            border: Border(
              bottom: BorderSide(
                color: isDarkMode ? Colors.grey[800]! : Colors.grey[100]!,
                width: 1,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              // Menu button
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isDarkMode ? surfaceDark : Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.menu,
                  color: isDarkMode ? Colors.grey[200] : Colors.grey[800],
                  size: 20,
                ),
              ),
              // Title
              Expanded(
                child: Text(
                  'Dashboard',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lexend(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.grey[900],
                    height: 1.2,
                  ),
                ),
              ),
              // Notifications button
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isDarkMode ? surfaceDark : Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Icon(
                        Icons
                            .notifications_outlined, // Changed to outlined to match material symbols better
                        color: isDarkMode ? Colors.grey[200] : Colors.grey[800],
                        size: 20,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.red[500],
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isDarkMode ? surfaceDark : Colors.white,
                            width: 1.5,
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

        // Main Content
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              bottom: 24,
            ), // Added some padding for scroll
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Header
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDarkMode ? surfaceDark : surfaceLight,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                      border: Border.all(
                        color: isDarkMode
                            ? Colors.grey[800]!
                            : Colors.grey[100]!,
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.all(20), // p-5 = 20px
                    child: Row(
                      children: [
                        // Profile Image
                        Stack(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                // ring-4 ring-primary/20
                                border: Border.all(
                                  color: primary.withOpacity(0.2),
                                  width: 4,
                                ),
                                image: const DecorationImage(
                                  image: NetworkImage(
                                    'https://lh3.googleusercontent.com/aida-public/AB6AXuAJufh0mrItXNm9ESF2g4RZWrRNkzks20AxzLM7auYvgKY_sz0Y2XtzOX1tCJPpVrquLbqGdm5AdQYLZ8glNB7fyRkyIizIOeY_DU87wOWmpnEsDdrTqnMWRQuS-X3ezwX4XzwgugHGlA7PooLFl67pnvidoT0jepGcHQWOdObwomnlymjnBkLlq2wyix0MhJy072iysHqbNhyEIFJ2cxM1vFnWDFmeCp2wLKsPR2MwJlkPbWjMzcoC34MHWgxy6OEAV3QYj7hlByw',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: primary,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isDarkMode
                                        ? surfaceDark
                                        : Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.check,
                                  size: 16,
                                  color: Color(0xFF14532d), // text-green-900
                                  weight: 700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        // Profile Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Good Morning, Sarah!',
                                style: _displayFont(
                                  // Using display font as per html "font-display"
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: isDarkMode
                                      ? Colors.grey[400]
                                      : Colors.grey[500],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Leo',
                                style: _displayFont(
                                  fontSize: 20, // xl
                                  fontWeight: FontWeight.bold,
                                  color: isDarkMode
                                      ? Colors.white
                                      : Colors.grey[900],
                                  height: 1.25,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isDarkMode
                                          ? Colors.green[900]!.withOpacity(0.3)
                                          : Colors.green[50],
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: Colors.green[600]!.withOpacity(
                                          0.2,
                                        ), // ring-1 ring-inset
                                      ),
                                    ),
                                    child: Text(
                                      'In Art Class 🎨',
                                      style: _displayFont(
                                        fontSize: 12, // xs
                                        fontWeight: FontWeight.w500,
                                        color: isDarkMode
                                            ? Colors.green[300]
                                            : Colors.green[700],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Checked in 8:00 AM',
                                    style: _displayFont(
                                      fontSize: 12,
                                      color: isDarkMode
                                          ? Colors.grey[500]
                                          : Colors.grey[400],
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
                ),

                // Quick Actions Grid
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildQuickAction(
                          icon: Icons.chat_bubble_outline,
                          label: 'Messages',
                          color: Colors.blue,
                          isDarkMode: isDarkMode,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ParentChatPage(),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildQuickAction(
                          icon: Icons.photo_library_outlined,
                          label: 'Gallery',
                          color: Colors.purple,
                          isDarkMode: isDarkMode,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ParentGalleryPage(),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildQuickAction(
                          icon: Icons.payments_outlined,
                          label: 'Pay Fees',
                          color: Colors.orange,
                          isDarkMode: isDarkMode,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ParentPaymentHistoryPage(),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildQuickAction(
                          icon: Icons.directions_bus_outlined,
                          label: 'Tracking',
                          color: Colors.green, // Matching primary
                          isDarkMode: isDarkMode,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ParentTransportTrackingPage(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // Academics & Services Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Academics & Services",
                            style: GoogleFonts.lexend(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode
                                  ? Colors.white
                                  : Colors.grey[900],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildQuickAction(
                              icon: Icons.assignment_outlined,
                              label: 'Homework',
                              color: Colors.blue,
                              isDarkMode: isDarkMode,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const ParentHomeworkViewPage(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            _buildQuickAction(
                              icon: Icons.assessment_outlined,
                              label: 'Reports',
                              color: Colors.deepPurple,
                              isDarkMode: isDarkMode,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const ParentReportCardViewPage(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            _buildQuickAction(
                              icon: Icons.menu_book_outlined,
                              label: 'Handbook',
                              color: Colors.brown,
                              isDarkMode: isDarkMode,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const ParentSchoolHandbookPage(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            _buildQuickAction(
                              icon: Icons.event_available,
                              label: 'Events',
                              color: Colors.pink,
                              isDarkMode: isDarkMode,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const ParentEventRegistrationPage(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            _buildQuickAction(
                              icon: Icons.receipt_long,
                              label: 'Fees',
                              color: Colors.green,
                              isDarkMode: isDarkMode,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const ParentFeeStructurePage(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            _buildQuickAction(
                              icon: Icons.directions_bus_filled_outlined,
                              label: 'Stop Chg', // Shortened
                              color: Colors.orange,
                              isDarkMode: isDarkMode,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const ParentTransportStopChangePage(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildQuickAction(
                              icon: Icons.outbond_outlined,
                              label: 'Gate Pass',
                              color: Colors.teal,
                              isDarkMode: isDarkMode,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ParentGatePassPage(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            _buildQuickAction(
                              icon: Icons.feedback_outlined,
                              label: 'Feedback',
                              color: Colors.cyan,
                              isDarkMode: isDarkMode,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const ParentTransportFeedbackPage(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            _buildQuickAction(
                              icon: Icons.bedtime,
                              label: 'Sleep',
                              color: Colors.indigo,
                              isDarkMode: isDarkMode,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const ParentSleepAnalyticsPage(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            _buildQuickAction(
                              icon: Icons.emergency_share,
                              label: 'Emergency',
                              color: Colors.red,
                              isDarkMode: isDarkMode,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const ParentEmergencyContactsRedPage(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            _buildQuickAction(
                              icon: Icons.card_giftcard,
                              label: 'Referral',
                              color: Colors.amber,
                              isDarkMode: isDarkMode,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const ParentReferralProgramPage(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Today's Highlights
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Today's Highlights",
                        style: GoogleFonts.lexend(
                          fontSize: 18, // lg
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.grey[900],
                        ),
                      ),
                      Text(
                        'View All',
                        style: _displayFont(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: primary,
                          decoration: TextDecoration
                              .none, // hover:underline simulated elsewhere
                        ),
                      ),
                    ],
                  ),
                ),

                // Highlight Cards
                SizedBox(
                  height: 280, // Height to accommodate the card + text content
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    clipBehavior: Clip.none,
                    children: [
                      _buildHighlightCard(
                        title: 'Art Class Masterpiece',
                        time: '10:30 AM',
                        description:
                            'Leo made a wonderful painting today using primary colors!',
                        imageUrl:
                            'https://lh3.googleusercontent.com/aida-public/AB6AXuDORIJjsLGC8G-DqVmGdW3mPMBx9wzuBFvaAeWZw6WU4clkrUsgFeHsqEFMfrTNd45ZvjsLMfTTjOfFeVNYgKXt2xpD_HefXrJ8vdrWUKXORXTMOUaGM2GCyozK5BcWZuppBnQd65TJooA64i0tYBOgikO5GtQgin_MpLo8Qr5SoOpq6-5M3qMpIJywrhRSMshEEZGG2Gnf6TiZ-qSmaRkz46b5gpdZ8akuXoxfocoBe2oz3nb2mQgvY_okK_5JYYBKA-aORENG7vA',
                        mediaType: '3 photos',
                        icon: Icons.image_outlined,
                        isDarkMode: isDarkMode,
                      ),
                      const SizedBox(width: 16),
                      _buildHighlightCard(
                        title: 'Lunch Time Fun',
                        time: '12:00 PM',
                        description: 'Pasta was on the menu and it was a hit.',
                        imageUrl:
                            'https://lh3.googleusercontent.com/aida-public/AB6AXuDV_YWphl3OQ4drqBxd3_YSIWy7Cx1hAW1add7dfDg01djgfDJiqvZvG09VbZB5qgvpJJVPR-hSdLgfz9pTZj-gl9e57M4NyozKdJY5-dMti67Y7dRqy7tEpffRAdhCHAbmo7YuxpnbMCxikmehygZ2FZ_pNd7IdkcMbnGGbStCutJYwt4DSasiKWigd65yoIOXfo3OoIfW33oVz8Lt3xZ2j1yifjnsQJc7c7T-PROXJyhKRUAvDprus2JMdC5vkne6V-e0tsYJQsg',
                        mediaType: 'Video',
                        icon: Icons.videocam_outlined,
                        isDarkMode: isDarkMode,
                      ),
                    ],
                  ),
                ),

                // Daily Timeline
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Daily Timeline',
                    style: GoogleFonts.lexend(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.grey[900],
                    ),
                  ),
                ),
                const SizedBox(height: 16), // mb-4 equiv
                // Timeline Items Container
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 16,
                  ), // Adjusted for timeline line
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: isDarkMode
                              ? Colors.grey[700]!
                              : Colors.grey[200]!,
                          width: 2,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.only(left: 20), // ml-2
                    child: Column(
                      children: [
                        _buildTimelineItem(
                          icon: Icons.bedtime_outlined,
                          title: 'Nap Started',
                          time: '1:00 PM',
                          description:
                              'Leo fell asleep quickly today. We\'ll update you when he wakes up.',
                          iconColor: const Color(0xFF14532d), // text-green-900
                          iconBg: primary,
                          borderColor: isDarkMode
                              ? backgroundDark
                              : backgroundLight,
                          isDarkMode: isDarkMode,
                        ),
                        const SizedBox(height: 32),
                        _buildTimelineItem(
                          icon: Icons.restaurant_menu,
                          title: 'Lunch Update',
                          time: '12:00 PM',
                          description: 'Appetite was great today!',
                          iconColor: isDarkMode
                              ? Colors.orange[300]!
                              : Colors.orange[600]!,
                          iconBg: isDarkMode
                              ? Colors.orange[900]!
                              : Colors.orange[100]!,
                          borderColor: isDarkMode
                              ? backgroundDark
                              : backgroundLight,
                          isDarkMode: isDarkMode,
                          tags: [
                            {'text': 'Ate all pasta', 'color': Colors.green},
                            {
                              'text': 'Left some carrots',
                              'color': Colors.orange,
                            },
                          ],
                        ),
                        const SizedBox(height: 32),
                        _buildTimelineItem(
                          icon: Icons.brush_outlined,
                          title: 'Art Class',
                          time: '10:30 AM',
                          description:
                              'Activity: Finger painting with primary colors.',
                          iconColor: isDarkMode
                              ? Colors.blue[300]!
                              : Colors.blue[600]!,
                          iconBg: isDarkMode
                              ? Colors.blue[900]!
                              : Colors.blue[100]!,
                          borderColor: isDarkMode
                              ? backgroundDark
                              : backgroundLight,
                          isDarkMode: isDarkMode,
                          opacity: 0.75,
                        ),
                      ],
                    ),
                  ),
                ),

                // Tomorrow's Reminder
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF6366F1), // indigo-500
                          Color(0xFF9333EA), // purple-600
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1), // shadow-lg
                          blurRadius: 10,
                          offset: const Offset(0, 10),
                          spreadRadius: -3,
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    padding: const EdgeInsets.all(16),
                    child: Stack(
                      children: [
                        Positioned(
                          top: -24,
                          right: -24,
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: BackdropFilter(
                                filter: ui.ImageFilter.blur(
                                  sigmaX: 20,
                                  sigmaY: 20,
                                ),
                                child: Container(color: Colors.transparent),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.checkroom,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Tomorrow: Pajama Day!',
                                    style: _displayFont(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 2), // Close spacing
                                  Text(
                                    'Don\'t forget to pack a spare outfit.',
                                    style: _displayFont(
                                      fontSize: 14,
                                      color: const Color(
                                        0xFFE0E7FF,
                                      ), // indigo-100
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32), // large bottom spacing before nav
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String label,
    required MaterialColor color,
    required bool isDarkMode,
    VoidCallback? onTap,
  }) {
    // Determine colors based on dark mode like standard tailwind classes
    // bg-blue-50 dark:bg-blue-900/20
    final bgColor = isDarkMode ? color[900]!.withOpacity(0.2) : color[50]!;
    // text-blue-600 dark:text-blue-400
    final textColor = isDarkMode ? color[400]! : color[600]!;

    return InkWell(
      onTap: () {
        HapticFeedback.lightImpact();
        if (onTap != null) onTap();
      },
      borderRadius: BorderRadius.circular(12),
      child: Column(
        children: [
          Container(
            width: 56, // size-14 = 3.5rem = 56px
            height: 56,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12), // rounded-xl
            ),
            child: Icon(icon, color: textColor, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: _displayFont(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightCard({
    required String title,
    required String time,
    required String description,
    required String imageUrl,
    required String mediaType,
    required IconData icon,
    required bool isDarkMode,
  }) {
    return Container(
      width: 256, // w-64
      decoration: BoxDecoration(
        color: isDarkMode ? surfaceDark : surfaceLight,
        borderRadius: BorderRadius.circular(16), // rounded-2xl
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
        border: Border.all(
          color: isDarkMode ? Colors.grey[800]! : Colors.grey[100]!,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(12), // p-3
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Container(
            width: double.infinity,
            height:
                192, // aspect-[4/3] of 256-24(padding) = 232 * 0.75 = ~174, let's go with visual approximation
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[100],
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.5),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Row(
                    children: [
                      Icon(icon, size: 16, color: Colors.white),
                      const SizedBox(width: 4),
                      Text(
                        mediaType,
                        style: _displayFont(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12), // gap-3 simulated
          // Content
          Expanded(
            child: SingleChildScrollView(
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
                          style: _displayFont(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.grey[900],
                          ),
                        ),
                      ),
                      Text(
                        time,
                        style: _displayFont(
                          fontSize: 12,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: _displayFont(
                      fontSize: 12,
                      color: isDarkMode ? Colors.grey[400] : Colors.grey[500],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required IconData icon,
    required String title,
    required String time,
    required String description,
    required Color iconColor,
    required Color iconBg,
    required Color borderColor,
    required bool isDarkMode,
    double opacity = 1.0,
    List<Map<String, dynamic>>? tags,
  }) {
    return Opacity(
      opacity: opacity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Icon Position
          Positioned(
            left:
                -42, // Adjusted: - left padding (20) - line (2) - half icon (20) = -42 approx
            top: 0,
            child: Container(
              width: 44, // roughly p-1.5 + icon size
              height: 44,
              padding: const EdgeInsets.all(6), // p-1.5 = 6px
              decoration: BoxDecoration(
                color:
                    borderColor, // border-background-light (masked by filling hole or stacking)
                shape: BoxShape.circle,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: iconBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size:
                      18, // text-[14px] in font awesome size usually smaller, but material 18 is good
                  color: iconColor,
                ),
              ),
            ),
          ),

          Container(
            decoration: BoxDecoration(
              color: isDarkMode ? surfaceDark : surfaceLight,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
              border: Border.all(
                color: isDarkMode ? Colors.grey[800]! : Colors.grey[100]!,
                width: 1,
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: _displayFont(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.grey[900],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.grey[800] : Colors.grey[100],
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        time,
                        style: _displayFont(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (tags != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: tags
                          .map(
                            (tag) => Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: isDarkMode
                                    ? (tag['color'] as MaterialColor)[900]!
                                          .withOpacity(0.2)
                                    : (tag['color'] as MaterialColor)[50],
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                tag['text'],
                                style: _displayFont(
                                  fontSize: 12,
                                  color: isDarkMode
                                      ? (tag['color'] as MaterialColor)[300]
                                      : (tag['color'] as MaterialColor)[700],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                Text(
                  description,
                  style: _displayFont(
                    fontSize: 14,
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

TextStyle _displayFont({
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
  double? height,
  TextDecoration? decoration,
}) {
  return GoogleFonts.lexend(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
    height: height,
    decoration: decoration,
  );
}
