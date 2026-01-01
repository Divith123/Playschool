import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';
import 'package:playschool/widgets/status_badge.dart';

class StaffSubstitutionFinderPage extends StatefulWidget {
  const StaffSubstitutionFinderPage({super.key});

  @override
  State<StaffSubstitutionFinderPage> createState() =>
      _StaffSubstitutionFinderPageState();
}

class _StaffSubstitutionFinderPageState
    extends State<StaffSubstitutionFinderPage> {
  DateTime _selectedDate = DateTime.now();
  String _reason = 'Sick Leave';

  final List<Map<String, dynamic>> _substitutes = [
    {
      'name': 'Emma Watson',
      'role': 'Supply Teacher',
      'rating': 4.9,
      'rate': '\$25/hr',
      'availability': 'Available',
      'image': 'https://placehold.co/100x100/png?text=E',
    },
    {
      'name': 'John Doe',
      'role': 'Assistant',
      'rating': 4.5,
      'rate': '\$20/hr',
      'availability': 'Available',
      'image': 'https://placehold.co/100x100/png?text=J',
    },
    {
      'name': 'Lisa Ray',
      'role': 'Senior Teacher',
      'rating': 5.0,
      'rate': '\$30/hr',
      'availability': 'Busy',
      'image': 'https://placehold.co/100x100/png?text=L',
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
          'Find Substitution',
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
            // Request Details
            _buildSectionHeader('1. Leave Details', textColor),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.withOpacity(0.1)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Date', style: TextStyle(color: Colors.grey)),
                      InkWell(
                        onTap: () async {
                          final d = await showDatePicker(
                            context: context,
                            initialDate: _selectedDate,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(
                              const Duration(days: 30),
                            ),
                          );
                          if (d != null) setState(() => _selectedDate = d);
                        },
                        child: Row(
                          children: [
                            Text(
                              '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                            Icon(Icons.arrow_drop_down, color: textColor),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Reason', style: TextStyle(color: Colors.grey)),
                      DropdownButton<String>(
                        value: _reason,
                        underline: Container(), // Remove default line
                        dropdownColor: surfaceColor,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                        items: ['Sick Leave', 'Personal', 'Emergency']
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                        onChanged: (val) => setState(() => _reason = val!),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Available Subs
            _buildSectionHeader('2. Available Substitutes', textColor),
            const SizedBox(height: 12),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _substitutes.length,
              separatorBuilder: (ctx, i) => const SizedBox(height: 12),
              itemBuilder: (ctx, i) {
                return _buildSubCard(
                  _substitutes[i],
                  surfaceColor,
                  textColor,
                  isDarkMode,
                );
              },
            ),
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

  Widget _buildSubCard(
    Map<String, dynamic> sub,
    Color surfaceColor,
    Color textColor,
    bool isDarkMode,
  ) {
    final bool isAvailable = sub['availability'] == 'Available';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 28, backgroundImage: NetworkImage(sub['image'])),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sub['name'],
                  style: GoogleFonts.lexend(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                Text(
                  sub['role'],
                  style: GoogleFonts.lexend(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star, size: 14, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(
                      '${sub['rating']}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      sub['rate'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              StatusBadge(status: sub['availability'], isDarkMode: isDarkMode),
              const SizedBox(height: 8),
              if (isAvailable)
                PrimaryButton(
                  label: 'Request',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Request sent to ${sub['name']}'),
                        backgroundColor: AppColors.success,
                      ),
                    );
                  },
                  height: 32,
                  fontSize: 12,
                  width: 80,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
