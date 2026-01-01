import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class StaffLeaveApplyPage extends StatefulWidget {
  const StaffLeaveApplyPage({super.key});

  @override
  State<StaffLeaveApplyPage> createState() => _StaffLeaveApplyPageState();
}

class _StaffLeaveApplyPageState extends State<StaffLeaveApplyPage> {
  String _leaveType = 'Sick Leave';
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Apply for Leave',
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
            _buildDropdown('Leave Type', [
              'Sick Leave',
              'Casual Leave',
              'Emergency',
            ], isDarkMode),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildDatePicker(
                    'From',
                    _startDate,
                    (d) => setState(() => _startDate = d),
                    isDarkMode,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildDatePicker(
                    'To',
                    _endDate,
                    (d) => setState(() => _endDate = d),
                    isDarkMode,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildTextField('Reason for Leave', isDarkMode, maxLines: 4),
            const SizedBox(height: 16),

            // Balance Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildBalanceItem('Sick', '5/10 Left'),
                  _buildBalanceItem('Casual', '2/12 Left'),
                ],
              ),
            ),

            const SizedBox(height: 32),
            PrimaryButton(
              label: 'Submit Request',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Leave Request Submitted!')),
                );
                Navigator.pop(context);
              },
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, bool isDarkMode) {
    return DropdownButtonFormField<String>(
      value: _leaveType,
      items: items
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: (val) => setState(() => _leaveType = val!),
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      dropdownColor: isDarkMode
          ? AppColors.surfaceDark
          : AppColors.surfaceLight,
    );
  }

  Widget _buildDatePicker(
    String label,
    DateTime date,
    Function(DateTime) onPick,
    bool isDarkMode,
  ) {
    return InkWell(
      onTap: () async {
        final d = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime.now(),
          lastDate: DateTime(2030),
        );
        if (d != null) onPick(d);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.transparent,
          ), // Match TextField border mostly
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: AppColors.primary),
                const SizedBox(width: 8),
                Text('${date.day}/${date.month}/${date.year}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, bool isDarkMode, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildBalanceItem(String type, String val) {
    return Column(
      children: [
        Text(
          val,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.blue[800],
          ),
        ),
        Text(type, style: TextStyle(fontSize: 12, color: Colors.blue[600])),
      ],
    );
  }
}
