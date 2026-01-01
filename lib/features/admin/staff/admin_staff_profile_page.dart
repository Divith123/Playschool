import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/features/common/app_settings_page.dart';

class AdminStaffProfilePage extends StatelessWidget {
  const AdminStaffProfilePage({super.key});

  static const Color primary = Color(0xFF2b8cee);
  static const Color backgroundLight = Color(0xFFf6f7f8);
  static const Color backgroundDark = Color(0xFF101922);
  static const Color surfaceLight = Color(0xFFffffff);
  static const Color surfaceDark = Color(0xFF1e2936);
  static const Color textMainLight = Color(0xFF0d141b);
  static const Color textMainDark = Color(0xFFffffff);
  static const Color textMutedLight = Color(0xFF4c739a);
  static const Color textMutedDark = Color(0xFF9ca3af); // gray-400
  static const Color borderColorLight = Color(0xFFe2e8f0); // slate-200
  static const Color borderColorDark = Color(0xFF1e293b); // slate-800

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode ? backgroundDark : backgroundLight;
    final surfaceColor = isDarkMode ? surfaceDark : surfaceLight;
    final textColor = isDarkMode ? textMainDark : textMainLight;
    final mutedColor = isDarkMode ? textMutedDark : textMutedLight;
    final borderColor = isDarkMode ? borderColorDark : borderColorLight;

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(
              top:
                  MediaQuery.of(context).padding.top +
                  60, // Space for sticky header
              bottom: 24,
            ),
            child: Column(
              children: [
                // Profile Header
                Column(
                  children: [
                    const SizedBox(height: 24),
                    Stack(
                      children: [
                        Container(
                          width: 112,
                          height: 112,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle, // Rounded-full
                            color: Colors.grey[300],
                            border: Border.all(
                              color: isDarkMode ? surfaceDark : Colors.white,
                              width: 4,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                            image: const DecorationImage(
                              image: NetworkImage(
                                'https://lh3.googleusercontent.com/aida-public/AB6AXuBHJUXGumrMlSxLNRNkaR5-OR4vKkSJRG_QqfS012BuC2GO-oEmkffMcLucGoxPAYQUZror0MzF-dpbX53rhTBvHJQMG12-RbUWsO_zegd-ID_ugftsC1KvSzddAkl2zu86tH5MiQdNZg999nr2XFvLQ8MW9q56xO6TYsb2bJap8H1CTKQYQFlyHvNzZoSxVBYgdcmBCAuYhnH4dp8NKXh0AZxCk0lQMpupApLp7WTIp9gLFffYSLaY8p0pj7UMPOGXFtZc-yVrPOU',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isDarkMode ? surfaceDark : Colors.white,
                                width: 2,
                              ),
                            ),
                            child: const Icon(
                              Icons.check,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Sarah Jenkins',
                      style: GoogleFonts.manrope(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Senior Educator',
                      style: GoogleFonts.manrope(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: mutedColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? Colors.green[900]!.withValues(alpha: 0.3)
                            : Colors.green[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Active',
                            style: GoogleFonts.manrope(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isDarkMode
                                  ? Colors.green[400]
                                  : Colors.green[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Quick Actions
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildQuickAction(
                        Icons.call,
                        'Call',
                        primary,
                        isDarkMode,
                        mutedColor,
                      ),
                      const SizedBox(width: 24),
                      _buildQuickAction(
                        Icons.chat_bubble,
                        'Message',
                        primary,
                        isDarkMode,
                        mutedColor,
                      ),
                      const SizedBox(width: 24),
                      _buildQuickAction(
                        Icons.mail,
                        'Email',
                        primary,
                        isDarkMode,
                        mutedColor,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Content Container
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      // Contact Information
                      _buildSectionHeader('Contact Information', mutedColor),
                      Container(
                        decoration: BoxDecoration(
                          color: surfaceColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: borderColor),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            _buildInfoRow(
                              Icons.phone_iphone,
                              'Mobile',
                              '+1 (555) 012-3456',
                              true,
                              isDarkMode,
                              textColor,
                              mutedColor,
                              showCopy: true,
                            ),
                            Divider(height: 1, color: borderColor),
                            _buildInfoRow(
                              Icons.alternate_email,
                              'Work Email',
                              'sarah.j@playschool.com',
                              false,
                              isDarkMode,
                              textColor,
                              mutedColor,
                              showCopy: true,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Professional Details
                      _buildSectionHeader('Professional Details', mutedColor),
                      Container(
                        decoration: BoxDecoration(
                          color: surfaceColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: borderColor),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            _buildDetailRow(
                              'Employee ID',
                              '#STAFF-004',
                              isDarkMode,
                              textColor,
                              mutedColor,
                            ),
                            Divider(height: 1, color: borderColor),
                            _buildDetailRow(
                              'Role',
                              'Lead Teacher',
                              isDarkMode,
                              textColor,
                              mutedColor,
                            ),
                            Divider(height: 1, color: borderColor),
                            _buildDetailRow(
                              'Start Date',
                              'Aug 12, 2021',
                              isDarkMode,
                              textColor,
                              mutedColor,
                            ),
                            Divider(height: 1, color: borderColor),
                            _buildDetailRow(
                              'Assigned Room',
                              'Sunshine Room (3-4y)',
                              isDarkMode,
                              textColor,
                              mutedColor,
                              isBadge: true,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Compliance & Docs
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildSectionHeader(
                            'Compliance',
                            mutedColor,
                            noMargin: true,
                          ),
                          TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.add, size: 16),
                            label: Text(
                              'Add Doc',
                              style: GoogleFonts.manrope(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              foregroundColor: primary,
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: surfaceColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: borderColor),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            _buildDocItem(
                              Icons.verified_user,
                              'Background Check',
                              'Valid until Dec 2024',
                              Colors.blue,
                              Colors.green,
                              isDarkMode,
                              textColor,
                              mutedColor,
                              isValid: true,
                            ),
                            Divider(height: 1, color: borderColor),
                            _buildDocItem(
                              Icons.medical_services,
                              'First Aid Certificate',
                              'Expiring in 15 days',
                              Colors.orange,
                              Colors.orange,
                              isDarkMode,
                              textColor,
                              mutedColor,
                              isWarning: true,
                            ),
                            Divider(height: 1, color: borderColor),
                            _buildDocItem(
                              Icons.description,
                              'Contract Agreement',
                              'Signed Aug 12, 2021',
                              Colors.grey,
                              Colors.grey,
                              isDarkMode,
                              textColor,
                              mutedColor,
                              actionIcon: Icons.download,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Emergency Contact
                      _buildSectionHeader('Emergency Contact', mutedColor),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: surfaceColor,
                          borderRadius: BorderRadius.circular(12),
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
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: isDarkMode
                                    ? Colors.red[900]!.withValues(alpha: 0.2)
                                    : Colors.red[50],
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.add_home, // Closest to emergency_home
                                color: Colors.red[500],
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'John Jenkins',
                                    style: GoogleFonts.manrope(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: textColor,
                                    ),
                                  ),
                                  Text(
                                    'Husband',
                                    style: GoogleFonts.manrope(
                                      fontSize: 14,
                                      color: mutedColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: isDarkMode
                                    ? Colors.grey[700]
                                    : Colors.grey[50],
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isDarkMode
                                      ? Colors.grey[600]!
                                      : Colors.grey[200]!,
                                ),
                              ),
                              child: Icon(Icons.call, color: primary, size: 20),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Deactivate Button
                      SizedBox(
                        width: double.infinity,
                        child: TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.person_off, size: 18),
                          label: const Text('Deactivate Profile'),
                          style: TextButton.styleFrom(
                            foregroundColor: isDarkMode
                                ? Colors.red[400]
                                : Colors.red[600],
                            backgroundColor: isDarkMode
                                ? Colors.red[900]!.withValues(alpha: 0.1)
                                : Colors.red[50],
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                color: isDarkMode
                                    ? Colors.red[900]!.withValues(alpha: 0.5)
                                    : Colors.red[200]!,
                              ),
                            ),
                            textStyle: GoogleFonts.manrope(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Sticky Top Header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                    bottom: 12,
                    left: 16,
                    right: 16,
                  ),
                  decoration: BoxDecoration(
                    color: bgColor.withValues(alpha: 0.9),
                    border: Border(bottom: BorderSide(color: borderColor)),
                  ),
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
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: primary,
                            size: 20,
                          ),
                        ),
                      ),
                      Text(
                        'Staff Profile',
                        style: GoogleFonts.manrope(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AppSettingsPage(),
                            ),
                          );
                        },
                        icon: Icon(Icons.settings, color: primary),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction(
    IconData icon,
    String label,
    Color primaryColor,
    bool isDarkMode,
    Color mutedColor,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: primaryColor.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: primaryColor, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isDarkMode ? Colors.grey[300] : Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(
    String title,
    Color color, {
    bool noMargin = false,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: noMargin ? 0 : 12, left: 4),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.manrope(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: color,
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    IconData icon,
    String label,
    String value,
    bool isFirst,
    bool isDarkMode,
    Color textColor,
    Color mutedColor, {
    bool showCopy = false,
  }) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[700] : Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isDarkMode ? Colors.grey[400] : Colors.grey[500],
                size: 18,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.manrope(fontSize: 14, color: mutedColor),
                  ),
                  Text(
                    value,
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
            if (showCopy) Icon(Icons.copy, color: Colors.grey[300], size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value,
    bool isDarkMode,
    Color textColor,
    Color mutedColor, {
    bool isBadge = false,
  }) {
    return Row(
      children: [
        Container(
          width: 120,
          padding: const EdgeInsets.all(16),
          color: isDarkMode
              ? Colors.grey[800]!.withValues(alpha: 0.3)
              : Colors.grey[50]!.withValues(alpha: 0.5),
          child: Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: mutedColor,
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: isBadge
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? Colors.orange[900]!.withValues(alpha: 0.3)
                            : Colors.orange[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isDarkMode
                              ? Colors.orange[800]!
                              : Colors.orange[200]!,
                        ),
                      ),
                      child: Text(
                        value,
                        style: GoogleFonts.manrope(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode
                              ? Colors.orange[300]
                              : Colors.orange[700],
                        ),
                      ),
                    ),
                  )
                : Text(
                    value,
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildDocItem(
    IconData icon,
    String title,
    String subtitle,
    Color iconColor,
    Color iconBgColor,
    bool isDarkMode,
    Color textColor,
    Color mutedColor, {
    bool isValid = false,
    bool isWarning = false,
    IconData? actionIcon,
  }) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isDarkMode
                    ? iconColor.withValues(alpha: 0.2)
                    : iconColor.withValues(alpha: 0.1), // Adjusted opacity
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  if (isValid || isWarning)
                    Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: isValid ? Colors.green : Colors.orange,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          subtitle,
                          style: GoogleFonts.manrope(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: isValid
                                ? (isDarkMode
                                      ? Colors.green[400]
                                      : Colors.green[600])
                                : (isDarkMode
                                      ? Colors.orange[400]
                                      : Colors.orange[600]),
                          ),
                        ),
                      ],
                    )
                  else
                    Text(
                      subtitle,
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        color: mutedColor,
                      ),
                    ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                actionIcon ?? Icons.visibility,
                color: Colors.grey[400],
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
