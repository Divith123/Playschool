import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/features/parent/communication/parent_chat_page.dart';

class ParentMessagesPage extends StatefulWidget {
  const ParentMessagesPage({super.key});

  @override
  State<ParentMessagesPage> createState() => _ParentMessagesPageState();
}

class _ParentMessagesPageState extends State<ParentMessagesPage> {
  // Mock data for chats
  final List<Map<String, dynamic>> chats = [
    {
      'name': 'Ms. Sarah',
      'role': 'Class Teacher',
      'message':
          "Hi! Just wanted to share a photo of Leo painting today. He's doing great!",
      'time': '10:41 AM',
      'unread': 2,
      'avatar':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAt5z0wJafXCp49FJqYXuFgVqgAjjsjVZzrFegoXNczgoFXEpq149MaaEU01viBAqQhyISVgseCJUeGEcp-by_fBlqE8lqha2JyDHahJUoce-2kKCllHC6w4-bTvZ88AK6ifk_RCxnuKuq6Lna2h5nKJ19LiHhJadEGA2S6-8V8W89Vxceo5nKJB5ToZR3m-vwlJUM1A-7L3XLvIzGxYXibdNDgUEH2mfJerF9oUCTt0id3ooSjn4ZFcOuXl0zgmxRAbLwSWPyvEas',
      'isOnline': true,
    },
    {
      'name': 'Mr. David',
      'role': 'Admin',
      'message': 'Fee payment reminder for January.',
      'time': 'Yesterday',
      'unread': 0,
      'avatar':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAB6AXuAB6AXuAB6AXuAB6AXuAB6AXuAB6AXuAB6AXuAB6AXuAB6AXuAB6AXuAB6AXuAB6AXuAB6AXuAB6AXuAB6AXu', // placeholder
      'isOnline': false,
    },
    {
      'name': 'Class 2B Parents',
      'role': 'Group',
      'message': 'Alice: Does anyone have the homework sheet?',
      'time': '9:30 AM',
      'unread': 5,
      'avatar': '', // Group icon
      'isOnline': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode
        ? const Color(0xFF102216)
        : const Color(0xFFF6F8F6);
    final surfaceColor = isDarkMode ? const Color(0xFF1A2E22) : Colors.white;
    final textColor = isDarkMode ? Colors.white : const Color(0xFF0F172A);
    final secondaryTextColor = isDarkMode
        ? const Color(0xFF94A3B8)
        : const Color(0xFF64748B);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          'Messages',
          style: GoogleFonts.lexend(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        backgroundColor: surfaceColor,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: secondaryTextColor),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.edit_square, color: const Color(0xFF2BEE6C)),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
            height: 1.0,
          ),
        ),
      ),
      body: ListView.separated(
        itemCount: chats.length,
        separatorBuilder: (ctx, i) => Divider(
          height: 1,
          indent: 72,
          color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
        ),
        itemBuilder: (context, index) {
          final chat = chats[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            onTap: () {
              // Navigation to specific chat (reusing ParentChatPage for Ms. Sarah, generic for others)
              // For demo purposes, we will route Ms. Sarah to the specific page we built.
              if (chat['name'] == 'Ms. Sarah') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ParentChatPage(),
                  ),
                );
              } else {
                // For now, just open the same chat page as a demo or show a snackbar
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ParentChatPage(),
                  ),
                );
              }
            },
            leading: Stack(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                    image: chat['avatar'].toString().isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(chat['avatar']),
                            fit: BoxFit.cover,
                            onError: (e, s) {}, // Handle error silently
                          )
                        : null,
                  ),
                  child: chat['avatar'].toString().isEmpty
                      ? Icon(Icons.group, color: secondaryTextColor)
                      : null,
                ),
                if (chat['isOnline'] == true)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2BEE6C),
                        shape: BoxShape.circle,
                        border: Border.all(color: surfaceColor, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            title: Text(
              chat['name'],
              style: GoogleFonts.lexend(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: textColor,
              ),
            ),
            subtitle: Text(
              chat['message'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.lexend(
                fontSize: 14,
                color: chat['unread'] > 0 ? textColor : secondaryTextColor,
                fontWeight: chat['unread'] > 0
                    ? FontWeight.w500
                    : FontWeight.normal,
              ),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  chat['time'],
                  style: GoogleFonts.lexend(
                    fontSize: 12,
                    color: chat['unread'] > 0
                        ? const Color(0xFF2BEE6C)
                        : secondaryTextColor,
                    fontWeight: chat['unread'] > 0
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
                if (chat['unread'] > 0) ...[
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Color(0xFF2BEE6C),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      chat['unread'].toString(),
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF102216),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
