import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';

class ParentHomeworkViewPage extends StatefulWidget {
  const ParentHomeworkViewPage({super.key});

  @override
  State<ParentHomeworkViewPage> createState() => _ParentHomeworkViewPageState();
}

class _ParentHomeworkViewPageState extends State<ParentHomeworkViewPage> {
  final List<Map<String, dynamic>> _tasks = [
    {
      'title': 'Draw your Family',
      'subject': 'Art',
      'due': 'Tomorrow',
      'isDone': false,
    },
    {
      'title': 'Alphabet Tracing (A-E)',
      'subject': 'English',
      'due': '15 Aug',
      'isDone': true,
    },
    {
      'title': 'Collect 5 Leaves',
      'subject': 'Science',
      'due': '18 Aug',
      'isDone': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Homework',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: isDarkMode ? AppColors.textMainDark : AppColors.textMainLight,
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _tasks.length,
        separatorBuilder: (ctx, i) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final task = _tasks[index];
          return _buildTaskCard(task, isDarkMode);
        },
      ),
    );
  }

  Widget _buildTaskCard(Map<String, dynamic> task, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDarkMode ? Colors.white10 : Colors.grey[200]!,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color:
                      (task['isDone'] ? AppColors.success : AppColors.primary)
                          .withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  task['isDone'] ? Icons.check_circle : Icons.book,
                  color: task['isDone'] ? Colors.green : AppColors.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task['title'],
                      style: AppTextStyles.headingMedium(
                        isDarkMode,
                      ).copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${task['subject']} • Due: ${task['due']}',
                      style: AppTextStyles.bodyMedium(isDarkMode),
                    ),
                  ],
                ),
              ),
              Checkbox(
                value: task['isDone'],
                activeColor: Colors.green,
                onChanged: (val) {
                  setState(() => task['isDone'] = val);
                },
              ),
            ],
          ),
          if (!task['isDone']) ...[
            const Divider(height: 24),
            InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Opening Camera...')),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primary),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt, color: AppColors.primary, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Upload Photo of Work',
                      style: AppTextStyles.buttonText.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
