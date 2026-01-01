import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class AdminRoomBookingCalendarPage extends StatefulWidget {
  const AdminRoomBookingCalendarPage({super.key});

  @override
  State<AdminRoomBookingCalendarPage> createState() =>
      _AdminRoomBookingCalendarPageState();
}

class _AdminRoomBookingCalendarPageState
    extends State<AdminRoomBookingCalendarPage> {
  DateTime _selectedDate = DateTime.now();
  String _selectedRoom = 'AV Room';

  // Mock time slots
  final Map<String, String> _slots = {
    '09:00 AM': 'Available',
    '10:00 AM': 'Booked (Grade 1)',
    '11:00 AM': 'Available',
    '12:00 PM': 'Available',
    '01:00 PM': 'Booked (Staff Meeting)',
    '02:00 PM': 'Available',
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
          'Room Booking',
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
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildRoomChip('AV Room', true),
                _buildRoomChip('Playground', false),
                _buildRoomChip('Conf Room', false),
                _buildRoomChip('Comp Lab', false),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Date Selector (Simplified)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_back_ios, size: 16, color: textColor),
                ),
                Text(
                  'Today, Oct 30',
                  style: GoogleFonts.lexend(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Time Slots
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _slots.length,
              itemBuilder: (context, index) {
                String time = _slots.keys.elementAt(index);
                String status = _slots.values.elementAt(index);
                bool isBooked = status != 'Available';

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isBooked
                          ? Colors.red.withOpacity(0.3)
                          : AppColors.success.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        time,
                        style: GoogleFonts.lexend(
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      if (isBooked)
                        Text(
                          status, // Shows who booked it
                          style: GoogleFonts.lexend(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        )
                      else
                        ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Room booked successfully!'),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                          ),
                          child: const Text(
                            'Book',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomChip(String label, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        selectedColor: AppColors.primary,
        labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.grey),
        onSelected: (val) {},
      ),
    );
  }
}
