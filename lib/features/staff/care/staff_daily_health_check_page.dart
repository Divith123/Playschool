import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';
import 'package:playschool/widgets/student_card.dart';

class StaffDailyHealthCheckPage extends StatefulWidget {
  const StaffDailyHealthCheckPage({super.key});

  @override
  State<StaffDailyHealthCheckPage> createState() =>
      _StaffDailyHealthCheckPageState();
}

class _StaffDailyHealthCheckPageState extends State<StaffDailyHealthCheckPage> {
  final List<Map<String, dynamic>> _students = [
    {'name': 'Leo Das', 'status': 'Healthy', 'temp': 36.6},
    {'name': 'Sarah Smith', 'status': 'Pending', 'temp': 0.0},
    {'name': 'Mike Ross', 'status': 'Pending', 'temp': 0.0},
    {'name': 'Emily Clark', 'status': 'Sick', 'temp': 38.5},
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Morning Health Check',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: isDarkMode ? AppColors.textMainDark : AppColors.textMainLight,
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _students.length,
        itemBuilder: (context, index) {
          final student = _students[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: StudentCard(
              name: student['name'],
              grade: 'Class 2B',
              isDarkMode: isDarkMode,
              trailing: _buildHealthAction(student, isDarkMode),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: PrimaryButton(
          label: 'Submit Daily Report',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Health Report Submitted to Admin!'),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHealthAction(Map<String, dynamic> student, bool isDarkMode) {
    if (student['status'] == 'Pending') {
      return TextButton(
        onPressed: () => _showHealthDialog(student),
        child: Text(
          'Check Now',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      Color color = student['status'] == 'Healthy' ? Colors.green : Colors.red;
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.5)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              student['status'] == 'Healthy'
                  ? Icons.check_circle
                  : Icons.warning,
              size: 16,
              color: color,
            ),
            const SizedBox(width: 4),
            Text(
              '${student['status']} (${student['temp']}°C)',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    }
  }

  void _showHealthDialog(Map<String, dynamic> student) {
    double temp = 36.6;
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(
              'Check ${student['name']}',
              style: AppTextStyles.headingMedium(false),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Temperature: ${temp.toStringAsFixed(1)}°C',
                  style: AppTextStyles.headingLarge(false),
                ),
                Slider(
                  value: temp,
                  min: 35.0,
                  max: 40.0,
                  divisions: 50,
                  label: temp.toStringAsFixed(1),
                  activeColor: temp > 37.5 ? Colors.red : Colors.green,
                  onChanged: (val) => setState(() => temp = val),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSymptomChip('Cough', false),
                    _buildSymptomChip('Runny Nose', false),
                    _buildSymptomChip('Fatigue', true), // Mock selected
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              PrimaryButton(
                label: 'Save',
                width: 100,
                onPressed: () {
                  this.setState(() {
                    student['temp'] = double.parse(temp.toStringAsFixed(1));
                    student['status'] = temp > 37.5 ? 'Sick' : 'Healthy';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSymptomChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.red.withOpacity(0.2) : Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isSelected ? Colors.red : Colors.transparent),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.red : Colors.black,
          fontSize: 12,
        ),
      ),
    );
  }
}
