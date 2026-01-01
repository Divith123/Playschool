import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';
import 'package:playschool/widgets/status_badge.dart';

class ParentSlotBookingPage extends StatefulWidget {
  const ParentSlotBookingPage({super.key});

  @override
  State<ParentSlotBookingPage> createState() => _ParentSlotBookingPageState();
}

class _ParentSlotBookingPageState extends State<ParentSlotBookingPage> {
  DateTime _selectedDate = DateTime.now();
  String? _selectedSlot;
  String _meetingType = 'Class Teacher'; // or Principal

  final Map<String, List<String>> _slots = {
    'Morning': ['09:00 AM', '09:30 AM', '10:00 AM', '11:30 AM'],
    'Afternoon': ['14:00 PM', '14:30 PM', '15:30 PM'],
  };

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
          'Book Meeting Appointment',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Who to meet
            Text(
              'Who do you want to meet?',
              style: GoogleFonts.lexend(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildTypeCard(
                    'Class Teacher',
                    Icons.person,
                    _meetingType == 'Class Teacher',
                    surfaceColor,
                    textColor,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTypeCard(
                    'Principal',
                    Icons.school,
                    _meetingType == 'Principal',
                    surfaceColor,
                    textColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Date Picker (Horizontal simulated)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Date',
                  style: GoogleFonts.lexend(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final d = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 30)),
                    );
                    if (d != null) setState(() => _selectedDate = d);
                  },
                  icon: Icon(Icons.calendar_month, color: AppColors.primary),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 80,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                separatorBuilder: (ctx, i) => const SizedBox(width: 12),
                itemBuilder: (ctx, i) {
                  final date = DateTime.now().add(Duration(days: i));
                  final isSelected =
                      date.day == _selectedDate.day &&
                      date.month == _selectedDate.month;
                  return InkWell(
                    onTap: () => setState(() => _selectedDate = date),
                    child: Container(
                      width: 60,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : surfaceColor,
                        borderRadius: BorderRadius.circular(16),
                        border: isSelected
                            ? null
                            : Border.all(color: Colors.grey.withOpacity(0.2)),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.4),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _getWeekday(date.weekday),
                            style: GoogleFonts.lexend(
                              fontSize: 12,
                              color: isSelected ? Colors.white : Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${date.day}',
                            style: GoogleFonts.lexend(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Slots
            if (_meetingType == 'Principal' && _selectedDate.weekday > 5)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      Icon(Icons.block, size: 48, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text(
                        'Principal is not available on weekends.',
                        style: TextStyle(color: textColor),
                      ),
                    ],
                  ),
                ),
              )
            else ...[
              _buildSlotSection(
                'Morning Slots',
                _slots['Morning']!,
                surfaceColor,
                textColor,
              ),
              const SizedBox(height: 24),
              _buildSlotSection(
                'Afternoon Slots',
                _slots['Afternoon']!,
                surfaceColor,
                textColor,
              ),
            ],

            const SizedBox(height: 40),
            PrimaryButton(
              label: 'Confirm Booking',
              onPressed: _selectedSlot == null
                  ? null
                  : () {
                      _showBookingConfirmation(
                        context,
                        surfaceColor,
                        textColor,
                      );
                    },
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeCard(
    String label,
    IconData icon,
    bool isSelected,
    Color surfaceColor,
    Color textColor,
  ) {
    return InkWell(
      onTap: () => setState(() => _meetingType = label),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.1) : surfaceColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: isSelected ? AppColors.primary : Colors.grey,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: GoogleFonts.lexend(
                fontWeight: FontWeight.bold,
                color: isSelected ? AppColors.primary : textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlotSection(
    String title,
    List<String> slots,
    Color surfaceColor,
    Color textColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.lexend(
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: slots.map((slot) {
            final isSelected = _selectedSlot == slot;
            return InkWell(
              onTap: () => setState(() => _selectedSlot = slot),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : surfaceColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : Colors.grey.withOpacity(0.3),
                  ),
                ),
                child: Text(
                  slot,
                  style: GoogleFonts.lexend(
                    color: isSelected ? Colors.white : textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  String _getWeekday(int day) {
    switch (day) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  void _showBookingConfirmation(
    BuildContext context,
    Color surfaceColor,
    Color textColor,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: surfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Column(
          children: [
            Icon(Icons.check_circle, color: AppColors.success, size: 60),
            const SizedBox(height: 16),
            Text('Booking Confirmed!', style: TextStyle(color: textColor)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Your meeting with $_meetingType is scheduled.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: textColor,
                    ),
                  ),
                  Text(
                    _selectedSlot!,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx); // Close Dialog
              Navigator.pop(context); // Close Page
            },
            child: Text('Done', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }
}
