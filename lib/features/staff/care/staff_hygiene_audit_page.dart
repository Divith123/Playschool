import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class StaffHygieneAuditPage extends StatefulWidget {
  const StaffHygieneAuditPage({super.key});

  @override
  State<StaffHygieneAuditPage> createState() => _StaffHygieneAuditPageState();
}

class _StaffHygieneAuditPageState extends State<StaffHygieneAuditPage> {
  final Map<String, bool?> _checklist = {
    'Classroom Floor Cleaned': null,
    'Toys Sanitized': null,
    'Trash Bins Emptied': null,
    'Hand Wash Station Stocked': null,
    'Nap Mats Disinfected': null,
  };

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hygiene Audit',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: isDarkMode ? AppColors.textMainDark : AppColors.textMainLight,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue[200]!),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: Colors.blue),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Complete this checklist before 10:00 AM daily.',
                    style: TextStyle(color: Colors.blue[900]),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ..._checklist.keys
              .map((item) => _buildChecklistItem(item, isDarkMode))
              ,
          const SizedBox(height: 32),
          PrimaryButton(
            label: 'Submit Audit Log',
            icon: Icons.upload_file,
            onPressed: () {
              bool allChecked = !_checklist.containsValue(null);
              if (allChecked) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Hygiene Audit Submitted!')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please complete all items.')),
                );
              }
            },
            width: double.infinity,
          ),
        ],
      ),
    );
  }

  Widget _buildChecklistItem(String item, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: Text(item, style: AppTextStyles.bodyLarge(isDarkMode)),
          ),
          _buildOptionBtn(item, true),
          const SizedBox(width: 12),
          _buildOptionBtn(item, false),
        ],
      ),
    );
  }

  Widget _buildOptionBtn(String item, bool isYes) {
    bool? currentVal = _checklist[item];
    bool isSelected = currentVal == isYes;
    Color color = isYes ? Colors.green : Colors.red;

    return InkWell(
      onTap: () => setState(() => _checklist[item] = isYes),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isSelected ? color : Colors.grey[400]!),
        ),
        child: Text(
          isYes ? 'YES' : 'NO',
          style: TextStyle(
            color: isSelected ? color : Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
