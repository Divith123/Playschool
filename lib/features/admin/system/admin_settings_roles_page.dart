import 'package:flutter/material.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';
import 'package:playschool/widgets/search_bar.dart';

class AdminSettingsRolesPage extends StatefulWidget {
  const AdminSettingsRolesPage({super.key});

  @override
  State<AdminSettingsRolesPage> createState() => _AdminSettingsRolesPageState();
}

class _AdminSettingsRolesPageState extends State<AdminSettingsRolesPage> {
  final List<Map<String, dynamic>> _roles = [
    {
      'role': 'Admin',
      'users': '3 Users',
      'permissions': {
        'Manage Students': true,
        'Approve Payroll': true,
        'Delete Records': true,
        'Edit Settings': true,
      },
    },
    {
      'role': 'Principal',
      'users': '1 User',
      'permissions': {
        'Manage Students': true,
        'Approve Payroll': true,
        'Delete Records': false,
        'Edit Settings': false,
      },
    },
    {
      'role': 'Teacher',
      'users': '12 Users',
      'permissions': {
        'Manage Students': false,
        'Approve Payroll': false,
        'Delete Records': false,
        'Edit Settings': false,
        'View Reports': true,
      },
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Role & Permissions',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: isDarkMode ? AppColors.textMainDark : AppColors.textMainLight,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomSearchBar(
              isDarkMode: isDarkMode,
              hintText: 'Search Roles or Users...',
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _roles.length,
              separatorBuilder: (ctx, i) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return _buildRoleCard(_roles[index], isDarkMode);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleCard(Map<String, dynamic> role, bool isDarkMode) {
    return Card(
      color: isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ExpansionTile(
        title: Text(
          role['role'],
          style: AppTextStyles.headingMedium(isDarkMode).copyWith(fontSize: 18),
        ),
        subtitle: Text(
          role['users'],
          style: AppTextStyles.bodyMedium(isDarkMode),
        ),
        childrenPadding: const EdgeInsets.all(16),
        children: [
          const Divider(),
          _buildPermissionToggle(
            'Manage Students',
            role['permissions']['Manage Students'],
            isDarkMode,
          ),
          _buildPermissionToggle(
            'Approve Payroll',
            role['permissions']['Approve Payroll'],
            isDarkMode,
          ),
          _buildPermissionToggle(
            'Delete Data',
            role['permissions']['Delete Records'],
            isDarkMode,
          ),
          _buildPermissionToggle(
            'System Settings',
            role['permissions']['Edit Settings'],
            isDarkMode,
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: PrimaryButton(
              label: 'Save Changes',
              width: 160,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Permissions Updated')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionToggle(String title, bool value, bool isDarkMode) {
    return SwitchListTile(
      title: Text(title, style: AppTextStyles.bodyLarge(isDarkMode)),
      value: value,
      onChanged: (val) {},
      activeThumbColor: AppColors.primary,
      contentPadding: EdgeInsets.zero,
    );
  }
}
