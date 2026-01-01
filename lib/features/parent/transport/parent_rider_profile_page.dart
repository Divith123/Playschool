import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class ParentRiderProfilePage extends StatefulWidget {
  const ParentRiderProfilePage({super.key});

  @override
  State<ParentRiderProfilePage> createState() => _ParentRiderProfilePageState();
}

class _ParentRiderProfilePageState extends State<ParentRiderProfilePage> {
  // Mock rider
  final Map<String, dynamic> _rider = {
    'name': 'Alice Wonder',
    'id': 'TP-2025-001',
    'route': 'Route #4 (North)',
    'busNo': 'Bus MP-45',
    'driver': 'Mike Johnson',
    'driverPhone': '+1 555-0192',
    'boardingPoint': '742 Evergreen Terrace',
    'pickupTime': '07:45 AM',
    'dropTime': '03:15 PM',
  };

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode
        ? AppColors.backgroundDark
        : AppColors.backgroundLight;
    final surfaceColor = isDarkMode
        ? AppColors.surfaceDark
        : AppColors.surfaceLight;
    final textColor = isDarkMode
        ? AppColors.textMainDark
        : AppColors.textMainLight;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          'Rider Profile',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // ID Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange.shade700, Colors.deepOrange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withValues(alpha: 0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      'https://placehold.co/200x200/png?text=Alice',
                    ), // Placeholder
                    backgroundColor: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _rider['name'],
                    style: GoogleFonts.lexend(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'ID: ${_rider['id']}',
                    style: GoogleFonts.lexend(color: Colors.white70),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.qr_code_2, size: 80, color: Colors.black),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Scan to Board',
                    style: GoogleFonts.lexend(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Route Details
            _buildDetailSection(
              'Route Information',
              Icons.map,
              surfaceColor,
              textColor,
              [
                _buildInfoRow('Route Name', _rider['route'], textColor),
                _buildInfoRow('Bus Number', _rider['busNo'], textColor),
                _buildInfoRow(
                  'Boarding Point',
                  _rider['boardingPoint'],
                  textColor,
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildDetailSection(
              'Schedule',
              Icons.schedule,
              surfaceColor,
              textColor,
              [
                _buildInfoRow(
                  'Morning Pickup',
                  _rider['pickupTime'],
                  textColor,
                ),
                _buildInfoRow('Evening Drop', _rider['dropTime'], textColor),
              ],
            ),
            const SizedBox(height: 16),
            _buildDetailSection(
              'Driver Contact',
              Icons.person_pin,
              surfaceColor,
              textColor,
              [
                _buildInfoRow('Driver Name', _rider['driver'], textColor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Phone', style: TextStyle(color: Colors.grey)),
                    Row(
                      children: [
                        Text(
                          _rider['driverPhone'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(Icons.call, color: AppColors.success, size: 20),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 40),
            PrimaryButton(
              label: 'Track Bus Live',
              onPressed: () {}, // Navigate to map
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(
    String title,
    IconData icon,
    Color surfaceColor,
    Color textColor,
    List<Widget> children,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.lexend(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: textColor,
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          ...children.map(
            (w) =>
                Padding(padding: const EdgeInsets.only(bottom: 12), child: w),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, Color textColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
          ),
        ),
      ],
    );
  }
}
