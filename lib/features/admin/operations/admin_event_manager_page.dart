import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class AdminEventManagerPage extends StatefulWidget {
  const AdminEventManagerPage({super.key});

  @override
  State<AdminEventManagerPage> createState() => _AdminEventManagerPageState();
}

class _AdminEventManagerPageState extends State<AdminEventManagerPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Event Manager',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: isDarkMode ? AppColors.textMainDark : AppColors.textMainLight,
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: isDarkMode
              ? Colors.grey[400]
              : Colors.grey[600],
          indicatorColor: AppColors.primary,
          tabs: const [
            Tab(text: 'Upcoming Events'),
            Tab(text: 'Create New'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildEventList(isDarkMode), _buildEventWizard(isDarkMode)],
      ),
    );
  }

  Widget _buildEventList(bool isDarkMode) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildEventCard(
          title: 'Annual Sports Day',
          date: '12 Dec 2024',
          venue: 'School Ground',
          isTicketed: true,
          volunteersNeeded: true,
          isDarkMode: isDarkMode,
        ),
        _buildEventCard(
          title: 'Science Fair',
          date: '20 Jan 2025',
          venue: 'Main Hall',
          isTicketed: false,
          volunteersNeeded: false,
          isDarkMode: isDarkMode,
        ),
      ],
    );
  }

  Widget _buildEventCard({
    required String title,
    required String date,
    required String venue,
    required bool isTicketed,
    required bool volunteersNeeded,
    required bool isDarkMode,
  }) {
    return Card(
      color: isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight,
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Container(
            height: 120,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              color: Colors.blueAccent, // Placeholder for event image
              image: DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1511632765486-a01980e01a18?q=80&w=2070&auto=format&fit=crop',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.headingMedium(isDarkMode)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: AppColors.textSubLight,
                    ),
                    const SizedBox(width: 6),
                    Text(date, style: AppTextStyles.bodyMedium(isDarkMode)),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: AppColors.textSubLight,
                    ),
                    const SizedBox(width: 6),
                    Text(venue, style: AppTextStyles.bodyMedium(isDarkMode)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    if (isTicketed)
                      Chip(
                        label: const Text('Tickets Status: Active'),
                        backgroundColor: AppColors.secondary.withValues(alpha: 0.2),
                        labelStyle: const TextStyle(
                          fontSize: 12,
                          color: AppColors.secondary,
                        ),
                      ),
                    const SizedBox(width: 8),
                    if (volunteersNeeded)
                      Chip(
                        label: const Text('Volunteers Wanted'),
                        backgroundColor: AppColors.accent.withValues(alpha: 0.2),
                        labelStyle: const TextStyle(
                          fontSize: 12,
                          color: AppColors.accent,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  label: 'Manage Event',
                  onPressed: () {},
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventWizard(bool isDarkMode) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Plan a New Event',
            style: AppTextStyles.headingLarge(isDarkMode),
          ),
          const SizedBox(height: 24),
          _buildTextField('Event Title', isDarkMode),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildTextField('Date', isDarkMode)),
              const SizedBox(width: 16),
              Expanded(child: _buildTextField('Time', isDarkMode)),
            ],
          ),
          const SizedBox(height: 16),
          _buildTextField('Venue', isDarkMode),
          const SizedBox(height: 16),
          _buildTextField('Expected Cost', isDarkMode, prefix: '\$'),
          const SizedBox(height: 24),

          SwitchListTile(
            title: Text(
              'Enable Ticketing?',
              style: AppTextStyles.bodyLarge(isDarkMode),
            ),
            subtitle: Text(
              'Parents can buy tickets via app',
              style: AppTextStyles.bodyMedium(isDarkMode),
            ),
            value: true,
            onChanged: (val) {},
            activeThumbColor: AppColors.primary,
          ),
          SwitchListTile(
            title: Text(
              'Request Parent Volunteers?',
              style: AppTextStyles.bodyLarge(isDarkMode),
            ),
            value: false,
            onChanged: (val) {},
            activeThumbColor: AppColors.primary,
          ),

          const SizedBox(height: 32),
          PrimaryButton(
            label: 'Create Event',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Event Created Successfully!')),
              );
            },
            width: double.infinity,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, bool isDarkMode, {String? prefix}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium(
            isDarkMode,
          ).copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          style: AppTextStyles.bodyLarge(isDarkMode),
          decoration: InputDecoration(
            prefixText: prefix,
            filled: true,
            fillColor: isDarkMode
                ? AppColors.surfaceDark
                : AppColors.surfaceLight,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDarkMode ? Colors.white10 : Colors.grey[300]!,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDarkMode ? Colors.white10 : Colors.grey[300]!,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
