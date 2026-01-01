import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';
import 'package:playschool/widgets/status_badge.dart';

class AdminVisitorLogPage extends StatefulWidget {
  const AdminVisitorLogPage({super.key});

  @override
  State<AdminVisitorLogPage> createState() => _AdminVisitorLogPageState();
}

class _AdminVisitorLogPageState extends State<AdminVisitorLogPage> {
  final _nameController = TextEditingController();
  final _purposeController = TextEditingController();
  final _hostController = TextEditingController();
  bool _isCheckingIn = true; // Toggle between Check-in form and History

  final List<Map<String, dynamic>> _visitorHistory = [
    {
      'name': 'John Doe',
      'purpose': 'Maintenance (AC Repair)',
      'host': 'Admin Office',
      'timeIn': '09:30 AM',
      'timeOut': '11:15 AM',
      'status': StatusType.neutral, // Checked Out
    },
    {
      'name': 'Sarah Smith',
      'purpose': 'Parent Inquiry',
      'host': 'Mrs. Wilson',
      'timeIn': '10:00 AM',
      'timeOut': null,
      'status': StatusType.success, // Active
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Visitor Security Log',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: isDarkMode ? AppColors.textMainDark : AppColors.textMainLight,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.history,
              color: isDarkMode
                  ? AppColors.textMainDark
                  : AppColors.textMainLight,
            ),
            onPressed: () => setState(() => _isCheckingIn = !_isCheckingIn),
            tooltip: _isCheckingIn ? 'View History' : 'New Check-In',
          ),
        ],
      ),
      body: _isCheckingIn
          ? _buildCheckInForm(isDarkMode)
          : _buildHistoryList(isDarkMode),
    );
  }

  Widget _buildCheckInForm(bool isDarkMode) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'New Visitor Check-In',
            style: AppTextStyles.headingLarge(isDarkMode),
          ),
          const SizedBox(height: 24),

          // Photo Capture Area
          Container(
            height: 200,
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
                Icon(Icons.camera_alt, size: 48, color: Colors.grey),
                const SizedBox(height: 8),
                Text(
                  'Tap to Capture Photo',
                  style: AppTextStyles.bodyMedium(isDarkMode),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          _buildTextField('Visitor Name', _nameController, isDarkMode),
          const SizedBox(height: 16),
          _buildTextField('Purpose of Visit', _purposeController, isDarkMode),
          const SizedBox(height: 16),
          _buildTextField('Meeting With (Host)', _hostController, isDarkMode),

          const SizedBox(height: 32),
          PrimaryButton(
            label: 'Issue Digital Badge',
            icon: Icons.badge,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Visitor Badge Issued!')),
              );
            },
            width: double.infinity,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    bool isDarkMode,
  ) {
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
          controller: controller,
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

  Widget _buildHistoryList(bool isDarkMode) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _visitorHistory.length,
      itemBuilder: (context, index) {
        final visitor = _visitorHistory[index];
        final isActive = visitor['timeOut'] == null;
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          color: isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(
              backgroundColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
              child: Icon(
                Icons.person,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            title: Text(
              visitor['name'],
              style: AppTextStyles.bodyLarge(
                isDarkMode,
              ).copyWith(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${visitor['purpose']} • Host: ${visitor['host']}',
                  style: AppTextStyles.bodyMedium(isDarkMode),
                ),
                const SizedBox(height: 4),
                Text(
                  'In: ${visitor['timeIn']} ${isActive ? '' : '• Out: ${visitor['timeOut']}'}',
                  style: AppTextStyles.bodyMedium(
                    isDarkMode,
                  ).copyWith(fontSize: 12),
                ),
              ],
            ),
            trailing: StatusBadge(
              label: isActive ? 'On Premise' : 'Checked Out',
              type: isActive ? StatusType.success : StatusType.neutral,
              isDarkMode: isDarkMode,
            ),
          ),
        );
      },
    );
  }
}
