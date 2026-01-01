import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class StaffCleaningChecklistPage extends StatefulWidget {
  const StaffCleaningChecklistPage({super.key});

  @override
  State<StaffCleaningChecklistPage> createState() =>
      _StaffCleaningChecklistPageState();
}

class _StaffCleaningChecklistPageState
    extends State<StaffCleaningChecklistPage> {
  final List<Map<String, dynamic>> _tasks = [
    {'task': 'Sanitize Door Handles', 'isDone': true},
    {'task': 'Mop Floors', 'isDone': true},
    {'task': 'Empty Trash Bins', 'isDone': false},
    {'task': 'Wipe Tables', 'isDone': false},
    {'task': 'Clean Whiteboard', 'isDone': false},
  ];

  String _selectedRoom = 'Classroom 1A';

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
          'Cleaning Log',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
      ),
      body: Column(
        children: [
          // Room Selector
          Container(
            padding: const EdgeInsets.all(16),
            color: surfaceColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Area:',
                  style: GoogleFonts.lexend(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                DropdownButton<String>(
                  value: _selectedRoom,
                  dropdownColor: surfaceColor,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                  underline: Container(),
                  items: ['Classroom 1A', 'Washrooms', 'Cafeteria', 'Play Area']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (val) => setState(() => _selectedRoom = val!),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Checklist
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _tasks.length,
              separatorBuilder: (ctx, i) => const Divider(),
              itemBuilder: (ctx, i) {
                final task = _tasks[i];
                return CheckboxListTile(
                  title: Text(
                    task['task'],
                    style: GoogleFonts.lexend(
                      color: textColor,
                      decoration: task['isDone']
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  value: task['isDone'],
                  activeColor: AppColors.success,
                  onChanged: (val) {
                    setState(() {
                      task['isDone'] = val;
                    });
                  },
                );
              },
            ),
          ),

          // Submit
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                TextField(
                  style: TextStyle(color: textColor),
                  decoration: InputDecoration(
                    hintText: 'Notes (e.g. Broken soap dispenser)',
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: surfaceColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  label: 'Submit Log',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Cleaning Log Submitted!'),
                        backgroundColor: AppColors.success,
                      ),
                    );
                    Navigator.pop(context);
                  },
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
