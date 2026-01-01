import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class AdminFuelLogPage extends StatefulWidget {
  const AdminFuelLogPage({super.key});

  @override
  State<AdminFuelLogPage> createState() => _AdminFuelLogPageState();
}

class _AdminFuelLogPageState extends State<AdminFuelLogPage> {
  final List<Map<String, dynamic>> _logs = [
    {
      'vehicle': 'Bus #1',
      'date': 'Oct 28',
      'liters': 45.0,
      'cost': 180.0,
      'odometer': 12050,
    },
    {
      'vehicle': 'Bus #2',
      'date': 'Oct 27',
      'liters': 50.0,
      'cost': 200.0,
      'odometer': 8500,
    },
    {
      'vehicle': 'Van #4',
      'date': 'Oct 25',
      'liters': 30.0,
      'cost': 120.0,
      'odometer': 4200,
    },
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
          'Fuel Tracking',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add log dialog
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.local_gas_station, color: Colors.white),
      ),
      body: Column(
        children: [
          // Filter Row
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: surfaceColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: 'All Vehicles',
                      underline: Container(),
                      dropdownColor: surfaceColor,
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                      items: ['All Vehicles', 'Bus #1', 'Bus #2', 'Van #4']
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                      onChanged: (val) {},
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Total: \$500.00',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Log List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _logs.length,
              separatorBuilder: (ctx, i) => const SizedBox(height: 12),
              itemBuilder: (ctx, i) {
                return _buildLogCard(
                  _logs[i],
                  surfaceColor,
                  textColor,
                  isDarkMode,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogCard(
    Map<String, dynamic> log,
    Color surfaceColor,
    Color textColor,
    bool isDarkMode,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.local_shipping,
                  color: Colors.orange,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    log['vehicle'],
                    style: GoogleFonts.lexend(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: textColor,
                    ),
                  ),
                  Text(
                    '${log['date']} • Odo: ${log['odometer']} km',
                    style: GoogleFonts.lexend(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${log['cost']}',
                style: GoogleFonts.lexend(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: textColor,
                ),
              ),
              Text(
                '${log['liters']} L',
                style: GoogleFonts.lexend(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
