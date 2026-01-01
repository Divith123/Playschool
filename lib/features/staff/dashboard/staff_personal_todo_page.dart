import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';

class StaffPersonalTodoPage extends StatefulWidget {
  const StaffPersonalTodoPage({super.key});

  @override
  State<StaffPersonalTodoPage> createState() => _StaffPersonalTodoPageState();
}

class _StaffPersonalTodoPageState extends State<StaffPersonalTodoPage> {
  final List<Map<String, dynamic>> _tasks = [
    {
      'title': 'Prepare art supplies for Friday',
      'done': false,
      'priority': 'High',
    },
    {
      'title': 'Call Mrs. Robinson re: allergies',
      'done': true,
      'priority': 'Medium',
    },
    {
      'title': 'Submit leave request for next week',
      'done': false,
      'priority': 'Low',
    },
  ];

  final TextEditingController _taskController = TextEditingController();

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
          'My To-Do List',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
      ),
      body: Column(
        children: [
          // Input Area
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    style: TextStyle(color: textColor),
                    decoration: InputDecoration(
                      hintText: 'Add a new task...',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (_taskController.text.isNotEmpty) {
                      setState(() {
                        _tasks.insert(0, {
                          'title': _taskController.text,
                          'done': false,
                          'priority': 'Medium',
                        });
                        _taskController.clear();
                      });
                    }
                  },
                  icon: Icon(
                    Icons.add_circle,
                    color: AppColors.primary,
                    size: 40,
                  ),
                ),
              ],
            ),
          ),

          // List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _tasks.length,
              separatorBuilder: (ctx, i) => const SizedBox(height: 12),
              itemBuilder: (ctx, i) {
                final task = _tasks[i];
                return Dismissible(
                  key: ValueKey(task['title']),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (dir) {
                    setState(() {
                      _tasks.removeAt(i);
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: surfaceColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Checkbox(
                          value: task['done'],
                          activeColor: AppColors.primary,
                          onChanged: (val) {
                            setState(() {
                              task['done'] = val;
                            });
                          },
                        ),
                        Expanded(
                          child: Text(
                            task['title'],
                            style: GoogleFonts.lexend(
                              fontSize: 16,
                              color: textColor,
                              decoration: task['done']
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                        ),
                        _buildPriorityDot(task['priority']),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriorityDot(String priority) {
    Color color;
    switch (priority) {
      case 'High':
        color = Colors.red;
        break;
      case 'Medium':
        color = Colors.orange;
        break;
      default:
        color = Colors.green;
    }
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
