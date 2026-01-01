import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class ParentBirthdayPartyPlannerPage extends StatefulWidget {
  const ParentBirthdayPartyPlannerPage({super.key});

  @override
  State<ParentBirthdayPartyPlannerPage> createState() =>
      _ParentBirthdayPartyPlannerPageState();
}

class _ParentBirthdayPartyPlannerPageState
    extends State<ParentBirthdayPartyPlannerPage> {
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 7));
  String _selectedTheme = 'Superheroes';
  String _selectedPackage = 'Gold';
  int _guestCount = 10;

  final List<Map<String, dynamic>> _themes = [
    {'name': 'Superheroes', 'icon': Icons.shield, 'color': Colors.red},
    {'name': 'Princess', 'icon': Icons.diamond, 'color': Colors.pink},
    {'name': 'Dinosaurs', 'icon': Icons.pets, 'color': Colors.green},
    {'name': 'Space', 'icon': Icons.rocket_launch, 'color': Colors.indigo},
    {'name': 'Jungle', 'icon': Icons.forest, 'color': Colors.orange},
    {'name': 'Underwater', 'icon': Icons.water_drop, 'color': Colors.blue},
  ];

  final List<Map<String, dynamic>> _packages = [
    {
      'name': 'Silver',
      'price': '\$150',
      'features': ['Decorations', 'Music', '1Hr Usage'],
    },
    {
      'name': 'Gold',
      'price': '\$250',
      'features': ['Decorations', 'Music', '2Hr Usage', 'Cake', 'Snacks'],
    },
    {
      'name': 'Platinum',
      'price': '\$400',
      'features': [
        'Full Decor',
        'DJ/Host',
        '3Hr Usage',
        'Cake & Meal',
        'Return Gifts',
      ],
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
          'Birthday Planner',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('1. Select Date', textColor),
            const SizedBox(height: 12),
            InkWell(
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (d != null) setState(() => _selectedDate = d);
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: surfaceColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, color: AppColors.primary),
                    const SizedBox(width: 12),
                    Text(
                      '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                      style: GoogleFonts.lexend(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Change',
                      style: GoogleFonts.lexend(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            _buildSectionHeader('2. Pick a Theme', textColor),
            const SizedBox(height: 12),
            SizedBox(
              height: 110,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _themes.length,
                separatorBuilder: (ctx, i) => const SizedBox(width: 12),
                itemBuilder: (ctx, i) {
                  final theme = _themes[i];
                  final isSelected = _selectedTheme == theme['name'];
                  return InkWell(
                    onTap: () => setState(() => _selectedTheme = theme['name']),
                    child: Container(
                      width: 90,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary.withOpacity(0.1)
                            : surfaceColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: theme['color'].withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              theme['icon'],
                              color: theme['color'],
                              size: 24,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            theme['name'],
                            style: GoogleFonts.lexend(
                              fontSize: 12,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: textColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            _buildSectionHeader('3. Select Package', textColor),
            const SizedBox(height: 12),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _packages.length,
              separatorBuilder: (ctx, i) => const SizedBox(height: 12),
              itemBuilder: (ctx, i) {
                final pkg = _packages[i];
                final isSelected = _selectedPackage == pkg['name'];
                return InkWell(
                  onTap: () => setState(() => _selectedPackage = pkg['name']),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: surfaceColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : Colors.grey.withOpacity(0.1),
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Radio(
                          value: pkg['name'],
                          groupValue: _selectedPackage,
                          onChanged: (val) =>
                              setState(() => _selectedPackage = val as String),
                          activeColor: AppColors.primary,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    pkg['name'],
                                    style: GoogleFonts.lexend(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: textColor,
                                    ),
                                  ),
                                  Text(
                                    pkg['price'],
                                    style: GoogleFonts.lexend(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 4,
                                children: (pkg['features'] as List<String>)
                                    .map(
                                      (f) => Chip(
                                        label: Text(
                                          f,
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: textColor,
                                          ),
                                        ),
                                        backgroundColor: isDarkMode
                                            ? Colors.grey[800]
                                            : Colors.grey[100],
                                        padding: EdgeInsets.zero,
                                        visualDensity: VisualDensity.compact,
                                      ),
                                    )
                                    .toList(),
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
            const SizedBox(height: 24),

            _buildSectionHeader('4. Guest Count', textColor),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.people_outline, color: Colors.grey),
                  const SizedBox(width: 16),
                  Text(
                    '$_guestCount Guests',
                    style: GoogleFonts.lexend(
                      fontSize: 16,
                      color: textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      if (_guestCount > 5) setState(() => _guestCount -= 5);
                    },
                    icon: Icon(Icons.remove_circle_outline, color: textColor),
                  ),
                  IconButton(
                    onPressed: () {
                      if (_guestCount < 100) setState(() => _guestCount += 5);
                    },
                    icon: Icon(Icons.add_circle_outline, color: textColor),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
            PrimaryButton(
              label: 'Book Party Request',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Party Request Sent to Admin!'),
                    backgroundColor: AppColors.success,
                  ),
                );
                Navigator.pop(context);
              },
              width: double.infinity,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, Color color) {
    return Text(
      title,
      style: GoogleFonts.lexend(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }
}
