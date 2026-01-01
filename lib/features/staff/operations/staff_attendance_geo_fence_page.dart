import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class StaffAttendanceGeoFencePage extends StatefulWidget {
  const StaffAttendanceGeoFencePage({super.key});

  @override
  State<StaffAttendanceGeoFencePage> createState() =>
      _StaffAttendanceGeoFencePageState();
}

class _StaffAttendanceGeoFencePageState
    extends State<StaffAttendanceGeoFencePage> {
  bool _isInsideRange = true; // Simulation
  bool _isCheckedIn = false;
  String _status = 'Detecting Location...';
  String _distance = 'Calculating...';

  @override
  void initState() {
    super.initState();
    // Simulate location check delay
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _status = 'Location Verified';
        _distance = '5 meters from gate';
        _isInsideRange = true;
      });
    });
  }

  void _handleClockAction() {
    setState(() {
      _isCheckedIn = !_isCheckedIn;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isCheckedIn ? 'Clocked In Successfully!' : 'Clocked Out!',
        ),
        backgroundColor: AppColors.success,
      ),
    );
  }

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
          'Geo-Fence Attendance',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
      ),
      body: Column(
        children: [
          // Map Placeholder
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: Center(
                    child: Text(
                      'Map View Placeholder\n(Google Maps Integration)',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lexend(color: Colors.grey[600]),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.3),
                        width: 2,
                      ),
                      color: AppColors.primary.withOpacity(0.1),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.school,
                        size: 40,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Controls
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: _isInsideRange
                          ? AppColors.success.withOpacity(0.1)
                          : Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _isInsideRange ? Icons.check_circle : Icons.warning,
                          color: _isInsideRange
                              ? AppColors.success
                              : Colors.red,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _status,
                          style: GoogleFonts.lexend(
                            color: _isInsideRange
                                ? AppColors.success
                                : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _distance,
                    style: GoogleFonts.lexend(color: Colors.grey),
                  ),
                  const SizedBox(height: 32),
                  PrimaryButton(
                    label: _isCheckedIn ? 'Clock OUT' : 'Clock IN',
                    onPressed: _isInsideRange ? _handleClockAction : null,
                    width: 200,
                    height: 56,
                    fontSize: 18,
                    // Typically clock out color is red/warning
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'School starts at 08:30 AM',
                    style: GoogleFonts.lexend(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
