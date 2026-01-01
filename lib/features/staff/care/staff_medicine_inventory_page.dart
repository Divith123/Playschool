import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';

import 'package:playschool/widgets/status_badge.dart';

class StaffMedicineInventoryPage extends StatefulWidget {
  const StaffMedicineInventoryPage({super.key});

  @override
  State<StaffMedicineInventoryPage> createState() =>
      _StaffMedicineInventoryPageState();
}

class _StaffMedicineInventoryPageState
    extends State<StaffMedicineInventoryPage> {
  final List<Map<String, dynamic>> _meds = [
    {
      'name': 'Acetaminophen (Tylenol)',
      'student': 'Leo Das',
      'qty': '1/2 Bottle',
      'expiry': '12/2025',
      'status': StatusType.success,
    },
    {
      'name': 'Albuterol Inhaler',
      'student': 'Emily Clark',
      'qty': 'Empty',
      'expiry': '01/2025',
      'status': StatusType.error,
    },
    {
      'name': 'EpiPen Jr',
      'student': 'Sarah Smith',
      'qty': '1 Unit',
      'expiry': '10/2024',
      'status': StatusType.warning,
    }, // Expiring soon
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Student Meds Inventory',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: isDarkMode ? AppColors.textMainDark : AppColors.textMainLight,
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _meds.length,
        separatorBuilder: (ctx, i) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final med = _meds[index];
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? AppColors.surfaceDark
                  : AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDarkMode ? Colors.white10 : Colors.grey[200]!,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.medical_services, color: Colors.red),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        med['name'],
                        style: AppTextStyles.bodyLarge(
                          isDarkMode,
                        ).copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'For: ${med['student']}',
                        style: AppTextStyles.bodyMedium(isDarkMode),
                      ),
                      Text(
                        'Qty: ${med['qty']} • Exp: ${med['expiry']}',
                        style: AppTextStyles.bodyMedium(isDarkMode),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    StatusBadge(
                      label: med['status'] == StatusType.error
                          ? 'Refill Now'
                          : (med['status'] == StatusType.warning
                                ? 'Expiring'
                                : 'OK'),
                      type: med['status'],
                      isDarkMode: isDarkMode,
                    ),
                    if (med['status'] != StatusType.success)
                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Refill Request Sent to ${med['student']}\'s Parent!',
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Request Refill',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
