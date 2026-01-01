import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:playschool/features/admin/students/admin_admission_form_page.dart';
import 'package:playschool/features/admin/students/admin_student_profile_page.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminAdmissionsPage extends StatefulWidget {
  const AdminAdmissionsPage({super.key});

  @override
  State<AdminAdmissionsPage> createState() => _AdminAdmissionsPageState();
}

class _AdminAdmissionsPageState extends State<AdminAdmissionsPage> {
  static const Color primary = Color(0xFF2bee6c);
  static const Color backgroundLight = Color(0xFFf6f8f6);
  static const Color backgroundDark = Color(0xFF102216);
  static const Color cardLight = Color(0xFFffffff);
  static const Color cardDark = Color(0xFF1a2e22);
  static const Color textMainLight = Color(0xFF0d1b12);
  static const Color textMainDark = Color(0xFFf0f4f1);

  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode ? backgroundDark : backgroundLight;
    final cardColor = isDarkMode ? cardDark : cardLight;
    final textColor = isDarkMode ? textMainDark : textMainLight;
    final subTextColor = isDarkMode ? Colors.grey[400]! : Colors.grey[500]!;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: bgColor.withOpacity(0.95),
                border: Border(
                  bottom: BorderSide(
                    color: isDarkMode
                        ? Colors.white.withOpacity(0.05)
                        : Colors.transparent,
                  ),
                ),
              ),
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Icon(Icons.arrow_back, color: textColor),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Admissions',
                                style: GoogleFonts.lexend(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                  height: 1.1,
                                  letterSpacing: -0.015,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 32),
                            child: Text(
                              'Lead Management',
                              style: GoogleFonts.lexend(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: subTextColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: cardColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                            child: Icon(Icons.filter_list, color: textColor),
                          ),
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const AdminAdmissionFormPage(),
                                ),
                              );
                            },
                            child: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: primary,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: primary.withOpacity(0.3),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Color(0xFF0d1b12),
                                weight: 600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Main Content Area
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Search Bar
                    Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Icon(Icons.search, color: subTextColor),
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search child or parent...',
                                hintStyle: GoogleFonts.lexend(
                                  color: subTextColor,
                                ),
                              ),
                              style: GoogleFonts.lexend(color: textColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Filter Chips
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildFilterChip(
                            'All',
                            null,
                            null,
                            cardColor,
                            textColor,
                            isDarkMode,
                          ),
                          const SizedBox(width: 12),
                          _buildFilterChip(
                            'New',
                            Icons.star,
                            Colors.orange,
                            cardColor,
                            textColor,
                            isDarkMode,
                          ),
                          const SizedBox(width: 12),
                          _buildFilterChip(
                            'Contacted',
                            Icons.phone_in_talk,
                            Colors.blue,
                            cardColor,
                            textColor,
                            isDarkMode,
                          ),
                          const SizedBox(width: 12),
                          _buildFilterChip(
                            'Toured',
                            Icons.visibility,
                            Colors.purple,
                            cardColor,
                            textColor,
                            isDarkMode,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Leads List
                    Column(
                      children: [
                        // Card 1: New Lead
                        _buildLeadCard(
                          name: 'Oliver Smith',
                          age: '3y 4m',
                          parent: 'Sarah Smith',
                          status: 'New',
                          statusColor: Colors.orange,
                          statusIcon: Icons.star,
                          avatarUrl:
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuBuWF_ItRYEali9rq2vXNo78ujGFib4UtRLzCMQijq22Rp8TD_aNHvIxTdcuc20NMC9dHYnV2k0zHm8UdLzv6f7mXkuyGv8pSzJzVPzMEO6RvrOtS5lSlb-Ap-xoJUml4tdJue58E8ajEvY-d8ZOSnWdVaYqDfP6PgNM_HJoN2ZnrkwdD4m5RX2tnqkAUST93u3-C1Nm-Z2yh36s9UYzpE9_Z9f8tGuE395nAQMcKbHiwnhp0by7ZOBirY2IinMhl0mUxSx5QbQIRc',
                          note:
                              '"Parent inquired about summer program availability. Very interested in outdoor activities."',
                          actions: [
                            _buildActionItem(Icons.call, 'Call', isDarkMode),
                            _buildActionItem(Icons.mail, 'Email', isDarkMode),
                            _buildActionItem(
                              Icons.edit_note,
                              'Note',
                              isDarkMode,
                            ),
                            _buildActionItem(
                              Icons.calendar_month,
                              'Tour',
                              isDarkMode,
                            ),
                          ],
                          isDarkMode: isDarkMode,
                          cardColor: cardColor,
                          textColor: textColor,
                          subTextColor: subTextColor,
                        ),
                        const SizedBox(height: 16),

                        // Card 2: Contacted
                        _buildLeadCard(
                          name: 'Emma Williams',
                          age: '4y 1m',
                          parent: 'John Williams',
                          status: 'Contacted',
                          statusColor: Colors.blue,
                          statusIcon: Icons.phone_in_talk,
                          avatarUrl:
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuC9dWccSLOqQkdaVZUGo8pe_0oFtgs4aPtSApeElP7-dq_MFdY064wLS0TmCmEhix3Aw5cgVHHsKJ9rDRbeQLoDgh_xJ1fGPPXCIMMtAWE_bfI5Gm3Oxa5oc0eoWoN0xq6BIzR27hy3cHugBPNOBOdEl15ZyDm9InUCVOVcxH_uGIYHhZxjzYqpWszReUGEZsFxu08Z3lnLAOZ2nMJznBByND6AtHcUTM9bPKv_4MlcM1dfkSNJc7fClcELchhAcDTcI0YGzmSIkcs',
                          lastAction: 'Email sent 2 days ago',
                          actions: [
                            Expanded(
                              // Special prominent primary button
                              flex: 2,
                              child: _buildProminentAction(
                                Icons.calendar_month,
                                'Schedule Tour',
                                isDarkMode,
                              ),
                            ),
                            const SizedBox(width: 8),
                            _buildActionItem(Icons.call, null, isDarkMode),
                            const SizedBox(width: 8),
                            _buildActionItem(
                              Icons.more_horiz,
                              null,
                              isDarkMode,
                            ),
                          ],
                          isDarkMode: isDarkMode,
                          cardColor: cardColor,
                          textColor: textColor,
                          subTextColor: subTextColor,
                        ),
                        const SizedBox(height: 16),

                        // Card 3: Toured
                        _buildLeadCard(
                          name: 'Lucas Brown',
                          age: '2y',
                          parent: 'Emily Brown',
                          status: 'Toured',
                          statusColor: Colors.purple,
                          statusIcon: Icons.visibility,
                          initials: 'LB',
                          initialsColor: Colors.blue,
                          alertTitle: 'Follow-up Required',
                          alertMessage:
                              'Tour completed yesterday. Send admission packet.',
                          actions: [
                            _buildActionItem(
                              Icons.check_circle,
                              'Admit',
                              isDarkMode,
                            ),
                            _buildActionItem(Icons.mail, 'Email', isDarkMode),
                            _buildActionItem(
                              Icons.edit_note,
                              'Note',
                              isDarkMode,
                            ),
                            _buildActionItem(
                              Icons.close,
                              'Archive',
                              isDarkMode,
                            ),
                          ],
                          isDarkMode: isDarkMode,
                          cardColor: cardColor,
                          textColor: textColor,
                          subTextColor: subTextColor,
                        ),
                        const SizedBox(height: 16),

                        // Card 4: Admitted
                        _buildLeadCard(
                          name: 'Noah Jones',
                          age: '3y',
                          parent: 'Michael Jones',
                          status: 'Admitted',
                          statusColor: Colors.green,
                          statusIcon: Icons.check_circle,
                          avatarUrl:
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuD-Lp0qxib0bLpJ6jPnGC-wYBkUIFw_f-luG8eXPdeqbZc2N37imF7GceEbAECmgqtDMiK3zEq_7Vw8gdYSayDEO19YCzEXo8pWH0HZW8YPalJd6wl1lmdtcgnuN7Ia7gx-UzWnw--E1Cf1pm0SD-PcWF2QFvlMI0JmPIDd91lVfF0mpMXA5dNUto-WAQU8aaFybEUMVF04wXSgXHpnQ2aU0mN19oQ8BS1WrIZMvI4irLKO0QV9mf5YYZp2i0_Po4rXX3KLzW-qF4E',
                          historyInfo: 'Admitted on Oct 12, 2023',
                          isAdmitted: true,
                          isDarkMode: isDarkMode,
                          cardColor: cardColor,
                          textColor: textColor,
                          subTextColor: subTextColor,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const AdminStudentProfilePage(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(
    String label,
    IconData? icon,
    Color? color,
    Color cardColor,
    Color textColor,
    bool isDarkMode,
  ) {
    final isSelected = _selectedFilter == label;
    final bgColor = isSelected
        ? (isDarkMode ? Colors.white : const Color(0xFF0d1b12))
        : cardColor;
    final fgColor = isSelected
        ? (isDarkMode ? const Color(0xFF0d1b12) : Colors.white)
        : textColor;

    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = label),
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(18),
          border: isSelected
              ? null
              : Border.all(
                  color: isDarkMode
                      ? Colors.white.withOpacity(0.1)
                      : Colors.transparent,
                ),
          boxShadow: isSelected
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 2,
                  ),
                ],
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18, color: color),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: GoogleFonts.lexend(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: fgColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeadCard({
    required String name,
    required String age,
    required String parent,
    required String status,
    required Color statusColor,
    required IconData statusIcon,
    String? avatarUrl,
    String? initials,
    Color? initialsColor,
    String? note,
    String? lastAction,
    String? alertTitle,
    String? alertMessage,
    String? historyInfo,
    List<Widget>? actions,
    bool isAdmitted = false,
    required bool isDarkMode,
    required Color cardColor,
    required Color textColor,
    required Color subTextColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              offset: const Offset(0, 2),
              blurRadius: 8,
            ),
          ],
          border: isDarkMode
              ? Border.all(color: Colors.white.withOpacity(0.05))
              : null,
        ),
        child: Opacity(
          opacity: isAdmitted ? 0.7 : 1.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (avatarUrl != null)
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isDarkMode
                                  ? Colors.white.withOpacity(0.1)
                                  : Colors.white,
                              width: 2,
                            ),
                            color: Colors.grey[200],
                            image: DecorationImage(
                              image: NetworkImage(avatarUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      else if (initials != null)
                        Container(
                          width: 48,
                          height: 48,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? (initialsColor?.withOpacity(0.2) ??
                                      Colors.blue[900])
                                : (initialsColor?.withOpacity(0.1) ??
                                      Colors.blue[100]),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isDarkMode
                                  ? Colors.white.withOpacity(0.1)
                                  : Colors.white,
                              width: 2,
                            ),
                          ),
                          child: Text(
                            initials,
                            style: GoogleFonts.lexend(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: initialsColor ?? Colors.blue,
                            ),
                          ),
                        ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: name,
                              style: GoogleFonts.lexend(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                              children: [
                                TextSpan(
                                  text: ' ($age)',
                                  style: GoogleFonts.lexend(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: subTextColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Parent: $parent',
                            style: GoogleFonts.lexend(
                              fontSize: 14,
                              color: subTextColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(isDarkMode ? 0.2 : 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(statusIcon, size: 14, color: statusColor),
                        const SizedBox(width: 4),
                        Text(
                          status,
                          style: GoogleFonts.lexend(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: statusColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              if (note != null) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? Colors.black.withOpacity(0.2)
                        : backgroundLight,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.transparent),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LATEST NOTE',
                        style: GoogleFonts.lexend(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? primary : const Color(0xFF4c9a66),
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        note,
                        style: GoogleFonts.lexend(
                          fontSize: 14,
                          color: isDarkMode ? Colors.grey[300] : textMainLight,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],

              if (lastAction != null) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.schedule, size: 18, color: subTextColor),
                    const SizedBox(width: 8),
                    Text(
                      'Last action: $lastAction',
                      style: GoogleFonts.lexend(
                        fontSize: 14,
                        color: subTextColor,
                      ),
                    ),
                  ],
                ),
              ],

              if (alertTitle != null) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: primary.withOpacity(isDarkMode ? 0.1 : 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: primary.withOpacity(0.2)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.notification_important, color: primary),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              alertTitle,
                              style: GoogleFonts.lexend(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primary,
                              ),
                            ),
                            Text(
                              alertMessage!,
                              style: GoogleFonts.lexend(
                                fontSize: 14,
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              if (historyInfo != null) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.history, size: 18, color: subTextColor),
                    const SizedBox(width: 8),
                    Text(
                      historyInfo,
                      style: GoogleFonts.lexend(
                        fontSize: 14,
                        color: subTextColor,
                      ),
                    ),
                  ],
                ),
              ],

              if (actions != null) ...[
                const SizedBox(height: 12),
                if (lastAction != null)
                  const Divider(), // Visual separator for contacted card
                const SizedBox(height: 4),
                Row(
                  children: actions.map((widget) {
                    // If it's the prominent button (Expanded), don't wrap in Expanded again
                    if (widget is Expanded) return widget;
                    return Expanded(child: widget); // Distribute equally
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionItem(IconData icon, String? label, bool isDarkMode) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? primary.withOpacity(0.2)
                  : const Color(0xFFe7f3eb),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 20,
              color: isDarkMode ? primary : const Color(0xFF0d1b12),
            ),
          ),
          if (label != null) ...[
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.lexend(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildProminentAction(IconData icon, String label, bool isDarkMode) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: const Color(0xFF0d1b12)),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0d1b12),
            ),
          ),
        ],
      ),
    );
  }
}
