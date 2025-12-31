import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ParentChatPage extends StatefulWidget {
  const ParentChatPage({super.key});

  @override
  State<ParentChatPage> createState() => _ParentChatPageState();
}

class _ParentChatPageState extends State<ParentChatPage> {
  // Color palette matching HTML
  static const Color primary = Color(0xFF2BEE6C);
  static const Color backgroundLight = Color(0xFFF6F8F6);
  static const Color backgroundDark = Color(0xFF102216);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1A2E22);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode ? backgroundDark : backgroundLight;
    final surfaceColor = isDarkMode ? surfaceDark : surfaceLight;
    final textColor = isDarkMode
        ? Colors.white
        : const Color(0xFF0F172A); // slate-900
    final secondaryTextColor = isDarkMode
        ? const Color(0xFF94A3B8)
        : const Color(0xFF64748B); // slate-400/500
    final borderColor = isDarkMode
        ? const Color(0xFF1E293B)
        : const Color(0xFFE2E8F0); // slate-800/200

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: surfaceColor.withOpacity(0.9),
                border: Border(bottom: BorderSide(color: borderColor)),
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(999),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 24,
                        color: isDarkMode ? Colors.grey[300] : Colors.grey[600],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Stack(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isDarkMode
                                ? Colors.grey[700]!
                                : Colors.grey[200]!,
                          ),
                          image: const DecorationImage(
                            image: NetworkImage(
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuAt5z0wJafXCp49FJqYXuFgVqgAjjsjVZzrFegoXNczgoFXEpq149MaaEU01viBAqQhyISVgseCJUeGEcp-by_fBlqE8lqha2JyDHahJUoce-2kKCllHC6w4-bTvZ88AK6ifk_RCxnuKuq6Lna2h5nKJ19LiHhJadEGA2S6-8V8W89Vxceo5nKJB5ToZR3m-vwlJUM1A-7L3XLvIzGxYXibdNDgUEH2mfJerF9oUCTt0id3ooSjn4ZFcOuXl0zgmxRAbLwSWPyvEas',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: primary,
                            shape: BoxShape.circle,
                            border: Border.all(color: surfaceColor, width: 2),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ms. Sarah',
                          style: _lexendFont(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                        Text(
                          'Class 2B • Online',
                          style: _lexendFont(
                            fontSize: 12,
                            color: secondaryTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.call,
                        color: isDarkMode ? primary : const Color(0xFF0F172A),
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Chat Content Area
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Privacy Notice
                  Center(
                    child: Opacity(
                      opacity: 0.8,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.yellow[900]!.withOpacity(0.3)
                                  : Colors.yellow[100],
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(
                                color: isDarkMode
                                    ? Colors.yellow[900]!.withOpacity(0.5)
                                    : Colors.yellow[200]!,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.lock,
                                  size: 14,
                                  color: isDarkMode
                                      ? Colors.yellow[500]
                                      : Colors.yellow[700],
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Private Conversation',
                                  style: _lexendFont(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: isDarkMode
                                        ? Colors.yellow[400]
                                        : Colors.yellow[800],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Messages are end-to-end encrypted.',
                            style: _lexendFont(
                              fontSize: 10,
                              color: secondaryTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Date Separator
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? Colors.grey[800]!.withOpacity(0.5)
                            : Colors.grey[100],
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        'Today',
                        style: _lexendFont(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: secondaryTextColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // System Message
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        'You are now connected with the class teacher.',
                        textAlign: TextAlign.center,
                        style: _lexendFont(
                          fontSize: 12,
                          color: secondaryTextColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Incoming Message (Teacher)
                  _buildIncomingMessage(
                    isDarkMode: isDarkMode,
                    surfaceColor: surfaceColor,
                    borderColor: borderColor,
                    secondaryTextColor: secondaryTextColor,
                    textColor: textColor,
                    sender: 'Ms. Sarah',
                    message:
                        "Hi! Just wanted to share a photo of Leo painting today. He's doing great!",
                    time: '10:41 AM',
                    avatarUrl:
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuBsdYfgQP01sc4G7i_2RaqS_chfZM5uJSURZM0ytdelZeevdXDS1Yt8pnI_7eLTO2UMqKFie8hdzwv5xtj1nfqxQwPmpHlhX-L_L1brbe0t51qfvrTmTe581MExQ0ae8ieNuXl3QPQOrOax0QXgCxWoyxiwZjQMnLQZjVl-un6OrwK8W5uhRfH8AX5-B8nCdHkyKZFHumq7kc0sfsttNgUmUjE_25SHq4FjPFULed-vLk4Begv7e07_Nkk4JVw23AAW3Egig571Mrg',
                  ),
                  const SizedBox(height: 16),

                  // Incoming Message Image (Teacher)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(width: 32 + 12), // Avatar width + gap
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 250,
                            height: 187.5, // 4:3 aspect ratio
                            decoration: BoxDecoration(
                              color: surfaceColor,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                              border: Border.all(color: borderColor),
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                              child: Image.network(
                                'https://lh3.googleusercontent.com/aida-public/AB6AXuAAWgxbr3iObu1QFudhemO7nut1e6-LWnjBmGKCMI9-zg4vBAn1WUm5nPJAajQn7_yTFaa5wBq5yx3GTmBWreADQ_UwIPrntU0IYLVyv9hlvcbVNDJ-7Ie4NTEmFgsYsd9J2z1WQ-aOVBZa-ckrV-GcYdmX5wPojzJ_-3VOy0DvMajZk02EGXu0e4Cht5ERiTjdttxH-qdKK7ELP2TdyLphsI8Lr8RMWhNd_rPvkkmXAdNChWisqyep9k8dnqKdT-XxD2EDk-9Uiig',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '10:41 AM',
                            style: _lexendFont(
                              fontSize: 10,
                              color: secondaryTextColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Outgoing Message (Parent)
                  _buildOutgoingMessage(
                    primary: primary,
                    textColor: backgroundDark,
                    secondaryTextColor: secondaryTextColor,
                    message:
                        "Oh wow, looks like fun! Thanks for sharing, Ms. Sarah.",
                    time: '10:42 AM',
                    statusIcon: Icons.done_all,
                    statusColor: primary,
                  ),
                  const SizedBox(height: 16),

                  // Outgoing Message (Parent)
                  _buildOutgoingMessage(
                    primary: primary,
                    textColor: backgroundDark,
                    secondaryTextColor: secondaryTextColor,
                    message:
                        "Can I pick him up a bit early today? Around 3 PM?",
                    time: '10:45 AM',
                    statusIcon: Icons.check,
                    statusColor: Colors.grey[400]!,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),

            // Input Area
            Container(
              padding: const EdgeInsets.only(
                left: 12,
                right: 12,
                top: 12,
                bottom: 24,
              ),
              decoration: BoxDecoration(
                color: surfaceColor,
                border: Border(top: BorderSide(color: borderColor)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDarkMode ? Colors.grey[800] : Colors.grey[100],
                    ),
                    child: Icon(
                      Icons.add_circle_outline,
                      color: secondaryTextColor,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      constraints: const BoxConstraints(minHeight: 44),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.grey[800] : Colors.grey[100],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.transparent),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Type a message...',
                              style: _lexendFont(
                                fontSize: 14,
                                color: secondaryTextColor,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.sentiment_satisfied_alt,
                            color: secondaryTextColor,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: primary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: primary.withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.arrow_upward,
                      color: backgroundDark,
                      size: 20,
                      weight: 600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIncomingMessage({
    required bool isDarkMode,
    required Color surfaceColor,
    required Color borderColor,
    required Color secondaryTextColor,
    required Color textColor,
    required String sender,
    required String message,
    required String time,
    required String avatarUrl,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(avatarUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 4),
              child: Text(
                sender,
                style: _lexendFont(fontSize: 11, color: secondaryTextColor),
              ),
            ),
            Container(
              constraints: const BoxConstraints(maxWidth: 260),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                border: Border.all(color: borderColor),
              ),
              child: Text(
                message,
                style: _lexendFont(fontSize: 14, color: textColor, height: 1.5),
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                time,
                style: _lexendFont(fontSize: 10, color: secondaryTextColor),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOutgoingMessage({
    required Color primary,
    required Color textColor,
    required Color secondaryTextColor,
    required String message,
    required String time,
    required IconData statusIcon,
    required Color statusColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 260),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: primary.withOpacity(0.2),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Text(
                message,
                style: _lexendFont(
                  fontSize: 14,
                  color: textColor,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  time,
                  style: _lexendFont(fontSize: 10, color: secondaryTextColor),
                ),
                const SizedBox(width: 4),
                Icon(statusIcon, size: 14, color: statusColor),
              ],
            ),
          ],
        ),
      ],
    );
  }

  TextStyle _lexendFont({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
  }) {
    return GoogleFonts.lexend(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
    );
  }
}
