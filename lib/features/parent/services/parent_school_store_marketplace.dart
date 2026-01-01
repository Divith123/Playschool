import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/search_bar.dart';

class ParentSchoolStoreMarketplacePage extends StatefulWidget {
  const ParentSchoolStoreMarketplacePage({super.key});

  @override
  State<ParentSchoolStoreMarketplacePage> createState() =>
      _ParentSchoolStoreMarketplacePageState();
}

class _ParentSchoolStoreMarketplacePageState
    extends State<ParentSchoolStoreMarketplacePage> {
  int _cartCount = 2;
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Uniforms',
    'Books',
    'Stationery',
    'Merch',
  ];

  final List<Map<String, dynamic>> _products = [
    {
      'name': 'Winter Jacket (Navy)',
      'price': 45.00,
      'category': 'Uniforms',
      'image': 'https://placehold.co/200x200/png?text=Jacket',
      'rating': 4.5,
    },
    {
      'name': 'Math Workbook Lvl 2',
      'price': 12.50,
      'category': 'Books',
      'image': 'https://placehold.co/200x200/png?text=Math+Book',
      'rating': 4.8,
    },
    {
      'name': 'School Backpack',
      'price': 35.00,
      'category': 'Merch',
      'image': 'https://placehold.co/200x200/png?text=Backpack',
      'rating': 4.9,
    },
    {
      'name': 'Art Kit Premium',
      'price': 22.00,
      'category': 'Stationery',
      'image': 'https://placehold.co/200x200/png?text=Art+Kit',
      'rating': 4.7,
    },
    {
      'name': 'Water Bottle (Steel)',
      'price': 18.00,
      'category': 'Merch',
      'image': 'https://placehold.co/200x200/png?text=Bottle',
      'rating': 4.6,
    },
    {
      'name': 'PE T-Shirt',
      'price': 15.00,
      'category': 'Uniforms',
      'image': 'https://placehold.co/200x200/png?text=T-Shirt',
      'rating': 4.4,
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
          'School Store',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.shopping_cart_outlined, color: textColor),
              ),
              if (_cartCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$_cartCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomSearchBar(
              hintText: 'Search for uniforms, books...',
              onChanged: (val) {},
              isDarkMode: isDarkMode,
            ),
          ),

          // Categories
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: _categories.map((cat) {
                final isSelected = _selectedCategory == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(cat),
                    selected: isSelected,
                    onSelected: (val) =>
                        setState(() => _selectedCategory = cat),
                    backgroundColor: surfaceColor,
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : textColor,
                    ),
                    checkmarkColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide.none,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),

          // Product Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                if (_selectedCategory != 'All' &&
                    product['category'] != _selectedCategory) {
                  return const SizedBox.shrink(); // Ideally filter list beforehand
                }
                return _buildProductCard(
                  product,
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

  Widget _buildProductCard(
    Map<String, dynamic> product,
    bool isDarkMode,
    Color surfaceColor,
    Color textColor,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
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
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(product['image']),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.grey[200],
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 12),
                        const SizedBox(width: 4),
                        Text(
                          '${product['rating']}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Details
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name'],
                  style: GoogleFonts.lexend(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  product['category'],
                  style: GoogleFonts.lexend(fontSize: 10, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${product['price']}',
                      style: GoogleFonts.lexend(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() => _cartCount++);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Added ${product['name']} to cart'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
