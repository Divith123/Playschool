import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class AdminWhatsappBulkSenderPage extends StatefulWidget {
  const AdminWhatsappBulkSenderPage({super.key});

  @override
  State<AdminWhatsappBulkSenderPage> createState() =>
      _AdminWhatsappBulkSenderPageState();
}

class _AdminWhatsappBulkSenderPageState
    extends State<AdminWhatsappBulkSenderPage> {
  String _selectedGroup = 'Parents (All)';
  final TextEditingController _msgController = TextEditingController();

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
          'WhatsApp Broadcast',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel('Select Audience', textColor),
            DropdownButtonFormField<String>(
              initialValue: _selectedGroup,
              dropdownColor: surfaceColor,
              style: TextStyle(color: textColor),
              decoration: _buildInputDeco(surfaceColor),
              items: [
                'Parents (All)',
                'Parents (Class 1-5)',
                'Staff (Teaching)',
                'Staff (Non-Teaching)',
                'Prospective Leads',
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (val) => setState(() => _selectedGroup = val!),
            ),
            const SizedBox(height: 24),

            _buildLabel('Message Template', textColor),
            Container(
              height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildTemplateChip('Fee Reminder'),
                  _buildTemplateChip('Event Invite'),
                  _buildTemplateChip('Emergency Alert'),
                  _buildTemplateChip('Exam Schedule'),
                ],
              ),
            ),

            const SizedBox(height: 12),
            _buildLabel('Message Content', textColor),
            TextField(
              controller: _msgController,
              maxLines: 6,
              style: TextStyle(color: textColor),
              decoration: _buildInputDeco(surfaceColor).copyWith(
                hintText: 'Type your message or select a template...',
                helperText: 'Using official API key.',
              ),
            ),

            const SizedBox(height: 24),
            Row(
              children: [
                Icon(Icons.attachment, color: AppColors.primary),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Attach Image/PDF',
                    style: TextStyle(color: AppColors.primary),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),
            PrimaryButton(
              label: 'Send Broadcast',
              onPressed: () {
                if (_msgController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a message.')),
                  );
                  return;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Sending to $_selectedGroup...'),
                    backgroundColor: AppColors.success,
                  ),
                );
                Navigator.pop(context);
              },
              icon: Icons.send,
              backgroundColor: Color(0xFF25D366), // WhatsApp Green
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String label, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: GoogleFonts.lexend(
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }

  InputDecoration _buildInputDeco(Color surfaceColor) {
    return InputDecoration(
      filled: true,
      fillColor: surfaceColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.all(16),
    );
  }

  Widget _buildTemplateChip(String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ActionChip(
        label: Text(label),
        onPressed: () {
          setState(() {
            _msgController.text =
                'Dear Parent, this is a reminder regarding $label...';
          });
        },
      ),
    );
  }
}
