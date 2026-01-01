import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';

class AdminKioskAnalyticsPage extends StatefulWidget {
  const AdminKioskAnalyticsPage({super.key});

  @override
  State<AdminKioskAnalyticsPage> createState() =>
      _AdminKioskAnalyticsPageState();
}

class _AdminKioskAnalyticsPageState extends State<AdminKioskAnalyticsPage> {
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
          'Kiosk Analytics',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Traffic Overview (Today)',
              style: GoogleFonts.lexend(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildInsightCard(
                  'Peak Hour',
                  '08:00 - 08:30',
                  Icons.access_time,
                  Colors.purple,
                  surfaceColor,
                  textColor,
                ),
                const SizedBox(width: 16),
                _buildInsightCard(
                  'Avg Check-in',
                  '12 secs',
                  Icons.speed,
                  Colors.orange,
                  surfaceColor,
                  textColor,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildInsightCard(
                  'Total Check-ins',
                  '145',
                  Icons.login,
                  Colors.green,
                  surfaceColor,
                  textColor,
                ),
                const SizedBox(width: 16),
                _buildInsightCard(
                  'Late Arrivals',
                  '8',
                  Icons.warning_amber,
                  Colors.red,
                  surfaceColor,
                  textColor,
                ),
              ],
            ),

            const SizedBox(height: 32),
            Text(
              'Hourly Traffic Distribution',
              style: GoogleFonts.lexend(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 200,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildBar('7AM', 20, Colors.blue),
                  _buildBar('8AM', 90, Colors.blue),
                  _buildBar('9AM', 30, Colors.blue),
                  _buildBar('10AM', 5, Colors.blue),
                  _buildBar('12PM', 60, Colors.orange), // Pickup
                  _buildBar('1PM', 40, Colors.orange),
                ],
              ),
            ),

            const SizedBox(height: 32),
            Text(
              'Device Status',
              style: GoogleFonts.lexend(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 12),
            _buildDeviceRow(
              'Main Gate Kiosk #1',
              'Online',
              '85% Battery',
              surfaceColor,
              textColor,
            ),
            const SizedBox(height: 8),
            _buildDeviceRow(
              'Main Gate Kiosk #2',
              'Online',
              '92% Battery',
              surfaceColor,
              textColor,
            ),
            const SizedBox(height: 8),
            _buildDeviceRow(
              'Reception Tablet',
              'Offline',
              '-',
              surfaceColor,
              textColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightCard(
    String title,
    String value,
    IconData icon,
    Color color,
    Color surfaceColor,
    Color textColor,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: GoogleFonts.lexend(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            Text(
              title,
              style: GoogleFonts.lexend(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBar(String label, int pct, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 20,
          height: (pct / 100) * 140, // Scale to height
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.lexend(fontSize: 10, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildDeviceRow(
    String name,
    String status,
    String battery,
    Color surfaceColor,
    Color textColor,
  ) {
    bool isOnline = status == 'Online';
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                isOnline ? Icons.tablet_mac : Icons.phonelink_erase,
                color: isOnline ? AppColors.success : Colors.grey,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  Text(
                    status,
                    style: TextStyle(
                      color: isOnline ? AppColors.success : Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(battery, style: TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}
