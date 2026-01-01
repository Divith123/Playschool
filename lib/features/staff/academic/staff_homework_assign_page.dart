import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class StaffHomeworkAssignPage extends StatefulWidget {
  const StaffHomeworkAssignPage({super.key});

  @override
  State<StaffHomeworkAssignPage> createState() =>
      _StaffHomeworkAssignPageState();
}

class _StaffHomeworkAssignPageState extends State<StaffHomeworkAssignPage> {
  String _selectedRecipient = 'Whole Class';
  DateTime _dueDate = DateTime.now().add(const Duration(days: 2));

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Assign Homework',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField('Homework Title', isDarkMode),
            const SizedBox(height: 16),
            _buildTextField('Instructions', isDarkMode, maxLines: 5),
            const SizedBox(height: 16),

            // Recipient Selector
            Text(
              'Assign To',
              style: AppTextStyles.bodyMedium(
                isDarkMode,
              ).copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? AppColors.surfaceDark
                    : AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDarkMode ? Colors.white10 : Colors.grey[300]!,
                ),
              ),
              child: ListTile(
                title: Text(
                  _selectedRecipient,
                  style: AppTextStyles.bodyLarge(isDarkMode),
                ),
                trailing: Icon(
                  Icons.arrow_drop_down,
                  color: isDarkMode ? Colors.white : Colors.grey,
                ),
                onTap: () {
                  // Mock selector
                  setState(
                    () =>
                        _selectedRecipient = _selectedRecipient == 'Whole Class'
                        ? 'Leo Das'
                        : 'Whole Class',
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // Date Picker
            Text(
              'Due Date',
              style: AppTextStyles.bodyMedium(
                isDarkMode,
              ).copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? AppColors.surfaceDark
                    : AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDarkMode ? Colors.white10 : Colors.grey[300]!,
                ),
              ),
              child: ListTile(
                leading: Icon(Icons.calendar_today, color: AppColors.primary),
                title: Text(
                  '${_dueDate.day}/${_dueDate.month}/${_dueDate.year}',
                  style: AppTextStyles.bodyLarge(isDarkMode),
                ),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _dueDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 30)),
                  );
                  if (date != null) setState(() => _dueDate = date);
                },
              ),
            ),
            const SizedBox(height: 16),

            // Attachment
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.white10 : Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDarkMode ? Colors.white24 : Colors.grey[300]!,
                  style: BorderStyle.solid,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.attach_file, size: 32, color: Colors.grey),
                  const SizedBox(height: 4),
                  Text(
                    'Attach Worksheet (PDF/Image)',
                    style: AppTextStyles.bodyMedium(isDarkMode),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
            PrimaryButton(
              label: 'Assign Task',
              icon: Icons.check,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Homework Assigned!')),
                );
              },
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
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
