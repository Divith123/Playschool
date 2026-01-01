import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class DriverRouteOptimizerPage extends StatefulWidget {
  const DriverRouteOptimizerPage({super.key});

  @override
  State<DriverRouteOptimizerPage> createState() =>
      _DriverRouteOptimizerPageState();
}

class _DriverRouteOptimizerPageState extends State<DriverRouteOptimizerPage> {
  final List<Map<String, dynamic>> _stops = [
    {'id': '1', 'name': 'Maple Ave (Smith)', 'time': '07:10 AM'},
    {'id': '2', 'name': 'Oak St (Johnson)', 'time': '07:25 AM'},
    {'id': '3', 'name': 'Pine Ln (Williams)', 'time': '07:40 AM'},
    {'id': '4', 'name': 'Elm Blvd (Brown)', 'time': '07:55 AM'},
    {'id': '5', 'name': 'School Gate', 'time': '08:15 AM'},
  ];

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
          'Route Optimizer',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
        actions: [
          TextButton.icon(
            onPressed: () {
              // Auto optimize logic
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('AI Optimization Complete!')),
              );
            },
            icon: Icon(Icons.flash_on, size: 18, color: AppColors.primary),
            label: Text(
              'Auto-Sort',
              style: TextStyle(color: AppColors.primary),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blue.withOpacity(0.1),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Drag and drop stops to re-order the route manually.',
                    style: GoogleFonts.lexend(color: textColor),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ReorderableListView(
              padding: const EdgeInsets.all(16),
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (newIndex > oldIndex) newIndex -= 1;
                  final item = _stops.removeAt(oldIndex);
                  _stops.insert(newIndex, item);
                });
              },
              children: [
                for (int index = 0; index < _stops.length; index++)
                  Container(
                    key: ValueKey(_stops[index]['id']),
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: surfaceColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(8),
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        _stops[index]['name'],
                        style: GoogleFonts.lexend(
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      subtitle: Text(
                        'Est: ${_stops[index]['time']}',
                        style: GoogleFonts.lexend(color: Colors.grey),
                      ),
                      trailing: const Icon(
                        Icons.drag_handle,
                        color: Colors.grey,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: PrimaryButton(
              label: 'Save New Route',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Route Sequence Updated!'),
                    backgroundColor: AppColors.success,
                  ),
                );
                Navigator.pop(context);
              },
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }
}
