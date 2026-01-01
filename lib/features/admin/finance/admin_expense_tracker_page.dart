import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminExpenseTrackerPage extends StatefulWidget {
  const AdminExpenseTrackerPage({super.key});

  @override
  State<AdminExpenseTrackerPage> createState() =>
      _AdminExpenseTrackerPageState();
}

class _AdminExpenseTrackerPageState extends State<AdminExpenseTrackerPage> {
  static const Color primary = Color(0xFF2bee6c);
  static const Color backgroundLight = Color(0xFFf6f8f6);
  static const Color backgroundDark = Color(0xFF102216);
  static const Color surfaceLight = Color(0xFFffffff);
  static const Color surfaceDark = Color(0xFF1a2c20);
  static const Color textMainLight = Color(0xFF0d1b12);
  static const Color textMainDark = Color(0xFFe0e7e3);
  static const Color textSubLight = Color(0xFF4e6d97);
  static const Color textSubDark = Color(0xFF8fcba3);

  String _selectedCategory = 'All';
  final List<String> _categories = [
    'All',
    'Supplies',
    'Maintenance',
    'Utilities',
    'Payroll',
    'Other',
  ];

  final List<Map<String, dynamic>> _expenses = [
    {
      'title': 'Art Supplies',
      'category': 'Supplies',
      'amount': '\$450.00',
      'date': 'Oct 24',
      'status': 'Approved',
      'icon': Icons.brush,
      'color': Colors.purple,
    },
    {
      'title': 'Plumbing Repair',
      'category': 'Maintenance',
      'amount': '\$120.00',
      'date': 'Oct 22',
      'status': 'Pending',
      'icon': Icons.build,
      'color': Colors.orange,
    },
    {
      'title': 'Electricity Bill',
      'category': 'Utilities',
      'amount': '\$340.00',
      'date': 'Oct 20',
      'status': 'Paid',
      'icon': Icons.bolt,
      'color': Colors.yellow,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode ? backgroundDark : backgroundLight;
    final surfaceColor = isDarkMode ? surfaceDark : surfaceLight;
    final textColor = isDarkMode ? textMainDark : textMainLight;
    final subTextColor = isDarkMode ? textSubDark : textSubLight;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Expenses',
          style: GoogleFonts.lexend(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.download, color: textColor),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add expense logic
        },
        backgroundColor: primary,
        child: const Icon(Icons.add, color: Colors.black),
      ),
      body: Column(
        children: [
          // Chart Placeholder
          Container(
            height: 180,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Expenses (Oct)',
                  style: GoogleFonts.lexend(color: subTextColor),
                ),
                Text(
                  '\$910.00',
                  style: GoogleFonts.lexend(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const Spacer(),
                // Simple bar chart vis
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(7, (index) {
                    final height = [
                      40.0,
                      60.0,
                      30.0,
                      80.0,
                      50.0,
                      70.0,
                      45.0,
                    ][index];
                    return Container(
                      width: 30,
                      height: height,
                      decoration: BoxDecoration(
                        color: primary.withOpacity(0.5 + (index * 0.05)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),

          // Filters
          Container(
            height: 40,
            margin: const EdgeInsets.only(bottom: 16),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final cat = _categories[index];
                final isSelected = cat == _selectedCategory;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = cat),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? textColor : Colors.transparent,
                      border: Border.all(color: textColor.withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      cat,
                      style: GoogleFonts.lexend(
                        color: isSelected ? bgColor : textColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _expenses.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final expense = _expenses[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: (expense['color'] as Color).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(expense['icon'], color: expense['color']),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              expense['title'],
                              style: GoogleFonts.lexend(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: textColor,
                              ),
                            ),
                            Text(
                              '${expense['category']} • ${expense['date']}',
                              style: GoogleFonts.lexend(
                                fontSize: 12,
                                color: subTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '-${expense['amount']}',
                            style: GoogleFonts.lexend(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: textColor,
                            ),
                          ),
                          Text(
                            expense['status'],
                            style: GoogleFonts.lexend(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: expense['status'] == 'Pending'
                                  ? Colors.orange
                                  : Colors.green,
                            ),
                          ),
                        ],
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
