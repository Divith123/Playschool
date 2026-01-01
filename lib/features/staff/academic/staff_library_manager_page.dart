import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';
import 'package:playschool/widgets/search_bar.dart';
import 'package:playschool/widgets/status_badge.dart';

class StaffLibraryManagerPage extends StatefulWidget {
  const StaffLibraryManagerPage({super.key});

  @override
  State<StaffLibraryManagerPage> createState() =>
      _StaffLibraryManagerPageState();
}

class _StaffLibraryManagerPageState extends State<StaffLibraryManagerPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _books = [
    {
      'title': 'The Very Hungry Caterpillar',
      'author': 'Eric Carle',
      'status': 'Available',
      'cover': 'https://placehold.co/100x150/png?text=Caterpillar',
    },
    {
      'title': 'Green Eggs and Ham',
      'author': 'Dr. Seuss',
      'status': 'Issued',
      'issuedTo': 'Alice Wanders',
      'dueDate': 'Oct 30',
      'cover': 'https://placehold.co/100x150/png?text=DrSeuss',
    },
    {
      'title': 'Goodnight Moon',
      'author': 'Margaret Wise Brown',
      'status': 'Overdue',
      'issuedTo': 'Bobby Tables',
      'dueDate': 'Oct 20',
      'fine': '\$2.50',
      'cover': 'https://placehold.co/100x150/png?text=Goodnight',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

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
          'Library Manager',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: Colors.grey,
          indicatorColor: AppColors.primary,
          tabs: const [
            Tab(text: 'Books Inventory'),
            Tab(text: 'Issue/Return'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildInventoryTab(isDarkMode, surfaceColor, textColor),
          _buildIssueReturnTab(isDarkMode, surfaceColor, textColor),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {}, // Add Book
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildInventoryTab(
    bool isDarkMode,
    Color surfaceColor,
    Color textColor,
  ) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: CustomSearchBar(
            hintText: 'Search title, author...',
            onChanged: (val) {},
            isDarkMode: isDarkMode,
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _books.length,
            separatorBuilder: (ctx, i) => const SizedBox(height: 16),
            itemBuilder: (ctx, i) {
              return _buildBookCard(
                _books[i],
                surfaceColor,
                textColor,
                isDarkMode,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBookCard(
    Map<String, dynamic> book,
    Color surfaceColor,
    Color textColor,
    bool isDarkMode,
  ) {
    final status = book['status'];
    final isOverdue = status == 'Overdue';

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isOverdue ? Colors.red.withOpacity(0.3) : Colors.transparent,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              book['cover'],
              width: 70,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        book['title'],
                        style: GoogleFonts.lexend(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    StatusBadge(status: status, isDarkMode: isDarkMode),
                  ],
                ),
                Text(
                  book['author'],
                  style: GoogleFonts.lexend(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                if (status != 'Available') ...[
                  Text(
                    'Issued to: ${book['issuedTo']}',
                    style: GoogleFonts.lexend(fontSize: 12, color: textColor),
                  ),
                  Row(
                    children: [
                      Text(
                        'Due: ${book['dueDate']}',
                        style: GoogleFonts.lexend(
                          fontSize: 12,
                          color: isOverdue ? Colors.red : Colors.grey,
                          fontWeight: isOverdue
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      if (isOverdue)
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            'Fine: ${book['fine']}',
                            style: GoogleFonts.lexend(
                              fontSize: 12,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIssueReturnTab(
    bool isDarkMode,
    Color surfaceColor,
    Color textColor,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.qr_code_scanner,
                    size: 60,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Scan Book Barcode',
                    style: GoogleFonts.lexend(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          Text('OR Enter ISBN', style: GoogleFonts.lexend(color: Colors.grey)),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              hintText: 'Enter ISBN / Book ID',
              filled: true,
              fillColor: surfaceColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              suffixIcon: Icon(Icons.search, color: AppColors.primary),
            ),
            style: TextStyle(color: textColor),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  label: 'Issue Book',
                  onPressed: () {
                    // Show issue flow
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: PrimaryButton(
                  label: 'Return Book',
                  onPressed: () {
                    // Show return flow
                  },
                  backgroundColor: Colors.transparent, // Outline style
                  textColor: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
