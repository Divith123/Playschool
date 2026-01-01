import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';

class ParentMemoryLanePage extends StatelessWidget {
  const ParentMemoryLanePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Memory Lane',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: isDarkMode ? AppColors.textMainDark : AppColors.textMainLight,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildYearSection('2025', isDarkMode),
          _buildMemoryCard(
            'Science Fair Winner',
            '20 Jan 2025',
            'https://images.unsplash.com/photo-1544947950-fa07a98d237f?q=80&w=2070&auto=format&fit=crop',
            isDarkMode,
          ),
          _buildMemoryCard(
            'First Day of Class 2',
            '10 Jan 2025',
            'https://images.unsplash.com/photo-1503676260728-1c00da094a0b?q=80&w=2070&auto=format&fit=crop',
            isDarkMode,
          ),

          const SizedBox(height: 24),
          _buildYearSection('2024', isDarkMode),
          _buildMemoryCard(
            'Christmas Party',
            '25 Dec 2024',
            'https://images.unsplash.com/photo-1512909006721-3d6018887383?q=80&w=2070&auto=format&fit=crop',
            isDarkMode,
          ),
          _buildMemoryCard(
            'Sports Day Relay',
            '15 Nov 2024',
            'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?q=80&w=2070&auto=format&fit=crop',
            isDarkMode,
          ),
        ],
      ),
    );
  }

  Widget _buildYearSection(String year, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Text(
            year,
            style: AppTextStyles.headingLarge(
              isDarkMode,
            ).copyWith(color: AppColors.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              height: 1,
              color: isDarkMode ? Colors.white24 : Colors.grey[300],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemoryCard(
    String title,
    String date,
    String imgUrl,
    bool isDarkMode,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Image.network(
            imgUrl,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: AppTextStyles.headingMedium(
                    true,
                  ).copyWith(color: Colors.white),
                ),
                Text(
                  date,
                  style: AppTextStyles.bodyMedium(
                    true,
                  ).copyWith(color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
