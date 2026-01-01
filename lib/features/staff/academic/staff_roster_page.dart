import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/student_card.dart';
import 'package:playschool/features/staff/care/staff_milestone_tracking_page.dart';

class StaffRosterPage extends StatelessWidget {
  const StaffRosterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          'Class Roster',
          style: AppTextStyles.headingLarge(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSearchAndFilter(isDarkMode),
          const SizedBox(height: 24),
          Text(
            'Toddler Room B',
            style: AppTextStyles.headingMedium(isDarkMode),
          ),
          const SizedBox(height: 16),
          _buildStudentList(context, isDarkMode),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter(bool isDarkMode) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: isDarkMode
                  ? AppColors.surfaceDark
                  : AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDarkMode ? Colors.white10 : Colors.grey[200]!,
              ),
            ),
            child: Row(
              children: [
                const SizedBox(width: 12),
                Icon(
                  Icons.search,
                  color: isDarkMode ? Colors.grey[400] : Colors.grey[500],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Search students...',
                    style: AppTextStyles.bodyMedium(isDarkMode).copyWith(
                      color: isDarkMode ? Colors.grey[500] : Colors.grey[400],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDarkMode ? Colors.white10 : Colors.grey[200]!,
            ),
          ),
          child: Icon(
            Icons.filter_list,
            color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildStudentList(BuildContext context, bool isDarkMode) {
    final students = [
      {
        'name': 'Liam Johnson',
        'grade': 'Toddler Room B',
        'status': 'Present',
        'avatar':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuCp5p7j7eB_6D7GGYU8le8bbIuZJPmxmpfA8ctbXR3zTjbCJofhRimpgK2H1TyPo9LtOpH_wMwdp2j6iJPV37buzo3Z-7jIkAzGpvYltl8QnpfnLuIwrOHsk_6gtDB9rsqD-TXdlUJ4SD0_YMv1SMmJWjSz8OMMnD9wUG5U8aU6dmxn5C9OSWDuSpzdUh4c1AwV_fdFCQ4KqRHJ51KKFpE0_7NAPmn50WPx7Rgj_a-q8Jcd-MCrc34375OB8uOMKfcoCeE2Kw6zjjw',
      },
      {
        'name': 'Emma Wilson',
        'grade': 'Toddler Room B',
        'status': 'Present',
        'avatar':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuCBxAhGY3SDnMgt6mpKLQsqZHhRYWg-MGgPihkYD7Lbj_UOEsC_4wJ9zjz-6qjzJv7PDtBWg9VCYzGE-5eYyXl01GRReK_6yPldqAe7odmVguH3nR7DVYO7KIC2ojFIifZiD8R0XOKpy8vb3__QrbMlEffPhQ_fWV12l640XvJ_XowknIJpDDqb9qtM62CRSuldzrw_EKugH5Ex92yeAyGOJhCFHezAKxPBeQFoJV5HgCPmeAVAR7dqdwdtcKgARXUSjJ5OsqWHWVg',
      },
      {
        'name': 'Noah Brown',
        'grade': 'Toddler Room B',
        'status': 'Absent',
        'avatar':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuCSoxrVKjN8z4U9Q7-tdYaJ-gOd8XVVS5_nGtHGNdkn5OCPwga_PcCPtwZrOKDfB8euYJENGjBfcCa5eC5k7lOfVH-Wdy0308demmldnACWXG66ojkZH9hkQCf3LhBq0dAF0xUTkg2PbeLlgsYSlpt1wpTEcwGshItnpWbeBBc2uNZsF36u4rZYedpDsSDW_YAIYpC12XLQGBxOI5odqUs5bsmsOlNaFnEEsXfWZs0GuACyEHxdWFqRZZ3e-h2o6wHlH17TVS5tx6g',
      },
      {
        'name': 'Olivia Davis',
        'grade': 'Toddler Room B',
        'status': 'Present',
        'avatar':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuBdoySuUyijXT_CXbGw928B15naN6hOzqlrnnsYQn5th6Qn8UW6jSrh6KyDHcxnmAUPnXlO-popvLNdfa1uWC28rtsb-stH9QtC_Jn36Sk3aRQQ-SOtReuU8ZqjTET1q0buvUbui_Xa0bznVRh1Q2XCHgEMmBNn9H-gKQjmURoHQXktLM0tQHOMcoVuPpBoUFJ3W6Fxi2xwM1DNx102u6C1zY21igwDGwOWLIavWkzG56RtX8k_RV4Djga-wD8gMj2Bi9s5h3NeMvg',
      },
      {
        'name': 'Ava Miller',
        'grade': 'Toddler Room B',
        'status': 'Late',
        'avatar':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuC5k7LP2WTcy4vr7_BNiyHDfrwD_vI2YD7MyJxmEygnfcEPZJdszs3wjbb3b2MQaAF1TQJTE_J_cbVpBS4vmvCFATNpSAbY98jpULqrDQUCIkpnFsbwLP5PM_9dCU2sDkgLM6R5YsnVmvauEUz2x8QbO8TE6oaGsg-dwGMS-RBBKPA0nTVwaptk-elIHwvzV7mA4UpKLB8B26owrFx6o2UwN9mdM33ZebXKJbyToipEYZM1BvQPeupZIVEKynyTdI15ZBi22lDli5c',
      },
    ];

    return Column(
      children: students.map((s) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: StudentCard(
            name: s['name']!,
            grade: s['grade']!,
            avatarUrl: s['avatar'],
            status: s['status'],
            isDarkMode: isDarkMode,
            onTap: () {
              HapticFeedback.lightImpact();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StaffMilestoneTrackingPage(),
                ),
              );
            },
          ),
        );
      }).toList(),
    );
  }
}
