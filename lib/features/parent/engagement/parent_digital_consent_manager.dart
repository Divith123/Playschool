import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';
import 'package:playschool/widgets/status_badge.dart';

class ParentDigitalConsentManagerPage extends StatefulWidget {
  const ParentDigitalConsentManagerPage({super.key});

  @override
  State<ParentDigitalConsentManagerPage> createState() =>
      _ParentDigitalConsentManagerPageState();
}

class _ParentDigitalConsentManagerPageState
    extends State<ParentDigitalConsentManagerPage> {
  final List<Map<String, dynamic>> _consents = [
    {
      'id': '1',
      'title': 'Field Trip Permission',
      'description':
          'Permission for Grade 2 visit to the City Zoo on Nov 15th. Transport provided by school bus.',
      'status': 'Pending',
      'date': 'Oct 28, 2025',
    },
    {
      'id': '2',
      'title': 'Photo Release Form',
      'description':
          'Authorization to use photos of your child for the school website and social media.',
      'status': 'Signed',
      'date': 'Sep 01, 2025',
    },
    {
      'id': '3',
      'title': 'Sunscreen Application',
      'description':
          'Consent for staff to apply sunscreen (provided by parent) during outdoor play.',
      'status': 'Signed',
      'date': 'Sep 01, 2025',
    },
    {
      'id': '4',
      'title': 'Tylenol Administration',
      'description':
          'Permission to administer Tylenol in case of high fever while waiting for pickup.',
      'status': 'Pending',
      'date': 'Oct 30, 2025',
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
          'Digital Consents',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _consents.length,
        separatorBuilder: (ctx, i) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final item = _consents[index];
          final isPending = item['status'] == 'Pending';

          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isPending
                    ? Colors.orange.withOpacity(0.5)
                    : Colors.transparent,
                width: isPending ? 1.5 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item['title'],
                        style: GoogleFonts.lexend(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                    ),
                    StatusBadge(
                      label: item['status'],
                      type: item['status'] == 'Signed'
                          ? StatusType.success
                          : StatusType.warning,
                      isDarkMode: isDarkMode,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  item['description'],
                  style: GoogleFonts.lexend(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Requested: ${item['date']}',
                      style: GoogleFonts.lexend(
                        fontSize: 12,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    if (isPending)
                      PrimaryButton(
                        label: 'Review & Sign',
                        onPressed: () => _showSignDialog(
                          context,
                          item,
                          surfaceColor,
                          textColor,
                        ),
                        width: 140,
                        height: 36,
                        fontSize: 12,
                      )
                    else
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 16,
                            color: AppColors.success,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Signed',
                            style: GoogleFonts.lexend(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.success,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showSignDialog(
    BuildContext context,
    Map<String, dynamic> item,
    Color surfaceColor,
    Color textColor,
  ) {
    bool isAgreed = false;

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: surfaceColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text(
                'Consent Agreement',
                style: GoogleFonts.lexend(color: textColor),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'I hereby give my full consent for the "${item['title']}" as described. I understand the risks involved and release the school from liability.',
                    style: GoogleFonts.lexend(color: Colors.grey, fontSize: 13),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Checkbox(
                        value: isAgreed,
                        onChanged: (val) => setState(() => isAgreed = val!),
                        activeColor: AppColors.primary,
                      ),
                      Expanded(
                        child: Text(
                          'I Agree & Sign',
                          style: GoogleFonts.lexend(
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Fake signature box
                  Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.withOpacity(0.05),
                    ),
                    child: Center(
                      child: Text(
                        '(Tap to Simulate Signature)',
                        style: GoogleFonts.lexend(
                          color: Colors.grey.withOpacity(0.5),
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: Text('Cancel', style: TextStyle(color: Colors.grey)),
                ),
                PrimaryButton(
                  label: 'Submit Signature',
                  onPressed: isAgreed
                      ? () {
                          // Update logic here
                          setState(() {
                            // Close dialog
                            Navigator.pop(ctx);
                            // Update list status
                            final index = _consents.indexOf(item);
                            _consents[index]['status'] = 'Signed';
                            // ignore: invalid_use_of_protected_member
                            this.setState(() {}); // Refresh list

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Consent Signed Successfully!'),
                                backgroundColor: AppColors.success,
                              ),
                            );
                          });
                        }
                      : null, // Disabled if not checked
                  width: 150,
                  height: 40,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
