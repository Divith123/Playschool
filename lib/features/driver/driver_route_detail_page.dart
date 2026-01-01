import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';

class DriverRouteDetailPage extends StatelessWidget {
  const DriverRouteDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Route R-12 Details',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: isDarkMode ? AppColors.textMainDark : AppColors.textMainLight,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.map,
              color: isDarkMode
                  ? AppColors.textMainDark
                  : AppColors.textMainLight,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background Map Placeholder
          Container(
            color: Colors.grey[300],
            child: Center(
              child: Text(
                'Map View Placeholder',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
          ),

          // Draggable Scrollable Sheet for Stops
          DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.2,
            maxChildSize: 0.8,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? AppColors.backgroundDark
                      : AppColors.backgroundLight,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  boxShadow: [BoxShadow(blurRadius: 20, color: Colors.black26)],
                ),
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(24),
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        color: Colors.grey[400],
                        margin: const EdgeInsets.only(bottom: 24),
                      ),
                    ),
                    Text(
                      'Morning Pickup Route',
                      style: AppTextStyles.headingLarge(isDarkMode),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Total Distance: 12 km • Est. Time: 45 min',
                      style: AppTextStyles.bodyMedium(isDarkMode),
                    ),
                    const SizedBox(height: 24),

                    _buildStep(
                      1,
                      'Greenwood Apts',
                      '3 Students',
                      '07:45 AM',
                      isFirst: true,
                      isDarkMode: isDarkMode,
                    ),
                    _buildStep(
                      2,
                      'Oak Street',
                      '1 Student',
                      '08:00 AM',
                      isDarkMode: isDarkMode,
                    ),
                    _buildStep(
                      3,
                      'Maples Residency',
                      '4 Students',
                      '08:15 AM',
                      isDarkMode: isDarkMode,
                    ),
                    _buildStep(
                      4,
                      'School Campus',
                      'Drop-off',
                      '08:30 AM',
                      isLast: true,
                      isDarkMode: isDarkMode,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Start Navigation'),
        icon: const Icon(Icons.navigation),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  Widget _buildStep(
    int number,
    String location,
    String detail,
    String time, {
    bool isFirst = false,
    bool isLast = false,
    required bool isDarkMode,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$number',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            if (!isLast)
              Container(width: 2, height: 50, color: Colors.grey[300]),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                location,
                style: AppTextStyles.headingMedium(
                  isDarkMode,
                ).copyWith(fontSize: 16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(detail, style: AppTextStyles.bodyMedium(isDarkMode)),
                  Text(
                    time,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24), // Spacer
            ],
          ),
        ),
      ],
    );
  }
}
