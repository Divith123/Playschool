import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StaffProfilePage extends StatelessWidget {
  const StaffProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode
        ? const Color(0xFF102216)
        : const Color(0xFFf6f8f6);
    final surfaceColor = isDarkMode ? const Color(0xFF1a2c20) : Colors.white;
    final textColor = isDarkMode ? Colors.white : const Color(0xFF0d1b12);
    final subTextColor = isDarkMode
        ? Colors.grey[400]!
        : const Color(0xFF4e6d97);
    const primary = Color(0xFF2bee6c);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 24),
              // Profile Header
              Center(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: primary, width: 2),
                      ),
                      child: const CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuDBl1O--z3eXZQnsoLNTFBQYZ-c_NcAQ2rvjSglRdJKv9fVY1i761_c6_vXUlcaInggtbmNXglkarMleeFEjNpRNuInXQtmDnE6kbhrkqRWdk5dOBOZFEUg-4NxYzr-kyn8LTJsbHyuuOY0bl1LYAq0C9VprsEeotP7h79TIJoUpjFkOnWXuGIT98TRUCmOuSodjWMU-CzyGQWAfr7S5rxSgZKNSjn7xs__rZimP2CK3qEjax0s2lZFJPV32fxJMvAl0j8fK2WvfaE',
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Sarah Jenkins',
                      style: GoogleFonts.lexend(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    Text(
                      'Senior Teacher • Toddler Room B',
                      style: GoogleFonts.lexend(
                        fontSize: 14,
                        color: subTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Stats Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatItem('Students', '15', textColor, subTextColor),
                  _buildStatItem('Hours', '142', textColor, subTextColor),
                  _buildStatItem('Rating', '4.9', textColor, subTextColor),
                ],
              ),
              const SizedBox(height: 32),

              // Actions List
              _buildMenuItem(
                icon: Icons.person_outline,
                label: 'Personal Information',
                onTap: () {},
                isDarkMode: isDarkMode,
                surfaceColor: surfaceColor,
                textColor: textColor,
              ),
              const SizedBox(height: 16),
              _buildMenuItem(
                icon: Icons.schedule,
                label: 'My Schedule / Shifts',
                onTap: () {},
                isDarkMode: isDarkMode,
                surfaceColor: surfaceColor,
                textColor: textColor,
              ),
              const SizedBox(height: 16),
              _buildMenuItem(
                icon: Icons.history,
                label: 'Attendance History',
                onTap: () {},
                isDarkMode: isDarkMode,
                surfaceColor: surfaceColor,
                textColor: textColor,
              ),
              const SizedBox(height: 16),
              _buildMenuItem(
                icon: Icons.settings_outlined,
                label: 'Settings',
                onTap: () {},
                isDarkMode: isDarkMode,
                surfaceColor: surfaceColor,
                textColor: textColor,
              ),
              const SizedBox(height: 16),
              _buildMenuItem(
                icon: Icons.logout,
                label: 'Logout',
                onTap: () {
                  Navigator.of(
                    context,
                  ).pushReplacementNamed('/'); // Back to splash/login
                },
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

  Widget _buildStatItem(
    String label,
    String value,
    Color textColor,
    Color subTextColor,
  ) {
    return Column(
      children: [
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
          style: GoogleFonts.lexend(fontSize: 12, color: subTextColor),
        ),
      ],
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
