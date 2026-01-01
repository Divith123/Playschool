import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class DriverTripLogPage extends StatefulWidget {
  const DriverTripLogPage({super.key});

  @override
  State<DriverTripLogPage> createState() => _DriverTripLogPageState();
}

class _DriverTripLogPageState extends State<DriverTripLogPage> {
  final List<Map<String, dynamic>> _stops = [
    {'location': 'School Campus', 'time': '07:30 AM', 'status': 'Departed'},
    {'location': 'Greenwood Apts', 'time': '07:45 AM', 'status': 'Completed'},
    {'location': 'Oak Street', 'time': '08:00 AM', 'status': 'Pending'},
    {'location': 'Maples Residency', 'time': '08:15 AM', 'status': 'Pending'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Trip #492 (Morning)',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: isDarkMode ? AppColors.textMainDark : AppColors.textMainLight,
        ),
      ),
      body: Column(
        children: [
          // Header Stats
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.secondary, Colors.blue[800]!],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStat('Students', '12/15', Icons.people),
                _buildStat('ETA School', '08:30', Icons.timer),
                _buildStat('Distance', '4.5 km', Icons.directions_bus),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _stops.length,
              itemBuilder: (context, index) {
                final stop = _stops[index];
                final isCompleted =
                    stop['status'] == 'Completed' ||
                    stop['status'] == 'Departed';
                final isNext =
                    stop['status'] == 'Pending' &&
                    (index == 0 || _stops[index - 1]['status'] != 'Pending');

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: isCompleted
                                ? Colors.green
                                : (isNext ? Colors.orange : Colors.grey[300]),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                        if (index != _stops.length - 1)
                          Container(
                            width: 2,
                            height: 60,
                            color: Colors.grey[300],
                          ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 24),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? AppColors.surfaceDark
                              : AppColors.surfaceLight,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isNext ? Colors.orange : Colors.transparent,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  stop['location'],
                                  style: AppTextStyles.bodyLarge(
                                    isDarkMode,
                                  ).copyWith(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Scheduled: ${stop['time']}',
                                  style: AppTextStyles.bodyMedium(isDarkMode),
                                ),
                              ],
                            ),
                            if (isNext)
                              ElevatedButton(
                                onPressed: () {
                                  setState(() => stop['status'] = 'Completed');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text('Arrived'),
                              )
                            else if (stop['status'] == 'Completed')
                              const Icon(Icons.check, color: Colors.green),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: PrimaryButton(
              label: 'SOS / Emergency',
              icon: Icons.warning,
              width: double.infinity,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Emergency Alert Sent to Admin!'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }
}
