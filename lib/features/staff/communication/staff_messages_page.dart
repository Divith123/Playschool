import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StaffMessagesPage extends StatelessWidget {
  const StaffMessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode
        ? const Color(0xFF102216)
        : const Color(0xFFf6f8f6);
    final textColor = isDarkMode ? Colors.white : const Color(0xFF0d1b12);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          'Messages',
          style: GoogleFonts.lexend(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: bgColor,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 64,
              color: textColor.withOpacity(0.2),
            ),
            const SizedBox(height: 16),
            Text(
              'No new messages',
              style: GoogleFonts.lexend(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
