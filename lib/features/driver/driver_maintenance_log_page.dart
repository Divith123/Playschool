import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class DriverMaintenanceLogPage extends StatefulWidget {
  const DriverMaintenanceLogPage({super.key});

  @override
  State<DriverMaintenanceLogPage> createState() =>
      _DriverMaintenanceLogPageState();
}

class _DriverMaintenanceLogPageState extends State<DriverMaintenanceLogPage> {
  double _fuelLevel = 0.75;
  final TextEditingController _odometerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Vehicle Check',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: isDarkMode ? AppColors.textMainDark : AppColors.textMainLight,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bus #12 - Ford Transit',
              style: AppTextStyles.headingLarge(isDarkMode),
            ),
            const SizedBox(height: 32),

            // Odometer
            _buildTextField(
              'Current Odometer Reading (km)',
              _odometerController,
              isDarkMode,
            ),
            const SizedBox(height: 32),

            // Fuel Level
            Text(
              'Fuel Level',
              style: AppTextStyles.bodyMedium(
                isDarkMode,
              ).copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.local_gas_station, color: Colors.grey),
                Expanded(
                  child: Slider(
                    value: _fuelLevel,
                    onChanged: (val) => setState(() => _fuelLevel = val),
                    divisions: 4,
                    label: '${(_fuelLevel * 100).toInt()}%',
                    activeColor: _fuelLevel < 0.25 ? Colors.red : Colors.green,
                  ),
                ),
                Text(
                  '${(_fuelLevel * 100).toInt()}%',
                  style: AppTextStyles.headingMedium(isDarkMode),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Checklist
            Text(
              'Is everything working?',
              style: AppTextStyles.bodyMedium(
                isDarkMode,
              ).copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildCheckItem('Brakes', true, isDarkMode),
            _buildCheckItem('Lights & Indicators', true, isDarkMode),
            _buildCheckItem('Tires Pressure', true, isDarkMode),
            _buildCheckItem('First Aid Kit', true, isDarkMode),
            _buildCheckItem('Oil Level', false, isDarkMode), // Example issue

            const SizedBox(height: 32),
            PrimaryButton(
              label: 'Submit Daily Log',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Maintenance Log Submitted!')),
                );
              },
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckItem(String label, bool isOk, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.bodyLarge(isDarkMode)),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.check_circle,
                  color: isOk ? Colors.green : Colors.grey[300],
                ),
                onPressed: () {}, // Toggle logic here
              ),
              IconButton(
                icon: Icon(
                  Icons.warning,
                  color: !isOk ? Colors.red : Colors.grey[300],
                ),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    bool isDarkMode,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium(
            isDarkMode,
          ).copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: AppTextStyles.bodyLarge(isDarkMode),
          decoration: InputDecoration(
            hintText: 'e.g., 45021',
            filled: true,
            fillColor: isDarkMode
                ? AppColors.surfaceDark
                : AppColors.surfaceLight,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDarkMode ? Colors.white10 : Colors.grey[300]!,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDarkMode ? Colors.white10 : Colors.grey[300]!,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
