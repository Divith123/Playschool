import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/features/common/app_settings_page.dart';
import 'package:playschool/features/driver/driver_trip_log_page.dart';
import 'package:playschool/features/driver/driver_maintenance_log_page.dart';
import 'package:playschool/features/driver/driver_route_detail_page.dart';
import 'package:playschool/features/driver/driver_route_optimizer_page.dart';
import 'package:playschool/features/driver/driver_vehicle_incident_page.dart';
import 'package:playschool/widgets/primary_button.dart';

class DriverDashboardPage extends StatefulWidget {
  const DriverDashboardPage({super.key});

  @override
  State<DriverDashboardPage> createState() => _DriverDashboardPageState();
}

class _DriverDashboardPageState extends State<DriverDashboardPage> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode
        ? AppColors.backgroundDark
        : AppColors.backgroundLight;
    final surfaceColor = isDarkMode
        ? AppColors.surfaceDark
        : AppColors.surfaceLight;
    final textColor = isDarkMode ? Colors.white : AppColors.textMainLight;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          'Driver Dashboard',
          style: AppTextStyles.headingLarge(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: textColor),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppSettingsPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDarkMode ? Colors.grey[800]! : Colors.grey[200]!,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.directions_bus,
                      color: AppColors.primary,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Vehicle: KA-01-AB-1234',
                        style: AppTextStyles.headingMedium(isDarkMode),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Status: On Route',
                        style: AppTextStyles.bodyMedium(isDarkMode).copyWith(
                          color: AppColors.success,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            Text(
              'Quick Actions',
              style: AppTextStyles.headingMedium(isDarkMode),
            ),
            const SizedBox(height: 16),

            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildActionCard(
                  context: context,
                  title: 'Trip Log',
                  icon: Icons.list_alt,
                  color: Colors.blue,
                  page: const DriverTripLogPage(),
                  isDarkMode: isDarkMode,
                ),
                _buildActionCard(
                  context: context,
                  title: 'Route Details',
                  icon: Icons.map,
                  color: Colors.green,
                  page: const DriverRouteDetailPage(),
                  isDarkMode: isDarkMode,
                ),
                _buildActionCard(
                  context: context,
                  title: 'Maintenance',
                  icon: Icons.build_circle_outlined,
                  color: Colors.orange,
                  page: const DriverMaintenanceLogPage(),
                  isDarkMode: isDarkMode,
                ),
                _buildActionCard(
                  context: context,
                  title: 'Report Incident',
                  icon: Icons.warning_amber_rounded,
                  color: Colors.red,
                  page: const DriverVehicleIncidentPage(),
                  isDarkMode: isDarkMode,
                ),
                _buildActionCard(
                  context: context,
                  title: 'Route Optimizer',
                  icon: Icons.alt_route,
                  color: Colors.purple,
                  page: const DriverRouteOptimizerPage(),
                  isDarkMode: isDarkMode,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color color,
    required Widget page,
    required bool isDarkMode,
  }) {
    return InkWell(
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDarkMode ? Colors.grey[800]! : Colors.grey[200]!,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyLarge(
                isDarkMode,
              ).copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
