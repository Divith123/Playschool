import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class ParentEventRegistrationPage extends StatelessWidget {
  const ParentEventRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Upcoming Events',
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
          _buildEventCard(
            context,
            title: 'Annual Sports Day',
            date: '12 Dec 2024',
            description:
                'Join us for a day of fun and games! Parents are invited to participate in the relay race.',
            imageUrl:
                'https://images.unsplash.com/photo-1511632765486-a01980e01a18?q=80&w=2070&auto=format&fit=crop',
            price: 15,
            isDarkMode: isDarkMode,
          ),
          const SizedBox(height: 20),
          _buildEventCard(
            context,
            title: 'Science Fair',
            date: '20 Jan 2025',
            description:
                'Explore the wonderful projects created by our little scientists.',
            imageUrl:
                'https://images.unsplash.com/photo-1532094349884-543bc11b234d?q=80&w=2070&auto=format&fit=crop', // Placeholder
            price: 0, // Free
            isDarkMode: isDarkMode,
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(
    BuildContext context, {
    required String title,
    required String date,
    required String description,
    required String imageUrl,
    required double price,
    required bool isDarkMode,
  }) {
    return Card(
      color: isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Header
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            child: Container(
              height: 150,
              width: double.infinity,
              color: Colors.grey[300],
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) =>
                    Icon(Icons.image, size: 50, color: Colors.grey),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: AppTextStyles.headingMedium(isDarkMode),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        price == 0 ? 'FREE' : '\$$price',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      size: 16,
                      color: AppColors.secondary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      date,
                      style: AppTextStyles.bodyMedium(isDarkMode).copyWith(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(description, style: AppTextStyles.bodyMedium(isDarkMode)),
                const SizedBox(height: 24),
                PrimaryButton(
                  label: 'Register Now',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text('Register for $title?'),
                        content: Text(
                          price > 0
                              ? 'Amount to pay: \$$price'
                              : 'This event is free.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: Text('Cancel'),
                          ),
                          PrimaryButton(
                            label: 'Confirm',
                            onPressed: () {
                              Navigator.pop(ctx);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Registration Confirmed!'),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
