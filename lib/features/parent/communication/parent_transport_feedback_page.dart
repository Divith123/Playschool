import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class ParentTransportFeedbackPage extends StatefulWidget {
  const ParentTransportFeedbackPage({super.key});

  @override
  State<ParentTransportFeedbackPage> createState() =>
      _ParentTransportFeedbackPageState();
}

class _ParentTransportFeedbackPageState
    extends State<ParentTransportFeedbackPage> {
  int _rating = 0;
  final TextEditingController _feedbackController = TextEditingController();
  final List<String> _tags = [
    'Punctuality',
    'Safety',
    'Cleanliness',
    'Driver Behavior',
  ];
  final Set<String> _selectedTags = {};

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transport Feedback',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: isDarkMode ? AppColors.textMainDark : AppColors.textMainLight,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Image.network(
              'https://cdn-icons-png.flaticon.com/512/3202/3202926.png',
              height: 120,
            ), // Bus Icon
            const SizedBox(height: 24),
            Text(
              'Trip Completed: Morning Pick-up',
              style: AppTextStyles.headingMedium(isDarkMode),
            ),
            Text(
              'Bus #12 • Driver: Mr. John',
              style: AppTextStyles.bodyMedium(isDarkMode),
            ),
            const SizedBox(height: 32),

            Text(
              'How was the service?',
              style: AppTextStyles.headingMedium(isDarkMode),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _rating ? Icons.star : Icons.star_border,
                    size: 40,
                    color: Colors.amber,
                  ),
                  onPressed: () => setState(() => _rating = index + 1),
                );
              }),
            ),
            const SizedBox(height: 24),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: _tags.map((tag) {
                final isSelected = _selectedTags.contains(tag);
                return FilterChip(
                  label: Text(tag),
                  selected: isSelected,
                  onSelected: (val) {
                    setState(() {
                      if (val) {
                        _selectedTags.add(tag);
                      } else {
                        _selectedTags.remove(tag);
                      }
                    });
                  },
                  selectedColor: AppColors.primary.withValues(alpha: 0.3),
                  checkmarkColor: AppColors.primary,
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            TextField(
              controller: _feedbackController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Additional Comments (Optional)',
                filled: true,
                fillColor: isDarkMode
                    ? AppColors.surfaceDark
                    : AppColors.surfaceLight,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 32),
            PrimaryButton(
              label: 'Submit Feedback',
              onPressed: _rating > 0
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Thank you for your feedback!'),
                        ),
                      );
                    }
                  : () {}, // Disable if no rating
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
