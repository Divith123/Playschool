import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';

class StaffInternalChatPage extends StatefulWidget {
  const StaffInternalChatPage({super.key});

  @override
  State<StaffInternalChatPage> createState() => _StaffInternalChatPageState();
}

class _StaffInternalChatPageState extends State<StaffInternalChatPage> {
  final TextEditingController _msgController = TextEditingController();

  final List<Map<String, dynamic>> _messages = [
    {
      'sender': 'Sarah J.',
      'message': 'Can anyone cover my break at 10:15 AM?',
      'time': '09:45 AM',
      'isMe': false,
      'avatar': 'https://placehold.co/100x100/png?text=S',
      'role': 'Teacher',
    },
    {
      'sender': 'Mike R.',
      'message': 'I can! I\'m free until 10:45.',
      'time': '09:48 AM',
      'isMe': false,
      'avatar': 'https://placehold.co/100x100/png?text=M',
      'role': 'PE Coach',
    },
    {
      'sender': 'Me',
      'message': 'Great, thanks Mike! Also, Room 2 needs more wipes.',
      'time': '09:50 AM',
      'isMe': true,
      'avatar': 'https://placehold.co/100x100/png?text=Me',
      'role': 'Teacher',
    },
    {
      'sender': 'Front Desk',
      'message': 'Maintenance is handling the wipes request now.',
      'time': '09:52 AM',
      'isMe': false,
      'avatar': 'https://placehold.co/100x100/png?text=FD',
      'role': 'Admin',
    },
  ];

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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Staff Room Chat',
              style: AppTextStyles.headingMedium(
                isDarkMode,
              ).copyWith(fontSize: 18),
            ),
            Text(
              '12 Members Online',
              style: GoogleFonts.lexend(fontSize: 12, color: Colors.green),
            ),
          ],
        ),
        backgroundColor: surfaceColor,
        elevation: 1,
        leading: BackButton(color: textColor),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.info_outline, color: textColor),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessageBubble(
                  _messages[index],
                  isDarkMode,
                  textColor,
                  surfaceColor,
                );
              },
            ),
          ),
          _buildInputArea(isDarkMode, surfaceColor, textColor),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(
    Map<String, dynamic> msg,
    bool isDarkMode,
    Color textColor,
    Color surfaceColor,
  ) {
    final bool isMe = msg['isMe'];

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMe) ...[
            CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(msg['avatar']),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                if (!isMe)
                  Row(
                    children: [
                      Text(
                        msg['sender'],
                        style: GoogleFonts.lexend(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: textColor.withValues(alpha: 0.7),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '• ${msg['role']}',
                        style: GoogleFonts.lexend(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isMe ? AppColors.primary : surfaceColor,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: Radius.circular(isMe ? 16 : 0),
                      bottomRight: Radius.circular(isMe ? 0 : 16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    msg['message'],
                    style: GoogleFonts.lexend(
                      color: isMe ? Colors.white : textColor,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  msg['time'],
                  style: GoogleFonts.lexend(fontSize: 10, color: Colors.grey),
                ),
              ],
            ),
          ),
          if (isMe) ...[
            const SizedBox(width: 8),
            // My avatar logic could go here if needed, but standard is usually no avatar for 'me'
          ],
        ],
      ),
    );
  }

  Widget _buildInputArea(bool isDarkMode, Color surfaceColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.attach_file, color: Colors.grey),
          ),
          Expanded(
            child: TextField(
              controller: _msgController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              style: TextStyle(color: textColor),
            ),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            backgroundColor: AppColors.primary,
            mini: true,
            onPressed: () {
              if (_msgController.text.isNotEmpty) {
                setState(() {
                  _messages.add({
                    'sender': 'Me',
                    'message': _msgController.text,
                    'time': 'Now',
                    'isMe': true,
                    'avatar': 'https://placehold.co/100x100/png?text=Me',
                    'role': 'Teacher',
                  });
                  _msgController.clear();
                });
              }
            },
            child: const Icon(Icons.send, color: Colors.white, size: 18),
          ),
        ],
      ),
    );
  }
}
