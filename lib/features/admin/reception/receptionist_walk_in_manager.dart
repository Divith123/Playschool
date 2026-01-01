import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';
import 'package:playschool/widgets/search_bar.dart';
import 'package:playschool/widgets/status_badge.dart';

class ReceptionistWalkInManagerPage extends StatefulWidget {
  const ReceptionistWalkInManagerPage({super.key});

  @override
  State<ReceptionistWalkInManagerPage> createState() =>
      _ReceptionistWalkInManagerPageState();
}

class _ReceptionistWalkInManagerPageState
    extends State<ReceptionistWalkInManagerPage> {
  final List<Map<String, dynamic>> _inquiries = [
    {
      'name': 'Sarah Connor',
      'childAge': '4 Years',
      'phone': '555-0123',
      'purpose': 'Admission Inquiry',
      'status': 'Follow-up',
      'time': '10:30 AM',
    },
    {
      'name': 'Kyle Reese',
      'childAge': '3 Years',
      'phone': '555-0199',
      'purpose': 'Campus Tour',
      'status': 'Completed',
      'time': '09:15 AM',
    },
    {
      'name': 'Dr. Silberman',
      'childAge': '-',
      'phone': '555-0500',
      'purpose': 'Vendor Meeting',
      'status': 'Waiting',
      'time': '11:00 AM',
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
          'Front Desk & Walk-ins',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add new walk-in form
        },
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.person_add, color: Colors.white),
        label: const Text('New Visitor', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomSearchBar(
              hintText: 'Search visitor name...',
              onChanged: (val) {},
              isDarkMode: isDarkMode,
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildStatCard('Today\'s Visitors', '12', Colors.blue),
                const SizedBox(width: 12),
                _buildStatCard('Pending', '3', Colors.orange),
              ],
            ),
          ),
          const SizedBox(height: 16),

          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _inquiries.length,
              separatorBuilder: (ctx, i) => const SizedBox(height: 12),
              itemBuilder: (ctx, i) {
                return _buildInquiryCard(
                  _inquiries[i],
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

  Widget _buildStatCard(String label, String count, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.lexend(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              count,
              style: GoogleFonts.lexend(
                color: color,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInquiryCard(
    Map<String, dynamic> data,
    Color surfaceColor,
    Color textColor,
    bool isDarkMode,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data['time'],
                style: GoogleFonts.lexend(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              StatusBadge(status: data['status'], isDarkMode: isDarkMode),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            data['name'],
            style: GoogleFonts.lexend(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          Text(
            'Purpose: ${data['purpose']}',
            style: GoogleFonts.lexend(color: AppColors.primary, fontSize: 13),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.phone, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                data['phone'],
                style: GoogleFonts.lexend(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(width: 16),
              if (data['childAge'] != '-') ...[
                Icon(Icons.child_care, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  'Child: ${data['childAge']}',
                  style: GoogleFonts.lexend(color: Colors.grey, fontSize: 12),
                ),
              ],
            ],
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: () {}, child: const Text('Add Note')),
              const SizedBox(width: 8),
              PrimaryButton(
                label: 'Log Action',
                onPressed: () {},
                // Small button ideally
              ),
            ],
          ),
        ],
      ),
    );
  }
}
