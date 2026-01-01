import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';
import 'package:playschool/widgets/status_badge.dart';

class AdminStaffLeaveApprovalsPage extends StatefulWidget {
  const AdminStaffLeaveApprovalsPage({super.key});

  @override
  State<AdminStaffLeaveApprovalsPage> createState() =>
      _AdminStaffLeaveApprovalsPageState();
}

class _AdminStaffLeaveApprovalsPageState
    extends State<AdminStaffLeaveApprovalsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  final List<Map<String, dynamic>> _leaveRequests = [
    {
      'name': 'Sarah Jones',
      'role': 'Class 2B Teacher',
      'type': 'Sick Leave',
      'dates': '12 Oct - 14 Oct',
      'reason': 'Severe viral fever, advised rest by doctor.',
      'status': StatusType.warning, // Pending
    },
    {
      'name': 'Mike Ross',
      'role': 'Sports Coach',
      'type': 'Casual Leave',
      'dates': '20 Nov',
      'reason': 'Personal family function.',
      'status': StatusType.warning, // Pending
    },
  ];

  final List<Map<String, dynamic>> _history = [
    {
      'name': 'Emily Clark',
      'role': 'Art Teacher',
      'type': 'Sick Leave',
      'dates': '01 Sep',
      'reason': 'Migraine.',
      'status': StatusType.success, // Approved
      'actionDate': '30 Aug',
    },
    {
      'name': 'John Doe',
      'role': 'Driver',
      'type': 'Casual Leave',
      'dates': '15 Aug',
      'reason': 'Car trouble.',
      'status': StatusType.error, // Rejected
      'remarks': 'Short notice.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Leave Approvals',
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
            Tab(text: 'Pending Requests'),
            Tab(text: 'Approval History'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildRequestList(_leaveRequests, isDarkMode, isPending: true),
          _buildRequestList(_history, isDarkMode, isPending: false),
        ],
      ),
    );
  }

  Widget _buildRequestList(
    List<Map<String, dynamic>> items,
    bool isDarkMode, {
    required bool isPending,
  }) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          color: isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight,
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['name'],
                          style: AppTextStyles.bodyLarge(
                            isDarkMode,
                          ).copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          item['role'],
                          style: AppTextStyles.bodyMedium(isDarkMode),
                        ),
                      ],
                    ),
                    StatusBadge(
                      label: isPending
                          ? 'Pending Review'
                          : (item['status'] == StatusType.success
                                ? 'Approved'
                                : 'Rejected'),
                      type: item['status'],
                      isDarkMode: isDarkMode,
                    ),
                  ],
                ),
                const Divider(height: 24),
                _buildInfoRow('Leave Type', item['type'], isDarkMode),
                const SizedBox(height: 8),
                _buildInfoRow('Dates', item['dates'], isDarkMode),
                const SizedBox(height: 8),
                _buildInfoRow('Reason', item['reason'], isDarkMode),
                if (!isPending && item['remarks'] != null) ...[
                  const SizedBox(height: 8),
                  _buildInfoRow(
                    'Remarks',
                    item['remarks'],
                    isDarkMode,
                    isError: true,
                  ),
                ],
                if (isPending) ...[
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () =>
                              _showRejectDialog(context, isDarkMode),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.error,
                            side: const BorderSide(color: AppColors.error),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Reject'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: PrimaryButton(
                          label: 'Approve',
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Leave Approved Successfully'),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(
    String label,
    String value,
    bool isDarkMode, {
    bool isError = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: AppTextStyles.bodyMedium(
              isDarkMode,
            ).copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: AppTextStyles.bodyMedium(isDarkMode).copyWith(
              color: isError ? AppColors.error : null,
              fontStyle: isError ? FontStyle.italic : null,
            ),
          ),
        ),
      ],
    );
  }

  void _showRejectDialog(BuildContext context, bool isDarkMode) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDarkMode
            ? AppColors.surfaceDark
            : AppColors.surfaceLight,
        title: Text(
          'Reject Request',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Please provide a reason for rejection:',
              style: AppTextStyles.bodyMedium(isDarkMode),
            ),
            const SizedBox(height: 12),
            TextField(
              maxLines: 2,
              decoration: InputDecoration(
                hintText: 'Remarks...',
                filled: true,
                fillColor: isDarkMode ? Colors.black12 : Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              style: AppTextStyles.bodyMedium(isDarkMode),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Leave Rejected')));
            },
            child: const Text('Reject'),
          ),
        ],
      ),
    );
  }
}
