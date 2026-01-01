import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ParentPickupManagerPage extends StatefulWidget {
  const ParentPickupManagerPage({super.key});

  @override
  State<ParentPickupManagerPage> createState() =>
      _ParentPickupManagerPageState();
}

class _ParentPickupManagerPageState extends State<ParentPickupManagerPage> {
  static const Color backgroundLight = Color(0xFFf6f8f6);
  static const Color backgroundDark = Color(0xFF102216);
  static const Color surfaceLight = Color(0xFFffffff);
  static const Color surfaceDark = Color(0xFF1a2c20);
  static const Color textMainLight = Color(0xFF0d1b12);
  static const Color textMainDark = Color(0xFFe0e7e3);
  static const Color textSubLight = Color(0xFF4e6d97);

  final List<Map<String, String>> _persons = [
    {
      'name': 'John Doe',
      'relation': 'Father',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBHJUXGumrMlSxLNRNkaR5-OR4vKkSJRG_QqfS012BuC2GO-oEmkffMcLucGoxPAYQUZror0MzF-dpbX53rhTBvHJQMG12-RbUWsO_zegd-ID_ugftsC1KvSzddAkl2zu86tH5MiQdNZg999nr2XFvLQ8MW9q56xO6TYsb2bJap8H1CTKQYQFlyHvNzZoSxVBYgdcmBCAuYhnH4dp8NKXh0AZxCk0lQMpupApLp7WTIp9gLFffYSLaY8p0pj7UMPOGXFtZc-yVrPOU',
      'status': 'Approved',
    },
    {
      'name': 'Sarah Smith',
      'relation': 'Grandmother',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDns3GWXpFYplBAleTn3okZ3AaMFot2iIzyxHqggrj93p9Cpl9vvvVTF4i1vXZ3ouLkozNX15LLTYlFlRoeoj_yNDLRMqYvEag3OHYPPFC-SIVepOuJros_o0pN-4EQEIb-2pC2a_MJ50PcvWzgHHaJ06EzjCSCrX1ymIlRgcC08ehvExVOYpPJ8WPeEkpDwwT2X-B4GfvWHJ_aSqLjDKAqBRlCDH1WYqpOMytwUh1M1Gc6sfz-wE2KQUKwnrLLKqmM-ic25Ykgxz8',
      'status': 'Approved',
    },
  ];

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
          'Authorized Pickups',
          style: GoogleFonts.lexend(fontWeight: FontWeight.bold),
        ),
        backgroundColor: bgColor,
        foregroundColor: textColor,
        elevation: 0,
        actions: [IconButton(icon: const Icon(Icons.add), onPressed: () {})],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _persons.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final person = _persons[index];
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(person['image']!),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        person['name']!,
                        style: GoogleFonts.lexend(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      Text(
                        person['relation']!,
                        style: GoogleFonts.lexend(
                          fontSize: 14,
                          color: subTextColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.verified,
                              size: 14,
                              color: Colors.green,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Verified',
                              style: GoogleFonts.lexend(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.more_vert, color: subTextColor),
                  onPressed: () {},
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
