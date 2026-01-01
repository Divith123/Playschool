import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/search_bar.dart';

class AdminDonationManagerPage extends StatefulWidget {
  const AdminDonationManagerPage({super.key});

  @override
  State<AdminDonationManagerPage> createState() =>
      _AdminDonationManagerPageState();
}

class _AdminDonationManagerPageState extends State<AdminDonationManagerPage> {
  final List<Map<String, dynamic>> _donations = [
    {
      'donor': 'John Smith Foundation',
      'amount': '\$5,000',
      'purpose': 'New Library Books',
      'date': 'Oct 28, 2025',
      'status': 'Received',
    },
    {
      'donor': 'Alice & Bob Parents',
      'amount': '\$500',
      'purpose': 'Sports Equipment',
      'date': 'Oct 25, 2025',
      'status': 'Received',
    },
    {
      'donor': 'Community Grant',
      'amount': '\$10,000',
      'purpose': 'Playground Renovation',
      'date': 'Pending',
      'status': 'Pledged',
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
          'Donations & Grants',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {}, // Manual entry
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomSearchBar(
              hintText: 'Search donor...',
              onChanged: (val) {},
              isDarkMode: isDarkMode,
            ),
          ),

          // Total Card
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.success,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Raised (FY 2025)',
                      style: GoogleFonts.lexend(
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                    Text(
                      '\$15,500',
                      style: GoogleFonts.lexend(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.volunteer_activism,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _donations.length,
              separatorBuilder: (ctx, i) => const SizedBox(height: 12),
              itemBuilder: (ctx, i) {
                return _buildDonationCard(
                  _donations[i],
                  surfaceColor,
                  textColor,
                  isDarkMode,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDonationCard(
    Map<String, dynamic> data,
    Color surfaceColor,
    Color textColor,
    bool isDarkMode,
  ) {
    bool isPledged = data['status'] == 'Pledged';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['donor'],
                    style: GoogleFonts.lexend(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: textColor,
                    ),
                  ),
                  Text(
                    data['purpose'],
                    style: GoogleFonts.lexend(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              Text(
                data['amount'],
                style: GoogleFonts.lexend(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data['date'],
                style: GoogleFonts.lexend(fontSize: 12, color: Colors.grey),
              ),
              if (isPledged)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'PLEDGED',
                    style: GoogleFonts.lexend(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                )
              else
                Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text('Receipt', style: TextStyle(fontSize: 12)),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'RECEIVED',
                        style: GoogleFonts.lexend(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: AppColors.success,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
