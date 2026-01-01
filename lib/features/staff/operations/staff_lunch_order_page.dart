import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class StaffLunchOrderPage extends StatefulWidget {
  const StaffLunchOrderPage({super.key});

  @override
  State<StaffLunchOrderPage> createState() => _StaffLunchOrderPageState();
}

class _StaffLunchOrderPageState extends State<StaffLunchOrderPage> {
  final List<Map<String, dynamic>> _menu = [
    {
      'id': 1,
      'name': 'Veggie Wrap Meal',
      'price': 5.50,
      'cal': 350,
      'desc': 'Hummus, peppers, and greens in a spinach wrap.',
    },
    {
      'id': 2,
      'name': 'Chicken Caesar Salad',
      'price': 7.00,
      'cal': 420,
      'desc': 'Grilled chicken breast with romaine and gourmet dressing.',
    },
    {
      'id': 3,
      'name': 'Quinoa Bowl',
      'price': 6.50,
      'cal': 380,
      'desc': 'Roasted veggies on a bed of quinoa.',
    },
  ];

  int _selectedId = -1;

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
          'Lunch Pre-Order',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.orange.withValues(alpha: 0.1),
            child: Text(
              'Orders must be placed by 10:00 AM daily.',
              style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _menu.length,
              separatorBuilder: (ctx, i) => const SizedBox(height: 16),
              itemBuilder: (ctx, i) {
                final item = _menu[i];
                final isSelected = _selectedId == item['id'];

                return GestureDetector(
                  onTap: () => setState(() => _selectedId = item['id']),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary.withValues(alpha: 0.1)
                          : surfaceColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : Colors.grey.withValues(alpha: 0.1),
                        width: 2,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: NetworkImage(
                                'https://placehold.co/100x100/png?text=Food',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name'],
                                style: GoogleFonts.lexend(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item['desc'],
                                style: GoogleFonts.lexend(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.local_fire_department,
                                    size: 14,
                                    color: Colors.orange,
                                  ),
                                  Text(
                                    ' ${item['cal']} kcal',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '\$${item['price'].toStringAsFixed(2)}',
                                    style: GoogleFonts.lexend(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: textColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24),
            child: PrimaryButton(
              label: _selectedId == -1 ? 'Select a Meal' : 'Place Order',
              onPressed: _selectedId == -1
                  ? null
                  : () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Lunch Order Placed! Amount deducted from wallet.',
                          ),
                          backgroundColor: AppColors.success,
                        ),
                      );
                      Navigator.pop(context);
                    },
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }
}
