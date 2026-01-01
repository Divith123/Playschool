import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playschool/features/admin/students/admin_admissions_page.dart';
import 'package:playschool/features/admin/finance/admin_finance_page.dart';
import 'package:playschool/features/admin/staff/admin_staff_profile_page.dart';
import 'package:playschool/features/admin/operations/admin_broadcast_page.dart';
import 'package:playschool/features/admin/transport/admin_transport_page.dart';
import 'package:playschool/features/admin/dashboard/admin_lead_dashboard_page.dart';
import 'package:playschool/features/admin/staff/admin_staff_scheduler_page.dart';
import 'package:playschool/features/admin/staff/admin_payroll_page.dart';
import 'package:playschool/features/admin/operations/admin_inventory_page.dart';
import 'package:playschool/features/admin/operations/admin_event_manager_page.dart';
import 'package:playschool/features/admin/reception/admin_visitor_log_page.dart';
import 'package:playschool/features/admin/operations/admin_newsletter_editor_page.dart';
import 'package:playschool/features/admin/system/admin_settings_roles_page.dart';
import 'package:playschool/features/admin/system/admin_system_audit_logs_page.dart';

import 'package:google_fonts/google_fonts.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  // Color Palette
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

        // ...
        // (Skipping to relevant sections to avoid huge replacement, will do targeted replace)
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            _buildHomeContent(
              context,
              isDarkMode,
              surfaceColor,
              textColor,
              subTextColor,
            ),
            const AdminAdmissionsPage(),
            const AdminBroadcastPage(),
            const AdminFinancePage(),
            const AdminStaffProfilePage(),
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
            _buildNavItem(
              icon: Icons.dashboard_outlined,
              label: 'Home',
              isSelected: _selectedIndex == 0,
              onTap: () {
                HapticFeedback.lightImpact();
                setState(() => _selectedIndex = 0);
              },
              isDarkMode: isDarkMode,
            ),
            _buildNavItem(
              icon: Icons.people_outline,
              label: 'Admissions',
              isSelected: _selectedIndex == 1,
              onTap: () {
                HapticFeedback.lightImpact();
                setState(() => _selectedIndex = 1);
              },
              isDarkMode: isDarkMode,
            ),
            _buildNavItem(
              icon: Icons.campaign_outlined,
              label: 'Broadcast',
              isSelected: _selectedIndex == 2,
              onTap: () {
                HapticFeedback.lightImpact();
                setState(() => _selectedIndex = 2);
              },
              isDarkMode: isDarkMode,
            ),
            _buildNavItem(
              icon: Icons.attach_money,
              label: 'Finance',
              isSelected: _selectedIndex == 3,
              onTap: () {
                HapticFeedback.lightImpact();
                setState(() => _selectedIndex = 3);
              },
              isDarkMode: isDarkMode,
            ),
            _buildNavItem(
              icon: Icons.person_outline,
              label: 'Profile',
              isSelected: _selectedIndex == 4,
              onTap: () {
                HapticFeedback.lightImpact();
                setState(() => _selectedIndex = 4);
              },
              isDarkMode: isDarkMode,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeContent(
    BuildContext context,
    bool isDarkMode,
    Color surfaceColor,
    Color textColor,
    Color subTextColor,
  ) {
    return Column(
      children: [
        // Top App Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: primary, width: 2),
                      image: const DecorationImage(
                        image: NetworkImage(
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuBqc2e_b8GLEthiNoYX9WQCGRSm08O2Pbu7VrmdbSuWIv2pOkjYiqff5vMub3Qjar9B7yBYkUiIzIbi7CjDjhCgoygjVKhJ8XONsUBTy4Q_JeV_Mhl2cGscDBnjBzXZp9-dSezSUk6lz9LKOOoyjWyFGJBRftenqQMsWjUpthFMvYTpj3lf5fYz7W7jGOjK085Gazo2wObdR7Lkoo2COAY5Vx5yHEJ0kzSOEC6Ooq71pSEWB1fFtOK0c_5vd8S_OV9kyZFdJ-lxUII',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello, Admin',
                        style: GoogleFonts.lexend(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      Text(
                        'Sunshine Playschool',
                        style: GoogleFonts.lexend(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: subTextColor,
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
                // KPI Stats Grid
                SizedBox(
                  height: 140,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildKPICard(
                        title: 'Total Students',
                        value: '142',
                        icon: Icons.school_outlined,
                        iconColor: Colors.blue[600]!,
                        iconBg: isDarkMode
                            ? Colors.blue[900]!.withOpacity(0.3)
                            : Colors.blue[100]!,
                        trend: '+2%',
                        surfaceColor: surfaceColor,
                        textColor: textColor,
                        subTextColor: subTextColor,
                      ),
                      const SizedBox(width: 12),
                      _buildKPICard(
                        title: 'Total Staff',
                        value: '24',
                        icon: Icons.badge_outlined,
                        iconColor: Colors.purple[600]!,
                        iconBg: isDarkMode
                            ? Colors.purple[900]!.withOpacity(0.3)
                            : Colors.purple[100]!,
                        surfaceColor: surfaceColor,
                        textColor: textColor,
                        subTextColor: subTextColor,
                      ),
                      const SizedBox(width: 12),
                      _buildKPICard(
                        title: 'Pending Admissions',
                        value: '8',
                        icon: Icons.person_add_alt_1_outlined,
                        iconColor: Colors.orange[600]!,
                        iconBg: isDarkMode
                            ? Colors.orange[900]!.withOpacity(0.3)
                            : Colors.orange[100]!,
                        trend: '3 High',
                        surfaceColor: surfaceColor,
                        textColor: textColor,
                        subTextColor: subTextColor,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const AdminLeadDashboardPage(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 12),
                      _buildKPICard(
                        title: 'Fee Overdue',
                        value: '\$2.4k',
                        icon: Icons.attach_money,
                        iconColor: Colors.red[600]!,
                        iconBg: isDarkMode
                            ? Colors.red[900]!.withOpacity(0.3)
                            : Colors.red[100]!,
                        trend: '5 Acc',
                        surfaceColor: surfaceColor,
                        textColor: textColor,
                        subTextColor: subTextColor,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Quick Actions Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Quick Actions',
                      style: GoogleFonts.lexend(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    Text(
                      'Edit',
                      style: GoogleFonts.lexend(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: isDarkMode ? primary : Colors.green[700],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Quick Actions Grid
                GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.4,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildActionCard(
                      title: 'Manage Students',
                      icon: Icons.school,
                      image:
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuBrrVSxINESDiUltmNe6HzBc-NrKI7T0gpK7tExQON5ncyXEa8adlRhb36ttwNxFoXDED_LfIT2amXfY8XYsokX2ynMt3qEbqRZOo7BvbNY2_Z7U1a4d0G0JzP1G78V17zwgt6-adGuqk3mgFv0ReojGQkatvBby8ijE0bG2SGjDlIYRYIi4UsqPTUQdDP70GI6kdLhskabH5fqPoIUt1KHPJKYmT_oayvuqBWzlovv3U3KYJjDEcgGZ7yHMgPesO02sDTWpiLQPCg',
                      surfaceColor: surfaceColor,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdminAdmissionsPage(),
                          ),
                        );
                      },
                    ),
                    _buildActionCard(
                      title: 'Staff Directory',
                      icon: Icons.groups,
                      image:
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuDns3GWXpFYplBAleTn3okZ3AaMFot2iIzyxHqggrj93p9Cpl9vvvVTF4i1vXZ3ouLkozNX15LLTYlFlRoeoj_yNDLRMqYvEag3OHYPPFC-SIVepOuJros_o0pN-4EQEIb-2pC2a_MJ50PcvWzgHHaJ06EzjCSCrX1ymIlRgcC08ehvExVOYpPJ8WPeEkpDwwT2X-B4GfvWHJ_aSqLjDKAqBRlCDH1WYqpOMytwUh1M1Gc6sfz-wE2KQUKwnrLLKqmM-ic25Ykgxz8',
                      surfaceColor: surfaceColor,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdminStaffProfilePage(),
                          ),
                        );
                      },
                    ),
                    _buildActionCard(
                      title: 'Finance & Fees',
                      icon: Icons.payments,
                      image:
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuDsmGTrIiXsQZYy0gWVr8NmT75g79P_zcu9Dl5AMLCRiz9dH6Np-o2KUdAYYoNxEB9sdRGqgaESmZjAUSejxDVRP3nSHb-Ule6m0vRUEKExByUApSEUO0saMK3jJpJsGivM9z1cMgqqRQhbB-7wchFNRhqaHjfr3h5mwo7JZ_4jHFJKlCQoQxB-MTZKdrsuuHab9jAvIBNTE9eVwWMueWCEzaOSIChDWBmB8oJx1nK-CRu6QMypuc1gWs56xwbbjKlrgDKYVs3X8sA',
                      surfaceColor: surfaceColor,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdminFinancePage(),
                          ),
                        );
                      },
                    ),
                    _buildActionCard(
                      title: 'Transport',
                      icon: Icons.directions_bus,
                      image:
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuCv7z2sHhkpzvW1UXESpPRwNwBBZeSma1Qh2y-GprvkFId4d13LvKi4HDtBpwetJGnS65YPWQd34m53uvVrRGNbH-Q1ozVyN6uagiXW8NGq4jZjmStJpzbEa66Nytq4P9SY4a-HYtCpySqtbKTDvgMgaXttmJ1JIo95_g6m5AeYgw4WWy6B3LLaoKW1LzSYtjt1fNyg3ZliGIjGSrhMRq7FLGJTN6RkKoH_aVG64jVPRw6Org_unVJZvSdA1pEdJcV2Ca7P_hJYgRE',
                      surfaceColor: surfaceColor,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdminTransportPage(),
                          ),
                        );
                      },
                    ),
                    _buildActionCard(
                      title: 'Shift Scheduler',
                      icon: Icons.calendar_today,
                      image:
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuBHJUXGumrMlSxLNRNkaR5-OR4vKkSJRG_QqfS012BuC2GO-oEmkffMcLucGoxPAYQUZror0MzF-dpbX53rhTBvHJQMG12-RbUWsO_zegd-ID_ugftsC1KvSzddAkl2zu86tH5MiQdNZg999nr2XFvLQ8MW9q56xO6TYsb2bJap8H1CTKQYQFlyHvNzZoSxVBYgdcmBCAuYhnH4dp8NKXh0AZxCk0lQMpupApLp7WTIp9gLFffYSLaY8p0pj7UMPOGXFtZc-yVrPOU',
                      surfaceColor: surfaceColor,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const AdminStaffSchedulerPage(),
                          ),
                        );
                      },
                    ),
                    _buildActionCard(
                      title: 'Payroll',
                      icon: Icons.attach_money,
                      image:
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuDsmGTrIiXsQZYy0gWVr8NmT75g79P_zcu9Dl5AMLCRiz9dH6Np-o2KUdAYYoNxEB9sdRGqgaESmZjAUSejxDVRP3nSHb-Ule6m0vRUEKExByUApSEUO0saMK3jJpJsGivM9z1cMgqqRQhbB-7wchFNRhqaHjfr3h5mwo7JZ_4jHFJKlCQoQxB-MTZKdrsuuHab9jAvIBNTE9eVwWMueWCEzaOSIChDWBmB8oJx1nK-CRu6QMypuc1gWs56xwbbjKlrgDKYVs3X8sA',
                      surfaceColor: surfaceColor,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdminPayrollPage(),
                          ),
                        );
                      },
                    ),
                    _buildActionCard(
                      title: 'Inventory',
                      icon: Icons.inventory_2_outlined,
                      image:
                          'https://images.unsplash.com/photo-1556740738-b6a63e27c4df?auto=format&fit=crop&q=80&w=300',
                      surfaceColor: surfaceColor,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdminInventoryPage(),
                          ),
                        );
                      },
                    ),
                    _buildActionCard(
                      title: 'Events',
                      icon: Icons.event,
                      image:
                          'https://images.unsplash.com/photo-1511578314322-379afb476865?auto=format&fit=crop&q=80&w=300',
                      surfaceColor: surfaceColor,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdminEventManagerPage(),
                          ),
                        );
                      },
                    ),
                    _buildActionCard(
                      title: 'Visitors',
                      icon: Icons.person_pin_circle_outlined,
                      image:
                          'https://images.unsplash.com/photo-1556761175-5973dc0f32e7?auto=format&fit=crop&q=80&w=300',
                      surfaceColor: surfaceColor,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdminVisitorLogPage(),
                          ),
                        );
                      },
                    ),
                    _buildActionCard(
                      title: 'Newsletter',
                      icon: Icons.newspaper,
                      image:
                          'https://images.unsplash.com/photo-1586339949216-35c2747cc36d?auto=format&fit=crop&q=80&w=300',
                      surfaceColor: surfaceColor,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const AdminNewsletterEditorPage(),
                          ),
                        );
                      },
                    ),
                    _buildActionCard(
                      title: 'Roles & Perms',
                      icon: Icons.admin_panel_settings_outlined,
                      image:
                          'https://images.unsplash.com/photo-1551836022-d5d88e9218df?auto=format&fit=crop&q=80&w=300',
                      surfaceColor: surfaceColor,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const AdminSettingsRolesPage(),
                          ),
                        );
                      },
                    ),
                    _buildActionCard(
                      title: 'Audit Logs',
                      icon: Icons.history_edu,
                      image:
                          'https://images.unsplash.com/photo-1554224155-8d04cb21cd6c?auto=format&fit=crop&q=80&w=300',
                      surfaceColor: surfaceColor,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const AdminSystemAuditLogsPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Recent Alerts Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Alerts',
                      style: GoogleFonts.lexend(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    Text(
                      'View All',
                      style: GoogleFonts.lexend(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: subTextColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Alerts List
                Column(
                  children: [
                    _buildAlertCard(
                      title: 'Staff Absence',
                      message:
                          'Teacher Sarah marked absent today. Substitute required for Class 2A.',
                      time: '2m ago',
                      icon: Icons.person_off,
                      iconColor: Colors.red[600]!,
                      iconBg: isDarkMode
                          ? Colors.red[900]!.withOpacity(0.3)
                          : Colors.red[100]!,
                      surfaceColor: surfaceColor,
                      textColor: textColor,
                      subTextColor: subTextColor,
                    ),
                    const SizedBox(height: 12),
                    _buildAlertCard(
                      title: 'New Inquiry',
                      message:
                          'Mrs. Johnson sent a message regarding Toddler Group admission.',
                      time: '1h ago',
                      icon: Icons.mark_chat_unread,
                      iconColor: Colors.blue[600]!,
                      iconBg: isDarkMode
                          ? Colors.blue[900]!.withOpacity(0.3)
                          : Colors.blue[100]!,
                      surfaceColor: surfaceColor,
                      textColor: textColor,
                      subTextColor: subTextColor,
                    ),
                    const SizedBox(height: 12),
                    _buildAlertCard(
                      title: 'Maintenance',
                      message:
                          'Playground slide repair scheduled for tomorrow morning.',
                      time: '3h ago',
                      icon: Icons.construction,
                      iconColor: Colors.yellow[600]!,
                      iconBg: isDarkMode
                          ? Colors.yellow[900]!.withOpacity(0.3)
                          : Colors.yellow[100]!,
                      surfaceColor: surfaceColor,
                      textColor: textColor,
                      subTextColor: subTextColor,
                    ),
                  ],
                ),
                const SizedBox(height: 80), // Bottom padding
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildKPICard({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required Color surfaceColor,
    required Color textColor,
    required Color subTextColor,
    String? trend,
    bool hasPulse = false,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 1),
              blurRadius: 2,
            ),
          ],
          border: Border.all(color: Colors.grey.withOpacity(0.1)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(icon, color: iconColor, size: 20),
                ),
                if (trend != null)
                  Row(
                    children: [
                      Icon(
                        Icons.trending_up,
                        size: 14,
                        color: Colors.green[600],
                      ),
                      const SizedBox(width: 2),
                      Text(
                        trend,
                        style: GoogleFonts.lexend(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[600],
                        ),
                      ),
                    ],
                  )
                else if (hasPulse)
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: primary,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: GoogleFonts.lexend(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                Text(
                  title,
                  style: GoogleFonts.lexend(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: subTextColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required String title,
    required IconData icon,
    required String image,
    required Color surfaceColor,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: () {
        HapticFeedback.lightImpact();
        if (onTap != null) onTap();
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: ClipOval(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, color: Colors.white, size: 20),
                    ),
                  ),
                ),
              ),
              Text(
                title,
                style: GoogleFonts.lexend(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAlertCard({
    required String title,
    required String message,
    required String time,
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required Color surfaceColor,
    required Color textColor,
    required Color subTextColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 1),
            blurRadius: 2,
          ),
        ],
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 20),
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
                const SizedBox(height: 2),
                Text(
                  message,
                  style: GoogleFonts.lexend(fontSize: 12, color: subTextColor),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            time,
            style: GoogleFonts.lexend(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: subTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isDarkMode,
    int? badgeCount,
  }) {
    final color = isSelected
        ? (isDarkMode ? primary : Colors.green[700]!)
        : (isDarkMode ? Colors.grey[400]! : Colors.grey[400]!);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Icon(icon, size: 26, color: color),
              if (badgeCount != null)
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isDarkMode ? surfaceDark : surfaceLight,
                        width: 1.5,
                      ),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$badgeCount',
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
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Optional: Auto-check on load
    // UpdateService().showUpdateDialog(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Ideally we want to be subtle, but for verification:
    });
  }
}
