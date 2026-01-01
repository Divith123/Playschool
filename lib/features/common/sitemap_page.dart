import 'package:flutter/material.dart';
import 'package:playschool/features/admin/students/admin_admission_form_page.dart';
import 'package:playschool/features/admin/students/admin_admissions_page.dart';
import 'package:playschool/features/admin/system/admin_api_integration_page.dart';
import 'package:playschool/features/admin/operations/admin_asset_registry_page.dart';
import 'package:playschool/features/admin/operations/admin_broadcast_page.dart';
import 'package:playschool/features/admin/dashboard/admin_business_intelligence_page.dart';
import 'package:playschool/features/admin/students/admin_class_manager_page.dart';
import 'package:playschool/features/admin/dashboard/admin_dashboard_page.dart';
import 'package:playschool/features/admin/system/admin_database_backup_page.dart';
import 'package:playschool/features/admin/finance/admin_donation_manager_page.dart';
import 'package:playschool/features/admin/health/admin_epidemic_tracker_page.dart';
import 'package:playschool/features/admin/operations/admin_event_manager_page.dart';
import 'package:playschool/features/admin/finance/admin_expense_categories_page.dart';
import 'package:playschool/features/admin/finance/admin_expense_tracker_page.dart';
import 'package:playschool/features/admin/finance/admin_finance_page.dart';
import 'package:playschool/features/admin/transport/admin_fuel_log_page.dart';
import 'package:playschool/features/admin/operations/admin_inventory_page.dart';
import 'package:playschool/features/admin/operations/admin_key_cabinet_page.dart';
import 'package:playschool/features/admin/system/admin_kiosk_analytics_page.dart';
import 'package:playschool/features/admin/dashboard/admin_lead_dashboard_page.dart';
import 'package:playschool/features/admin/operations/admin_maintenance_ticketing_page.dart';
import 'package:playschool/features/admin/operations/admin_menu_planner_page.dart';
import 'package:playschool/features/admin/operations/admin_newsletter_editor_page.dart';
import 'package:playschool/features/admin/staff/admin_payroll_page.dart';
import 'package:playschool/features/admin/learning/admin_resource_sharing_page.dart';
import 'package:playschool/features/admin/operations/admin_school_calendar_page.dart';
import 'package:playschool/features/admin/system/admin_seo_manager_page.dart';
import 'package:playschool/features/admin/system/admin_settings_roles_page.dart';
import 'package:playschool/features/admin/staff/admin_staff_leave_approvals_page.dart';
import 'package:playschool/features/admin/staff/admin_staff_profile_page.dart';
import 'package:playschool/features/admin/staff/admin_staff_scheduler_page.dart';
import 'package:playschool/features/admin/system/admin_storage_manager_page.dart';
import 'package:playschool/features/admin/students/admin_student_add_edit_page.dart';
import 'package:playschool/features/admin/students/admin_student_profile_page.dart';
import 'package:playschool/features/admin/system/admin_system_audit_logs_page.dart';
import 'package:playschool/features/admin/finance/admin_tax_manager_page.dart';
import 'package:playschool/features/admin/transport/admin_transport_page.dart';
import 'package:playschool/features/admin/system/admin_user_audit_log_page.dart';
import 'package:playschool/features/admin/system/admin_vendor_manager_page.dart';
import 'package:playschool/features/admin/reception/admin_visitor_log_page.dart';
import 'package:playschool/features/admin/students/admissions_page.dart';
import 'package:playschool/features/admin/operations/marketing_automation_page.dart';
import 'package:playschool/features/auth/change_password_page.dart';
import 'package:playschool/features/auth/forgot_password_page.dart';
import 'package:playschool/features/auth/login_page.dart';
import 'package:playschool/features/auth/onboarding_walkthrough_page.dart';
import 'package:playschool/features/auth/register_page.dart';
import 'package:playschool/features/auth/splash_screen.dart';
import 'package:playschool/features/driver/driver_maintenance_log_page.dart';
import 'package:playschool/features/driver/driver_route_detail_page.dart';
import 'package:playschool/features/driver/driver_route_optimizer_page.dart';
import 'package:playschool/features/driver/driver_trip_log_page.dart';
import 'package:playschool/features/driver/driver_vehicle_incident_page.dart';
import 'package:playschool/features/admin/finance/accountant_reconciliation_page.dart';
import 'package:playschool/features/common/app_settings_page.dart';
import 'package:playschool/features/common/common_help_support_page.dart';
import 'package:playschool/features/common/privacy_policy_page.dart';
import 'package:playschool/features/public/public_enquiry_page.dart';
import 'package:playschool/features/common/terms_and_conditions_page.dart';
import 'package:playschool/features/parent/services/parent_activity_log_page.dart';
import 'package:playschool/features/parent/academic/parent_calendar_page.dart';
import 'package:playschool/features/parent/communication/parent_chat_page.dart';
import 'package:playschool/features/parent/dashboard/parent_dashboard_page.dart';
import 'package:playschool/features/parent/dashboard/parent_edit_profile_page.dart';
import 'package:playschool/features/parent/health/parent_emergency_contacts_red_page.dart';
import 'package:playschool/features/parent/services/parent_event_registration_page.dart';
import 'package:playschool/features/parent/finance/parent_fee_structure_page.dart';
import 'package:playschool/features/parent/services/parent_gallery_page.dart';
import 'package:playschool/features/parent/services/parent_gate_pass_page.dart';
import 'package:playschool/features/parent/academic/parent_homework_view_page.dart';
import 'package:playschool/features/parent/finance/parent_installment_planner_page.dart';
import 'package:playschool/features/parent/finance/parent_invoices_page.dart';
import 'package:playschool/features/parent/engagement/parent_kiosk_mode_page.dart';
import 'package:playschool/features/parent/services/parent_lost_found_page.dart';
import 'package:playschool/features/parent/engagement/parent_memory_lane_page.dart';
import 'package:playschool/features/parent/communication/parent_messages_page.dart';
import 'package:playschool/features/parent/dashboard/parent_notification_center_page.dart';
import 'package:playschool/features/parent/finance/parent_payment_history_page.dart';
import 'package:playschool/features/parent/services/parent_pickup_manager_page.dart';
import 'package:playschool/features/parent/academic/parent_portfolio_deep_dive_page.dart';
import 'package:playschool/features/parent/dashboard/parent_profile_page.dart';
import 'package:playschool/features/parent/engagement/parent_referral_program_page.dart';
import 'package:playschool/features/parent/academic/parent_report_card_view_page.dart';
import 'package:playschool/features/parent/transport/parent_rider_profile_page.dart';
import 'package:playschool/features/parent/finance/parent_scholarship_apply_page.dart';
import 'package:playschool/features/parent/academic/parent_school_handbook_page.dart';
import 'package:playschool/features/parent/health/parent_sleep_analytics_page.dart';
import 'package:playschool/features/parent/services/parent_slot_booking_page.dart';
import 'package:playschool/features/parent/dashboard/parent_switch_child_page.dart';
import 'package:playschool/features/parent/finance/parent_transaction_receipt_page.dart';
import 'package:playschool/features/parent/communication/parent_transport_feedback_page.dart';
import 'package:playschool/features/parent/transport/parent_transport_tracking_page.dart';
import 'package:playschool/features/staff/care/staff_activity_page.dart';
import 'package:playschool/features/staff/academic/staff_assessment_builder_page.dart';
import 'package:playschool/features/staff/operations/staff_attendance_geo_fence_page.dart';
import 'package:playschool/features/staff/academic/staff_attendance_page.dart';
import 'package:playschool/features/staff/academic/staff_class_switcher_page.dart';
import 'package:playschool/features/staff/operations/staff_cleaning_checklist_page.dart';
import 'package:playschool/features/staff/operations/staff_compliance_vault_page.dart';
import 'package:playschool/features/staff/academic/staff_curriculum_planner_page.dart';
import 'package:playschool/features/staff/care/staff_daily_agenda_page.dart';
import 'package:playschool/features/staff/care/staff_daily_health_check_page.dart';
import 'package:playschool/features/staff/dashboard/staff_dashboard_page.dart';
import 'package:playschool/features/staff/academic/staff_field_trip_tracker_page.dart';
import 'package:playschool/features/staff/operations/staff_fire_drill_log_page.dart';
import 'package:playschool/features/staff/academic/staff_homework_assign_page.dart';
import 'package:playschool/features/staff/care/staff_hygiene_audit_page.dart';
import 'package:playschool/features/staff/operations/staff_incident_report_page.dart';
import 'package:playschool/features/staff/communication/staff_internal_chat_page.dart';
import 'package:playschool/features/staff/operations/staff_leave_apply_page.dart';
import 'package:playschool/features/staff/academic/staff_lesson_planner_page.dart';
import 'package:playschool/features/staff/academic/staff_library_manager_page.dart';
import 'package:playschool/features/staff/operations/staff_lunch_order_page.dart';
import 'package:playschool/features/staff/care/staff_medicine_inventory_page.dart';
import 'package:playschool/features/staff/care/staff_medicine_log_page.dart';
import 'package:playschool/features/staff/communication/staff_messages_page.dart';
import 'package:playschool/features/staff/care/staff_milestone_tracking_page.dart';
import 'package:playschool/features/staff/academic/staff_my_attendance_page.dart';
import 'package:playschool/features/staff/operations/staff_performance_review_page.dart';
import 'package:playschool/features/staff/dashboard/staff_personal_todo_page.dart';
import 'package:playschool/features/staff/care/staff_potty_training_chart_page.dart';
import 'package:playschool/features/staff/dashboard/staff_profile_page.dart';
import 'package:playschool/features/staff/academic/staff_report_card_generator_page.dart';
import 'package:playschool/features/staff/operations/staff_substitution_finder_page.dart';
import 'package:playschool/features/staff/operations/staff_training_hub_page.dart';

class SitemapPage extends StatelessWidget {
  const SitemapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('App Sitemap (Dev)')),
      body: ListView(
        children: [
          _buildHeader('Admin'),

          ListTile(
            title: Text('AdminAdmissionFormPage'),
            subtitle: Text('admin_admission_form_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminAdmissionFormPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('AdminAdmissionsPage'),
            subtitle: Text('admin_admissions_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminAdmissionsPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('AdminApiIntegrationPage'),
            subtitle: Text('admin_api_integration_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminApiIntegrationPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('AdminAssetRegistryPage'),
            subtitle: Text('admin_asset_registry_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminAssetRegistryPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('AdminBroadcastPage'),
            subtitle: Text('admin_broadcast_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminBroadcastPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('AdminBusinessIntelligencePage'),
            subtitle: Text('admin_business_intelligence_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AdminBusinessIntelligencePage(),
              ),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('AdminClassManagerPage'),
            subtitle: Text('admin_class_manager_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminClassManagerPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('AdminDashboardPage'),
            subtitle: Text('admin_dashboard_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminDashboardPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('AdminDatabaseBackupPage'),
            subtitle: Text('admin_database_backup_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminDatabaseBackupPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('AdminDonationManagerPage'),
            subtitle: Text('admin_donation_manager_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminDonationManagerPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('AdminEpidemicTrackerPage'),
            subtitle: Text('admin_epidemic_tracker_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminEpidemicTrackerPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('AdminEventManagerPage'),
            subtitle: Text('admin_event_manager_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminEventManagerPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('AdminExpenseCategoriesPage'),
            subtitle: Text('admin_expense_categories_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminExpenseCategoriesPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('AdminExpenseTrackerPage'),
            subtitle: Text('admin_expense_tracker_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminExpenseTrackerPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('AdminFinancePage'),
            subtitle: Text('admin_finance_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminFinancePage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('AdminFuelLogPage'),
            subtitle: Text('admin_fuel_log_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminFuelLogPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('AdminInventoryPage'),
            subtitle: Text('admin_inventory_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminInventoryPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('AdminKeyCabinetPage'),
            subtitle: Text('admin_key_cabinet_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminKeyCabinetPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('AdminKioskAnalyticsPage'),
            subtitle: Text('admin_kiosk_analytics_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminKioskAnalyticsPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('AdminLeadDashboardPage'),
            subtitle: Text('admin_lead_dashboard_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminLeadDashboardPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('AdminMaintenanceTicketingPage'),
            subtitle: Text('admin_maintenance_ticketing_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AdminMaintenanceTicketingPage(),
              ),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('AdminMenuPlannerPage'),
            subtitle: Text('admin_menu_planner_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminMenuPlannerPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('AdminNewsletterEditorPage'),
            subtitle: Text('admin_newsletter_editor_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminNewsletterEditorPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('AdminPayrollPage'),
            subtitle: Text('admin_payroll_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminPayrollPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('AdminResourceSharingPage'),
            subtitle: Text('admin_resource_sharing_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminResourceSharingPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('AdminSchoolCalendarPage'),
            subtitle: Text('admin_school_calendar_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminSchoolCalendarPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('AdminSeoManagerPage'),
            subtitle: Text('admin_seo_manager_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminSeoManagerPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('AdminSettingsRolesPage'),
            subtitle: Text('admin_settings_roles_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminSettingsRolesPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('AdminStaffLeaveApprovalsPage'),
            subtitle: Text('admin_staff_leave_approvals_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminStaffLeaveApprovalsPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('AdminStaffProfilePage'),
            subtitle: Text('admin_staff_profile_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminStaffProfilePage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('AdminStaffSchedulerPage'),
            subtitle: Text('admin_staff_scheduler_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminStaffSchedulerPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('AdminStorageManagerPage'),
            subtitle: Text('admin_storage_manager_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminStorageManagerPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('AdminStudentAddEditPage'),
            subtitle: Text('admin_student_add_edit_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminStudentAddEditPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('AdminStudentProfilePage'),
            subtitle: Text('admin_student_profile_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminStudentProfilePage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('AdminSystemAuditLogsPage'),
            subtitle: Text('admin_system_audit_logs_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminSystemAuditLogsPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('AdminTaxManagerPage'),
            subtitle: Text('admin_tax_manager_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminTaxManagerPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('AdminTransportPage'),
            subtitle: Text('admin_transport_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminTransportPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('AdminUserAuditLogPage'),
            subtitle: Text('admin_user_audit_log_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminUserAuditLogPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('AdminVendorManagerPage'),
            subtitle: Text('admin_vendor_manager_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminVendorManagerPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('AdminVisitorLogPage'),
            subtitle: Text('admin_visitor_log_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminVisitorLogPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('AdmissionsPage'),
            subtitle: Text('admissions_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdmissionsPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('MarketingAutomationPage'),
            subtitle: Text('marketing_automation_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => MarketingAutomationPage()),
            ),
          ),
          Divider(),

          _buildHeader('Auth'),

          ListTile(
            title: Text('ChangePasswordPage'),
            subtitle: Text('change_password_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ChangePasswordPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('ForgotPasswordPage'),
            subtitle: Text('forgot_password_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ForgotPasswordPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('LoginPage'),
            subtitle: Text('login_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => LoginPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('OnboardingWalkthroughPage'),
            subtitle: Text('onboarding_walkthrough_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => OnboardingWalkthroughPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('RegisterPage'),
            subtitle: Text('register_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => RegisterPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('SplashScreen'),
            subtitle: Text('splash_screen.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => SplashScreen()),
            ),
          ),
          Divider(),

          _buildHeader('Driver'),

          ListTile(
            title: Text('DriverMaintenanceLogPage'),
            subtitle: Text('driver_maintenance_log_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => DriverMaintenanceLogPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('DriverRouteDetailPage'),
            subtitle: Text('driver_route_detail_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => DriverRouteDetailPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('DriverRouteOptimizerPage'),
            subtitle: Text('driver_route_optimizer_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => DriverRouteOptimizerPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('DriverTripLogPage'),
            subtitle: Text('driver_trip_log_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => DriverTripLogPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('DriverVehicleIncidentPage'),
            subtitle: Text('driver_vehicle_incident_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => DriverVehicleIncidentPage()),
            ),
          ),
          Divider(),

          _buildHeader('Other'),

          ListTile(
            title: Text('AccountantReconciliationPage'),
            subtitle: Text('accountant_reconciliation_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AccountantReconciliationPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('AppSettingsPage'),
            subtitle: Text('app_settings_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AppSettingsPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('CommonHelpSupportPage'),
            subtitle: Text('common_help_support_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CommonHelpSupportPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('PrivacyPolicyPage'),
            subtitle: Text('privacy_policy_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => PrivacyPolicyPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('PublicEnquiryPage'),
            subtitle: Text('public_enquiry_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => PublicEnquiryPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('TermsAndConditionsPage'),
            subtitle: Text('terms_and_conditions_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => TermsAndConditionsPage()),
            ),
          ),
          Divider(),

          _buildHeader('Parent'),

          ListTile(
            title: Text('ParentActivityLogPage'),
            subtitle: Text('parent_activity_log_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ParentActivityLogPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('ParentCalendarPage'),
            subtitle: Text('parent_calendar_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ParentCalendarPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('ParentChatPage'),
            subtitle: Text('parent_chat_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ParentChatPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('ParentDashboardPage'),
            subtitle: Text('parent_dashboard_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ParentDashboardPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('ParentEditProfilePage'),
            subtitle: Text('parent_edit_profile_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ParentEditProfilePage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('ParentEmergencyContactsRedPage'),
            subtitle: Text('parent_emergency_contacts_red_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ParentEmergencyContactsRedPage(),
              ),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('ParentEventRegistrationPage'),
            subtitle: Text('parent_event_registration_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ParentEventRegistrationPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('ParentFeeStructurePage'),
            subtitle: Text('parent_fee_structure_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ParentFeeStructurePage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('ParentGalleryPage'),
            subtitle: Text('parent_gallery_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ParentGalleryPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('ParentGatePassPage'),
            subtitle: Text('parent_gate_pass_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ParentGatePassPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('ParentHomeworkViewPage'),
            subtitle: Text('parent_homework_view_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ParentHomeworkViewPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('ParentInstallmentPlannerPage'),
            subtitle: Text('parent_installment_planner_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ParentInstallmentPlannerPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('ParentInvoicesPage'),
            subtitle: Text('parent_invoices_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ParentInvoicesPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('ParentKioskModePage'),
            subtitle: Text('parent_kiosk_mode_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ParentKioskModePage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('ParentLostFoundPage'),
            subtitle: Text('parent_lost_found_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ParentLostFoundPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('ParentMemoryLanePage'),
            subtitle: Text('parent_memory_lane_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ParentMemoryLanePage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('ParentMessagesPage'),
            subtitle: Text('parent_messages_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ParentMessagesPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('ParentNotificationCenterPage'),
            subtitle: Text('parent_notification_center_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ParentNotificationCenterPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('ParentPaymentHistoryPage'),
            subtitle: Text('parent_payment_history_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ParentPaymentHistoryPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('ParentPickupManagerPage'),
            subtitle: Text('parent_pickup_manager_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ParentPickupManagerPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('ParentPortfolioDeepDivePage'),
            subtitle: Text('parent_portfolio_deep_dive_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ParentPortfolioDeepDivePage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('ParentProfilePage'),
            subtitle: Text('parent_profile_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ParentProfilePage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('ParentReferralProgramPage'),
            subtitle: Text('parent_referral_program_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ParentReferralProgramPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('ParentReportCardViewPage'),
            subtitle: Text('parent_report_card_view_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ParentReportCardViewPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('ParentRiderProfilePage'),
            subtitle: Text('parent_rider_profile_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ParentRiderProfilePage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('ParentScholarshipApplyPage'),
            subtitle: Text('parent_scholarship_apply_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ParentScholarshipApplyPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('ParentSchoolHandbookPage'),
            subtitle: Text('parent_school_handbook_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ParentSchoolHandbookPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('ParentSleepAnalyticsPage'),
            subtitle: Text('parent_sleep_analytics_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ParentSleepAnalyticsPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('ParentSlotBookingPage'),
            subtitle: Text('parent_slot_booking_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ParentSlotBookingPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('ParentSwitchChildPage'),
            subtitle: Text('parent_switch_child_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ParentSwitchChildPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('ParentTransactionReceiptPage'),
            subtitle: Text('parent_transaction_receipt_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ParentTransactionReceiptPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('ParentTransportFeedbackPage'),
            subtitle: Text('parent_transport_feedback_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ParentTransportFeedbackPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('ParentTransportTrackingPage'),
            subtitle: Text('parent_transport_tracking_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ParentTransportTrackingPage()),
            ),
          ),
          Divider(),

          _buildHeader('Staff'),

          ListTile(
            title: Text('StaffActivityPage'),
            subtitle: Text('staff_activity_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => StaffActivityPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('StaffAssessmentBuilderPage'),
            subtitle: Text('staff_assessment_builder_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => StaffAssessmentBuilderPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('StaffAttendanceGeoFencePage'),
            subtitle: Text('staff_attendance_geo_fence_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => StaffAttendanceGeoFencePage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('StaffAttendancePage'),
            subtitle: Text('staff_attendance_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => StaffAttendancePage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('StaffClassSwitcherPage'),
            subtitle: Text('staff_class_switcher_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => StaffClassSwitcherPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('StaffCleaningChecklistPage'),
            subtitle: Text('staff_cleaning_checklist_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => StaffCleaningChecklistPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('StaffComplianceVaultPage'),
            subtitle: Text('staff_compliance_vault_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => StaffComplianceVaultPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('StaffCurriculumPlannerPage'),
            subtitle: Text('staff_curriculum_planner_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => StaffCurriculumPlannerPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('StaffDailyAgendaPage'),
            subtitle: Text('staff_daily_agenda_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => StaffDailyAgendaPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('StaffDailyHealthCheckPage'),
            subtitle: Text('staff_daily_health_check_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => StaffDailyHealthCheckPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('StaffDashboardPage'),
            subtitle: Text('staff_dashboard_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => StaffDashboardPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('StaffFieldTripTrackerPage'),
            subtitle: Text('staff_field_trip_tracker_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => StaffFieldTripTrackerPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('StaffFireDrillLogPage'),
            subtitle: Text('staff_fire_drill_log_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => StaffFireDrillLogPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('StaffHomeworkAssignPage'),
            subtitle: Text('staff_homework_assign_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => StaffHomeworkAssignPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('StaffHygieneAuditPage'),
            subtitle: Text('staff_hygiene_audit_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => StaffHygieneAuditPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('StaffIncidentReportPage'),
            subtitle: Text('staff_incident_report_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => StaffIncidentReportPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('StaffInternalChatPage'),
            subtitle: Text('staff_internal_chat_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => StaffInternalChatPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('StaffLeaveApplyPage'),
            subtitle: Text('staff_leave_apply_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => StaffLeaveApplyPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('StaffLessonPlannerPage'),
            subtitle: Text('staff_lesson_planner_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => StaffLessonPlannerPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('StaffLibraryManagerPage'),
            subtitle: Text('staff_library_manager_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => StaffLibraryManagerPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('StaffLunchOrderPage'),
            subtitle: Text('staff_lunch_order_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => StaffLunchOrderPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('StaffMedicineInventoryPage'),
            subtitle: Text('staff_medicine_inventory_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => StaffMedicineInventoryPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('StaffMedicineLogPage'),
            subtitle: Text('staff_medicine_log_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => StaffMedicineLogPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('StaffMessagesPage'),
            subtitle: Text('staff_messages_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => StaffMessagesPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('StaffMilestoneTrackingPage'),
            subtitle: Text('staff_milestone_tracking_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => StaffMilestoneTrackingPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('StaffMyAttendancePage'),
            subtitle: Text('staff_my_attendance_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => StaffMyAttendancePage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('StaffPerformanceReviewPage'),
            subtitle: Text('staff_performance_review_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => StaffPerformanceReviewPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('StaffPersonalTodoPage'),
            subtitle: Text('staff_personal_todo_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => StaffPersonalTodoPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('StaffPottyTrainingChartPage'),
            subtitle: Text('staff_potty_training_chart_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => StaffPottyTrainingChartPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('StaffProfilePage'),
            subtitle: Text('staff_profile_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => StaffProfilePage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('StaffReportCardGeneratorPage'),
            subtitle: Text('staff_report_card_generator_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => StaffReportCardGeneratorPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('StaffSubstitutionFinderPage'),
            subtitle: Text('staff_substitution_finder_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => StaffSubstitutionFinderPage()),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('StaffTrainingHubPage'),
            subtitle: Text('staff_training_hub_page.dart'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => StaffTrainingHubPage()),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[200],
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.black,
        ),
      ),
    );
  }
}
