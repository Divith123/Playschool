import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';
import 'package:playschool/widgets/search_bar.dart';
import 'package:playschool/widgets/status_badge.dart';

class ParentLostFoundPage extends StatefulWidget {
  const ParentLostFoundPage({super.key});

  @override
  State<ParentLostFoundPage> createState() => _ParentLostFoundPageState();
}

class _ParentLostFoundPageState extends State<ParentLostFoundPage> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Clothing', 'Bottles', 'Toys', 'Books'];

  final List<Map<String, dynamic>> _items = [
    {
      'name': 'Blue Denim Jacket',
      'location': 'Playground',
      'category': 'Clothing',
      'date': 'Oct 28',
      'image': 'https://placehold.co/200x200/png?text=Jacket',
      'status': 'Unclaimed',
    },
    {
      'name': 'Spider-Man Bottle',
      'location': 'Cafeteria',
      'category': 'Bottles',
      'date': 'Oct 29',
      'image': 'https://placehold.co/200x200/png?text=Bottle',
      'status': 'Unclaimed',
    },
    {
      'name': 'Math Textbook',
      'location': 'Library',
      'category': 'Books',
      'date': 'Oct 25',
      'image': 'https://placehold.co/200x200/png?text=Book',
      'status': 'Claimed',
    },
    {
      'name': 'Teddy Bear',
      'location': 'Nap Room',
      'category': 'Toys',
      'date': 'Oct 30',
      'image': 'https://placehold.co/200x200/png?text=Teddy',
      'status': 'Unclaimed',
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
        title: Text(
          'Lost & Found',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomSearchBar(
              hintText: 'Search lost items...',
              onChanged: (val) {},
              isDarkMode: isDarkMode,
            ),
          ),
          const SizedBox(height: 16),

          // Filters
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: _filters.map((filter) {
                final isSelected = _selectedFilter == filter;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(filter),
                    selected: isSelected,
                    onSelected: (val) =>
                        setState(() => _selectedFilter = filter),
                    backgroundColor: surfaceColor,
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : textColor,
                    ),
                    checkmarkColor: Colors.white,
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),

          // Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                if (_selectedFilter != 'All' &&
                    item['category'] != _selectedFilter) {
                  return const SizedBox.shrink();
                }
                return _buildItemCard(
                  item,
                  isDarkMode,
                  surfaceColor,
                  textColor,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemCard(
    Map<String, dynamic> item,
    bool isDarkMode,
    Color surfaceColor,
    Color textColor,
  ) {
    final isClaimed = item['status'] == 'Claimed';

    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(item['image']),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.grey[200],
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      item['category'],
                      style: GoogleFonts.lexend(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                if (isClaimed)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.success,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'CLAIMED',
                          style: GoogleFonts.lexend(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Info
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['name'],
                        style: GoogleFonts.lexend(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 12, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            item['location'],
                            style: GoogleFonts.lexend(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 12,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Found: ${item['date']}',
                            style: GoogleFonts.lexend(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (!isClaimed)
                    PrimaryButton(
                      label: 'Claim This',
                      onPressed: () {
                        setState(() {
                          item['status'] = 'Claimed';
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Item claimed! Please pick up from reception.',
                            ),
                            backgroundColor: AppColors.success,
                          ),
                        );
                      },
                      height: 36,
                      fontSize: 12,
                      width: double.infinity,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
