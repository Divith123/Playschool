import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StaffLessonPlannerPage extends StatefulWidget {
  const StaffLessonPlannerPage({super.key});

  @override
  State<StaffLessonPlannerPage> createState() => _StaffLessonPlannerPageState();
}

class _StaffLessonPlannerPageState extends State<StaffLessonPlannerPage> {
  static const Color primary = Color(0xFF2bee6c);
  static const Color backgroundLight = Color(0xFFf6f8f6);
  static const Color backgroundDark = Color(0xFF102216);
  static const Color surfaceLight = Color(0xFFffffff);
  static const Color surfaceDark = Color(0xFF1a2c20);
  static const Color textMainLight = Color(0xFF0d1b12);
  static const Color textMainDark = Color(0xFFe0e7e3);
  static const Color textSubLight = Color(0xFF4e6d97);

  final List<String> _weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
  String _selectedDay = 'Mon';

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode ? backgroundDark : backgroundLight;
    final surfaceColor = isDarkMode ? surfaceDark : surfaceLight;
    final textColor = isDarkMode ? textMainDark : textMainLight;
    final subTextColor = isDarkMode ? Colors.grey[400] : textSubLight;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          'Lesson Planner',
          style: GoogleFonts.lexend(fontWeight: FontWeight.bold),
        ),
        backgroundColor: bgColor,
        foregroundColor: textColor,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.share), onPressed: () {}),
          IconButton(icon: const Icon(Icons.print), onPressed: () {}),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: primary,
        label: Text(
          'Add Activity',
          style: GoogleFonts.lexend(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        icon: const Icon(Icons.add, color: Colors.black),
      ),
      body: Column(
        children: [
          // Theme Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDarkMode
                    ? [const Color(0xFF1a2c20), const Color(0xFF102216)]
                    : [Colors.blue, Colors.purple],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Weekly Theme',
                  style: GoogleFonts.lexend(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Under the Sea 🌊',
                  style: GoogleFonts.lexend(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Week of Oct 24 - 28',
                  style: GoogleFonts.lexend(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Day Selector
          Container(
            height: 50,
            margin: const EdgeInsets.only(bottom: 16),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _weekDays.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final day = _weekDays[index];
                final isSelected = day == _selectedDay;
                return GestureDetector(
                  onTap: () => setState(() => _selectedDay = day),
                  child: Container(
                    width: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected ? primary : surfaceColor,
                      borderRadius: BorderRadius.circular(12),
                      border: isSelected
                          ? null
                          : Border.all(
                              color: Colors.grey.withValues(alpha: 0.2),
                            ),
                    ),
                    child: Text(
                      day,
                      style: GoogleFonts.lexend(
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.black : textColor,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Activities List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildTimeSlot(
                  '09:00 AM',
                  'Circle Time',
                  'Discussing ocean animals 🐳',
                  Colors.orange,
                  isDarkMode,
                  surfaceColor,
                  textColor,
                  subTextColor!,
                ),
                _buildTimeSlot(
                  '10:00 AM',
                  'Art & Craft',
                  'Jellyfish paper plate craft',
                  Colors.purple,
                  isDarkMode,
                  surfaceColor,
                  textColor,
                  subTextColor,
                ),
                _buildTimeSlot(
                  '11:00 AM',
                  'Sensory Play',
                  'Water bead ocean sensory bin',
                  Colors.blue,
                  isDarkMode,
                  surfaceColor,
                  textColor,
                  subTextColor,
                ),
                _buildTimeSlot(
                  '02:00 PM',
                  'Story Time',
                  'The Rainbow Fish',
                  Colors.green,
                  isDarkMode,
                  surfaceColor,
                  textColor,
                  subTextColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSlot(
    String time,
    String title,
    String desc,
    Color color,
    bool isDarkMode,
    Color surfaceColor,
    Color textColor,
    Color subTextColor,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Text(
              time,
              style: GoogleFonts.lexend(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: subTextColor,
              ),
            ),
            Container(
              width: 1,
              height: 80,
              color: Colors.grey.withValues(alpha: 0.2),
              margin: const EdgeInsets.symmetric(vertical: 4),
            ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(16),
              border: Border(left: BorderSide(color: color, width: 4)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.lexend(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: GoogleFonts.lexend(fontSize: 14, color: subTextColor),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.check_circle_outline, size: 14, color: color),
                    const SizedBox(width: 4),
                    Text(
                      'Ready',
                      style: GoogleFonts.lexend(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: color,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
