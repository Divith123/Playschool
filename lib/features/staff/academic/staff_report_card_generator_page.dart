import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class StaffReportCardGeneratorPage extends StatefulWidget {
  const StaffReportCardGeneratorPage({super.key});

  @override
  State<StaffReportCardGeneratorPage> createState() =>
      _StaffReportCardGeneratorPageState();
}

class _StaffReportCardGeneratorPageState
    extends State<StaffReportCardGeneratorPage> {
  final Map<String, int> _scores = {
    'Cognitive Development': 3,
    'Physical Development': 4,
    'Social Skills': 2,
    'Language Skills': 3,
  };

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Report Card: Leo Das',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: isDarkMode ? AppColors.textMainDark : AppColors.textMainLight,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ..._scores.keys
                .map((skill) => _buildRubricSlider(skill, isDarkMode))
                .toList(),
            const SizedBox(height: 24),
            _buildTextField('Teacher\'s Comments', isDarkMode, maxLines: 5),
            const SizedBox(height: 32),
            PrimaryButton(
              label: 'Publish Report',
              width: double.infinity,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Report Card Published!')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRubricSlider(String skill, bool isDarkMode) {
    int value = _scores[skill]!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              skill,
              style: AppTextStyles.bodyLarge(
                isDarkMode,
              ).copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              _getLabel(value),
              style: TextStyle(
                color: _getColor(value),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Slider(
          value: value.toDouble(),
          min: 1,
          max: 4,
          divisions: 3,
          activeColor: _getColor(value),
          onChanged: (val) => setState(() => _scores[skill] = val.toInt()),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  String _getLabel(int value) {
    switch (value) {
      case 1:
        return 'Needs Support';
      case 2:
        return 'Developing';
      case 3:
        return 'Good';
      case 4:
        return 'Excellent';
      default:
        return '';
    }
  }

  Color _getColor(int value) {
    switch (value) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.blue;
      case 4:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Widget _buildTextField(String label, bool isDarkMode, {int maxLines = 1}) {
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
          maxLines: maxLines,
          style: AppTextStyles.bodyLarge(isDarkMode),
          decoration: InputDecoration(
            hintText: 'Enter detailed feedback...',
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
