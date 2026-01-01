import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/features/parent/services/parent_pickup_manager_page.dart';
import 'package:playschool/features/common/app_settings_page.dart';

class ParentProfilePage extends StatelessWidget {
  const ParentProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode
        ? const Color(0xFF102216)
        : const Color(0xFFf6f8f6);
    final surfaceColor = isDarkMode ? const Color(0xFF1a2c20) : Colors.white;
    final textColor = isDarkMode ? Colors.white : const Color(0xFF0d1b12);
    final subTextColor = isDarkMode
        ? Colors.grey[400]
        : const Color(0xFF4e6d97);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 24),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuAJufh0mrItXNm9ESF2g4RZWrRNkzks20AxzLM7auYvgKY_sz0Y2XtzOX1tCJPpVrquLbqGdm5AdQYLZ8glNB7fyRkyIizIOeY_DU87wOWmpnEsDdrTqnMWRQuS-X3ezwX4XzwgugHGlA7PooLFl67pnvidoT0jepGcHQWOdObwomnlymjnBkLlq2wyix0MhJy072iysHqbNhyEIFJ2cxM1vFnWDFmeCp2wLKsPR2MwJlkPbWjMzcoC34MHWgxy6OEAV3QYj7hlByw',
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Sarah Miller',
                style: GoogleFonts.lexend(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              Text(
                'Parent of Leo',
                style: GoogleFonts.lexend(fontSize: 14, color: subTextColor),
              ),
              const SizedBox(height: 32),

              _buildMenuItem(
                icon: Icons.people_outline,
                label: 'Authorized Pickups',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ParentPickupManagerPage(),
                    ),
                  );
                },
                isDarkMode: isDarkMode,
                surfaceColor: surfaceColor,
                textColor: textColor,
              ),
              const SizedBox(height: 16),
              _buildMenuItem(
                icon: Icons.settings_outlined,
                label: 'Settings',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AppSettingsPage(),
                    ),
                  );
                },
                isDarkMode: isDarkMode,
                surfaceColor: surfaceColor,
                textColor: textColor,
              ),
              const SizedBox(height: 16),
              _buildMenuItem(
                icon: Icons.help_outline,
                label: 'Help & Support',
                onTap: () {},
                isDarkMode: isDarkMode,
                surfaceColor: surfaceColor,
                textColor: textColor,
              ),
              const SizedBox(height: 16),
              _buildMenuItem(
                icon: Icons.logout,
                label: 'Logout',
                onTap: () {},
                isDarkMode: isDarkMode,
                surfaceColor: surfaceColor,
                textColor: Colors.red,
                iconColor: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required bool isDarkMode,
    required Color surfaceColor,
    required Color textColor,
    Color? iconColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: (iconColor ?? textColor).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor ?? textColor),
        ),
        title: Text(
          label,
          style: GoogleFonts.lexend(
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
