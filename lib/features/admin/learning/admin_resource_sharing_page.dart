import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/search_bar.dart';

class AdminResourceSharingPage extends StatefulWidget {
  const AdminResourceSharingPage({super.key});

  @override
  State<AdminResourceSharingPage> createState() =>
      _AdminResourceSharingPageState();
}

class _AdminResourceSharingPageState extends State<AdminResourceSharingPage> {
  final List<Map<String, dynamic>> _folders = [
    {
      'name': 'Lesson Plans',
      'count': 12,
      'icon': Icons.folder,
      'color': Colors.blue,
    },
    {
      'name': 'Contracts',
      'count': 5,
      'icon': Icons.folder_shared,
      'color': Colors.amber,
    },
    {
      'name': 'Event Flyers',
      'count': 8,
      'icon': Icons.image,
      'color': Colors.purple,
    },
    {
      'name': 'Policies',
      'count': 3,
      'icon': Icons.shield,
      'color': Colors.green,
    },
  ];

  final List<Map<String, dynamic>> _files = [
    {'name': 'Weekly_Plan_Template.pdf', 'size': '2.5 MB', 'date': 'Oct 20'},
    {'name': 'Music_Curriculum_Oct.docx', 'size': '1.1 MB', 'date': 'Oct 22'},
    {'name': 'Safety_Guidelines_v2.pdf', 'size': '5.0 MB', 'date': 'Sep 15'},
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
        title: Text(
          'Resource Drive',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.cloud_upload, color: AppColors.primary),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomSearchBar(
              hintText: 'Search files & folders...',
              onChanged: (val) {},
              isDarkMode: isDarkMode,
            ),
          ),

          // Folders Grid
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  'Folders',
                  style: GoogleFonts.lexend(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 140,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(16),
              itemCount: _folders.length,
              separatorBuilder: (ctx, i) => const SizedBox(width: 16),
              itemBuilder: (ctx, i) {
                final folder = _folders[i];
                return Container(
                  width: 120,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(folder['icon'], color: folder['color'], size: 32),
                      const Spacer(),
                      Text(
                        folder['name'],
                        style: GoogleFonts.lexend(
                          fontWeight: FontWeight.bold,
                          color: textColor,
                          fontSize: 13,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${folder['count']} files',
                        style: GoogleFonts.lexend(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Recent Files List
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Row(
              children: [
                Text(
                  'Recent Uploads',
                  style: GoogleFonts.lexend(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _files.length,
              separatorBuilder: (ctx, i) => const SizedBox(height: 12),
              itemBuilder: (ctx, i) {
                final file = _files[i];
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.picture_as_pdf, // Simplified icon logic
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              file['name'],
                              style: GoogleFonts.lexend(
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                            Text(
                              '${file['size']} • ${file['date']}',
                              style: GoogleFonts.lexend(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_vert, color: Colors.grey),
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
}
