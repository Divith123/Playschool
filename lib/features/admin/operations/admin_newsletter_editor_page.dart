import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class AdminNewsletterEditorPage extends StatefulWidget {
  const AdminNewsletterEditorPage({super.key});

  @override
  State<AdminNewsletterEditorPage> createState() =>
      _AdminNewsletterEditorPageState();
}

class _AdminNewsletterEditorPageState extends State<AdminNewsletterEditorPage> {
  String _selectedRecipient = 'All Parents';

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Newsletter Editor',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: isDarkMode ? AppColors.textMainDark : AppColors.textMainLight,
        ),
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.visibility),
            label: const Text('Preview'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipients
            Text(
              'To:',
              style: AppTextStyles.bodyMedium(
                isDarkMode,
              ).copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? AppColors.surfaceDark
                    : AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDarkMode ? Colors.white10 : Colors.grey[300]!,
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedRecipient,
                  isExpanded: true,
                  dropdownColor: isDarkMode
                      ? AppColors.surfaceDark
                      : AppColors.surfaceLight,
                  items: ['All Parents', 'Teachers Only', 'Class 2B Parents']
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: AppTextStyles.bodyLarge(isDarkMode),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (val) => setState(() => _selectedRecipient = val!),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Editor
            _buildTextField('Newsletter Title', isDarkMode),
            const SizedBox(height: 16),

            // Image Upload Placeholder
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.white10 : Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDarkMode ? Colors.white24 : Colors.grey[300]!,
                  style: BorderStyle.solid,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_photo_alternate, size: 48, color: Colors.grey),
                  const SizedBox(height: 8),
                  Text(
                    'Upload Cover Image',
                    style: AppTextStyles.bodyMedium(isDarkMode),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            _buildTextField('Body Content', isDarkMode, maxLines: 10),

            const SizedBox(height: 32),
            PrimaryButton(
              label: 'Send Newsletter',
              icon: Icons.send,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Confirmation'),
                    content: Text('Send to $_selectedRecipient?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: Text('Cancel'),
                      ),
                      PrimaryButton(
                        label: 'Confirm Send',
                        onPressed: () {
                          Navigator.pop(ctx);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Newsletter Sent!')),
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
    );
  }

  Widget _buildTextField(String label, bool isDarkMode, {int maxLines = 1}) {
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
          maxLines: maxLines,
          style: AppTextStyles.bodyLarge(isDarkMode),
          decoration: InputDecoration(
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
