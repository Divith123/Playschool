import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/features/staff/operations/staff_incident_report_page.dart';

class AdminStudentProfilePage extends StatelessWidget {
  const AdminStudentProfilePage({super.key});

  static const Color primary = Color(0xFF2bee6c);
  static const Color backgroundLight = Color(0xFFf6f8f6);
  static const Color backgroundDark = Color(0xFF102216);
  static const Color surfaceLight = Color(0xFFffffff);
  static const Color surfaceDark = Color(0xFF1a2c20);
  static const Color textMainLight = Color(0xFF0f172a); // slate-900
  static const Color textMainDark = Color(0xFFffffff);
  static const Color textSubLight = Color(0xFF64748b); // slate-500
  static const Color textSubDark = Color(0xFF94a3b8); // slate-400

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode ? backgroundDark : backgroundLight;
    final surfaceColor = isDarkMode ? surfaceDark : surfaceLight;
    final textColor = isDarkMode ? textMainDark : textMainLight;
    final subTextColor = isDarkMode ? textSubDark : textSubLight;
    final borderColor = isDarkMode
        ? const Color(0xFF1e293b)
        : const Color(0xFFe2e8f0);
    ; // slate-800 : slate-200

    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Sticky Header
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
                bottom: 8,
                left: 16,
                right: 16,
              ),
              color: bgColor.withOpacity(0.95),
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: borderColor.withOpacity(0.5)),
                      ),
                    ),
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            width: 40,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              // color: Colors.transparent // active state handled by InkWell
                            ),
                            child: Icon(Icons.arrow_back, color: textColor),
                          ),
                        ),
                        Text(
                          'Student Profile',
                          style: GoogleFonts.lexend(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Edit',
                            style: GoogleFonts.lexend(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Profile Header Section
            Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 128,
                      height: 128,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          image: NetworkImage(
                            'https://lh3.googleusercontent.com/aida-public/AB6AXuCw-5dTisTDHUqDPSU2MoM8dSe65SSO__1rfGdRXGeT4aDgJZSHA_Khb2tVQdAumPwYHqMmnSrLfT0zF0QrmuM9-qRKCnBqK0dvfY4jE8JQIspL5tj2HssdiGuTL3KcsaYnqP7aYdkrFIxXXzjeHJNPOuQMrdd7pfO_bX44jIOfx8zTtWHqD9XtzHf4G9xylZqP2HvR975-yU5I11hyy_fl6aOr4Ey7GVhe7bqXh-rB_ZFQrDpg4h9hzhIVVaqxFW4SDyFC-HteokQ',
                          ),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                          color: isDarkMode ? surfaceDark : Colors.white,
                          width: 4,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: -8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isDarkMode ? surfaceDark : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isDarkMode
                                ? const Color(0xFF334155)
                                : const Color(0xFFf1f5f9),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
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
                              'Checked In',
                              style: GoogleFonts.lexend(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode
                                    ? Colors.green[400]
                                    : Colors.green[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Leo Das',
                  style: GoogleFonts.lexend(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Tiny Tigers • Room 3',
                  style: GoogleFonts.lexend(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: subTextColor,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildActionButton(
                    Icons.call,
                    'Call Parent',
                    primary,
                    const Color(0xFF0f172a),
                    isDarkMode,
                    onTap: () {
                      // Placeholder for call functionality
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Calling Parent...')),
                      );
                    },
                  ),
                  _buildActionButton(
                    Icons.chat_bubble,
                    'Message',
                    surfaceColor,
                    textColor,
                    isDarkMode,
                    border: true,
                    borderColor: borderColor,
                    onTap: () {
                      // Placeholder for message functionality
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Opening Chat...')),
                      );
                    },
                  ),
                  _buildActionButton(
                    Icons.report_problem,
                    'Log Incident',
                    surfaceColor,
                    textColor,
                    isDarkMode,
                    border: true,
                    borderColor: borderColor,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StaffIncidentReportPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Critical Medical Alerts Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? const Color(0xFF450a0a).withOpacity(0.3)
                    : const Color(0xFFfef2f2), // red-50 / red-900/10
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDarkMode
                      ? const Color(0xFF7f1d1d).withOpacity(0.3)
                      : const Color(0xFFfee2e2), // red-100 / red-900/30
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.medical_services,
                        color: isDarkMode ? Colors.red[400] : Colors.red[600],
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Medical Alerts',
                        style: GoogleFonts.lexend(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.red[100] : Colors.red[900],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildAlertChip(
                        Icons.warning,
                        'Peanut Allergy',
                        isDarkMode,
                      ),
                      _buildAlertChip(
                        Icons.do_not_touch,
                        'Lactose Intolerant',
                        isDarkMode,
                      ),
                      _buildAlertChip(
                        Icons.medication,
                        'Asthma Inhaler',
                        isDarkMode,
                        isBlue: true,
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    padding: const EdgeInsets.only(top: 12),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: isDarkMode
                              ? const Color(0xFF7f1d1d).withOpacity(0.3)
                              : Colors.red[100]!,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: isDarkMode
                                    ? const Color(0xFF7f1d1d).withOpacity(0.4)
                                    : Colors.red[100],
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.monitor_heart,
                                size: 16,
                                color: isDarkMode
                                    ? Colors.red[300]
                                    : Colors.red[700],
                              ), // Stethoscope replacement
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Primary Physician',
                                  style: GoogleFonts.lexend(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: isDarkMode
                                        ? Colors.red[300]?.withOpacity(0.7)
                                        : Colors.red[700]?.withOpacity(0.7),
                                  ),
                                ),
                                Text(
                                  'Dr. Sarah Smith',
                                  style: GoogleFonts.lexend(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: isDarkMode
                                        ? Colors.red[100]
                                        : Colors.red[900],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? const Color(0xFF450a0a)
                                : Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isDarkMode
                                  ? const Color(0xFF7f1d1d)
                                  : Colors.red[100]!,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.call,
                            size: 16,
                            color: isDarkMode
                                ? Colors.red[400]
                                : Colors.red[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Guardians Section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: borderColor),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Guardians',
                    style: GoogleFonts.lexend(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildGuardianItem(
                    'Anita Das',
                    'Mother • Primary',
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuCwqssa6NnYZ_dl0XUWmU86HZbPiD6zTSvjW1GHWG8jf0hwL9TSPh1B6uKJ_Yqvn5OED8Y9Ry54HXMVGYR8vWL5sRSJRnQiCTPP1zTDQ-RoaAMagBr6SY0xBzV8d80Ya4mpS497QnVvVhQjoM4gheA-zPagWbv7homxIFUUqoDZwkOZv1c-pVTRfOECQodH3lsZNBRKGbsoxWZhj0jxBrkOydyV-U0yvWpnIyFOZQDzi7DIyRdNmFavP5MZdRsULwhghhIroDmOSmY',
                    true,
                    isDarkMode,
                    borderColor,
                    textColor,
                    subTextColor,
                    backgroundLight,
                  ),
                  const SizedBox(height: 16),
                  _buildGuardianItem(
                    'Raj Das',
                    'Father',
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuAjOVOml1rwQf3aczha6J9isnuF2SG4woP0re0e-nnt8cAFvMdPpXN2nlmWyJc8XPbwS6jUFQbHcKS9J6EyU-H0LpioDtK5GQIaVH_YHI5tb2gEjmO9Xnpkcr1jC9Q_U0411nEv0uzewUwNCC0UWvmyY8IV4-_qgOrRc26ZGlcUE3vFLR2PIjKBlht-fO1jjkp9x06VxPvyBhN9FHgW4XfQ9fxHsTjyLsCRoeTkepD0YDWMsCdadx_nLG6a43ZWYym15ydo7tGpEUs',
                    false,
                    isDarkMode,
                    borderColor,
                    textColor,
                    subTextColor,
                    backgroundLight,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Authorized Pick-up
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: borderColor),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Authorized Pick-up',
                        style: GoogleFonts.lexend(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      Text(
                        'See All',
                        style: GoogleFonts.lexend(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildPickupPerson(
                          'Maria',
                          'Grandma',
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuCPr6HYsyryZkSCx81Nz9T-JPjbMEbg7HNWHbu-8HjCd2P29HiLQof0rMwx_dbrixgUtXzRc8xT0uVlJsqFPB1Ym87FMuTX9yZWFiY3-DUr6n4O1mITHSXkW_9rFtspxNyxq17TU5uBzYMEZyN6-UayG7-urFpb4f4lNNftT7aqG-ll0xaECYiHT9XzJbgZmaC5m-2PfbAhngF12L0eK1eu468TrZZvBQ7ZNOPA8JWUaO0BzsUk2RsFEoTyPjqoCs8WhHxnN8do_f0',
                          isDarkMode,
                          surfaceDark,
                        ),
                        const SizedBox(width: 16),
                        _buildPickupPerson(
                          'David',
                          'Uncle',
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuC5DFnCQ-nm9QIUbFqxq9L9khgH98zv8ebDyq_B3aJ5sqTPIAD9J3-R-6VhSGPvyiGsIcqJzi47ucXb593f8qiD99uR76uWYfTEr0HAYUW3ia-wOWYqV5cFxnJh4t4c56mB2fxGc0WA-9bv0NVP1VAuN6-ohJNRgp3bU_H91sos4DZswh128FHuscKjcpD1V-bsxSkFUqGGBaiOrEuHXbJSWVJIdZqRtqmm600XGOs2qaoXBB3XeOYC-sZ3B5MIcJ1YoU7v4DlusWg',
                          isDarkMode,
                          surfaceDark,
                        ),
                        const SizedBox(width: 16),
                        _buildPickupPerson(
                          'Sarah',
                          'Nanny',
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuB8abfdzJHgnavbbIdoNRfLmWbeA54BS4Pdw05acFYNWBbBnoj_fYs3rf0NQSgHIgUE-fZuaFVv0iesV_U8c7-dqLwqyd8fU2bPYh2EiHW0oo5KWNQ-TAbPrTJ5dumuLLVDSbFeaBvivgeeIkKRWWm9bjy-RDFVSI2TAgc43qvfG5HuzzlOS4fUFXVT5r1vnQM6DQDznw_FVWTVoKcCYFXvSfguLgy2isj9l-LOU95s_8H8X-OjuzmHVFbvAwFydrTVGxZpUDWNEZ0',
                          isDarkMode,
                          surfaceDark,
                        ),
                        const SizedBox(width: 16),
                        _buildAddPickup(
                          isDarkMode,
                          backgroundLight,
                          textSubLight,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Documents Section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: borderColor),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Documents',
                    style: GoogleFonts.lexend(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 2.5,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    children: [
                      _buildDocItem(
                        'Birth Cert...',
                        'Aug 20, 2023',
                        Icons.picture_as_pdf,
                        Colors.red,
                        isDarkMode,
                      ),
                      _buildDocItem(
                        'Vaccination...',
                        'Sep 12, 2023',
                        Icons.description,
                        Colors.blue,
                        isDarkMode,
                      ),
                      _buildDocItem(
                        'Enrollment...',
                        'Jan 10, 2023',
                        Icons.image,
                        Colors.purple,
                        isDarkMode,
                      ),
                      _buildViewAll(isDarkMode, borderColor, textSubLight),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 100), // Bottom padding
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    IconData icon,
    String label,
    Color bg,
    Color iconColor,
    bool isDarkMode, {
    bool border = false,
    Color? borderColor,
    VoidCallback? onTap,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(16),
              border: border ? Border.all(color: borderColor!) : null,
              boxShadow: [
                BoxShadow(
                  color: bg.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, color: iconColor, size: 28),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.lexend(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isDarkMode
                ? Colors.grey[300]
                : const Color(0xFF334155), // slate-300 : slate-700
          ),
        ),
      ],
    );
  }

  Widget _buildAlertChip(
    IconData icon,
    String label,
    bool isDarkMode, {
    bool isBlue = false,
  }) {
    final bgColor = isBlue
        ? (isDarkMode
              ? const Color(0xFF1e3a8a).withOpacity(0.2)
              : Colors.blue[50]) // blue-900/20 : blue-50
        : (isDarkMode
              ? const Color(0xFF450a0a)
              : Colors.white); // red-950 : white

    final borderColor = isBlue
        ? (isDarkMode
              ? const Color(0xFF1e40af).withOpacity(0.5)
              : Colors.blue[100]) // blue-800/50 : blue-100
        : (isDarkMode
              ? const Color(0xFF991b1b)
              : Colors.red[200]); // red-800 : red-200

    final iconColor = isBlue
        ? (isDarkMode ? Colors.blue[400] : Colors.blue[600])
        : (isDarkMode ? Colors.red[400] : Colors.red[600]);

    final textColor = isBlue
        ? (isDarkMode ? Colors.blue[300] : Colors.blue[700])
        : (isDarkMode ? Colors.red[300] : Colors.red[700]);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: iconColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGuardianItem(
    String name,
    String role,
    String imageUrl,
    bool isBordered,
    bool isDarkMode,
    Color borderColor,
    Color textColor,
    Color subTextColor,
    Color buttonBgLight,
  ) {
    return Container(
      // Border logic if needed, but styling shows internal border for list items usually.
      // HTML passes border-b for first item.
      decoration: isBordered
          ? BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isDarkMode
                      ? const Color(0xFF334155).withOpacity(0.5)
                      : const Color(0xFFf1f5f9),
                ),
              ),
            )
          : null,
      padding: isBordered ? const EdgeInsets.only(bottom: 16) : EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.lexend(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  Text(
                    role,
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
          Row(
            children: [
              _buildSmallIconButton(
                Icons.message,
                isDarkMode,
                buttonBgLight,
                isDarkMode ? Colors.grey[200] : const Color(0xFF334155),
              ),
              const SizedBox(width: 8),
              _buildSmallIconButton(
                Icons.call,
                isDarkMode,
                primary.withOpacity(0.2),
                isDarkMode ? Colors.green[300] : Colors.green[700],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSmallIconButton(
    IconData icon,
    bool isDarkMode,
    Color bg,
    Color? iconColor,
  ) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
      child: Icon(icon, size: 18, color: iconColor),
    );
  }

  Widget _buildPickupPerson(
    String name,
    String relation,
    String imageUrl,
    bool isDarkMode,
    Color borderColor,
  ) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
            border: Border.all(
              color: isDarkMode ? borderColor : Colors.white,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 2),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: GoogleFonts.lexend(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : const Color(0xFF0f172a),
          ),
        ),
        Text(
          relation,
          style: GoogleFonts.lexend(
            fontSize: 10,
            color: isDarkMode ? Colors.grey[400] : const Color(0xFF64748b),
          ),
        ),
      ],
    );
  }

  Widget _buildAddPickup(bool isDarkMode, Color bgLight, Color iconColorLight) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: isDarkMode
                ? const Color(0xFF1e293b)
                : bgLight, // slate-800 : bg-light
            shape: BoxShape.circle,
            border: Border.all(
              color: isDarkMode
                  ? const Color(0xFF475569)
                  : const Color(0xFFcbd5e1),
              style: BorderStyle.solid,
            ), // dashed in html but solid is easier for now, flutter needs custom painter for dashed border
          ),
          child: Icon(
            Icons.add,
            color: isDarkMode ? Colors.grey[500] : const Color(0xFF94a3b8),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Add New',
          style: GoogleFonts.lexend(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.grey[500] : const Color(0xFF94a3b8),
          ),
        ),
        const SizedBox(height: 14), // Spacer to align with text above
      ],
    );
  }

  Widget _buildDocItem(
    String title,
    String date,
    IconData icon,
    MaterialColor color,
    bool isDarkMode,
  ) {
    final bg = isDarkMode ? color.shade900.withOpacity(0.3) : color.shade100;
    final iconColor = isDarkMode ? color.shade400 : color.shade500;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(0xFF1e293b)
            : const Color(0xFFf6f8f6), // slate-800 : bg-light
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDarkMode ? const Color(0xFF334155) : const Color(0xFFf1f5f9),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: GoogleFonts.lexend(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : const Color(0xFF0f172a),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  date,
                  style: GoogleFonts.lexend(
                    fontSize: 12,
                    color: isDarkMode
                        ? Colors.grey[400]
                        : const Color(0xFF64748b),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewAll(bool isDarkMode, Color borderColor, Color textColor) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1e293b) : const Color(0xFFf6f8f6),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDarkMode ? const Color(0xFF475569) : const Color(0xFFcbd5e1),
          style: BorderStyle.none,
        ), // Using solid for simplicity
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'View All',
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
          const SizedBox(width: 8),
          Icon(Icons.arrow_forward, size: 16, color: textColor),
        ],
      ),
    );
  }
}
