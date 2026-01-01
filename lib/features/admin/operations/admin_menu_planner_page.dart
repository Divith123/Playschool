import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class AdminMenuPlannerPage extends StatefulWidget {
  const AdminMenuPlannerPage({super.key});

  @override
  State<AdminMenuPlannerPage> createState() => _AdminMenuPlannerPageState();
}

class _AdminMenuPlannerPageState extends State<AdminMenuPlannerPage> {
  final List<String> _days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];
  String _selectedDay = 'Monday';

  // Mock Data
  final Map<String, List<String>> _menu = {
    'Monday': ['Oatmeal', 'Chicken Rice', 'Apple Slices'],
    'Tuesday': ['Pancakes', 'Pasta', 'Banana'],
    'Wednesday': ['Cereal', 'Fish & Chips', 'Orange'],
    'Thursday': ['Toast', 'Sandwich', 'Grapes'],
    'Friday': ['Eggs', 'Pizza', 'Watermelon'],
  };

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Weekly Meal Planner',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: isDarkMode ? AppColors.textMainDark : AppColors.textMainLight,
        ),
      ),
      body: Column(
        children: [
          // Day Selector
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _days.length,
              itemBuilder: (context, index) {
                final day = _days[index];
                final isSelected = day == _selectedDay;
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: FilterChip(
                    label: Text(day),
                    selected: isSelected,
                    onSelected: (val) => setState(() => _selectedDay = day),
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : (isDarkMode ? Colors.white : Colors.black),
                    ),
                  ),
                );
              },
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildMealSection(
                  'Breakfast',
                  _menu[_selectedDay]![0],
                  isDarkMode,
                ),
                _buildMealSection('Lunch', _menu[_selectedDay]![1], isDarkMode),
                _buildMealSection('Snack', _menu[_selectedDay]![2], isDarkMode),

                const SizedBox(height: 32),
                PrimaryButton(
                  label: 'Publish to Parents',
                  icon: Icons.publish,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Menu Published Successfully!'),
                      ),
                    );
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

  Widget _buildMealSection(String type, String item, bool isDarkMode) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  type,
                  style: AppTextStyles.headingMedium(
                    isDarkMode,
                  ).copyWith(fontSize: 18, color: AppColors.primary),
                ),
                IconButton(
                  icon: Icon(Icons.edit, size: 20, color: Colors.grey),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(item, style: AppTextStyles.bodyLarge(isDarkMode)),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildTag('Nut-Free', Colors.green),
                const SizedBox(width: 8),
                _buildTag('Dairy-Free Option', Colors.blue),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
