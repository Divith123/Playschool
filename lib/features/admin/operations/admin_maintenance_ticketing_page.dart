import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';
import 'package:playschool/widgets/status_badge.dart';

class AdminMaintenanceTicketingPage extends StatefulWidget {
  const AdminMaintenanceTicketingPage({super.key});

  @override
  State<AdminMaintenanceTicketingPage> createState() =>
      _AdminMaintenanceTicketingPageState();
}

class _AdminMaintenanceTicketingPageState
    extends State<AdminMaintenanceTicketingPage> {
  final List<Map<String, dynamic>> _tickets = [
    {
      'id': '#1023',
      'title': 'Leaking Tap in Girls Washroom',
      'location': 'Waitara Building, Floor 1',
      'priority': 'High',
      'status': 'Open',
      'reportedBy': 'Janice (Cleaner)',
      'date': 'Oct 29',
    },
    {
      'id': '#1022',
      'title': 'Broken Chair',
      'location': 'Room 4',
      'priority': 'Low',
      'status': 'In Progress',
      'reportedBy': 'Mrs. Smith',
      'date': 'Oct 28',
    },
    {
      'id': '#1021',
      'title': 'AC Not Cooling',
      'location': 'Admin Office',
      'priority': 'Medium',
      'status': 'Resolved',
      'reportedBy': 'Principal',
      'date': 'Oct 25',
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
          'Maintenance Tickets',
          style: AppTextStyles.headingMedium(isDarkMode),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.filter_list, color: textColor),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add ticket
        },
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('New Ticket', style: TextStyle(color: Colors.white)),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _tickets.length,
        separatorBuilder: (ctx, i) => const SizedBox(height: 16),
        itemBuilder: (ctx, i) {
          return _buildTicketCard(
            _tickets[i],
            surfaceColor,
            textColor,
            isDarkMode,
          );
        },
      ),
    );
  }

  Widget _buildTicketCard(
    Map<String, dynamic> ticket,
    Color surfaceColor,
    Color textColor,
    bool isDarkMode,
  ) {
    Color priorityColor;
    switch (ticket['priority']) {
      case 'High':
        priorityColor = Colors.red;
        break;
      case 'Medium':
        priorityColor = Colors.orange;
        break;
      default:
        priorityColor = Colors.green;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  ticket['id'],
                  style: GoogleFonts.lexend(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
              StatusBadge(status: ticket['status'], isDarkMode: isDarkMode),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            ticket['title'],
            style: GoogleFonts.lexend(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                ticket['location'],
                style: GoogleFonts.lexend(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reported by',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  Text(
                    ticket['reportedBy'],
                    style: GoogleFonts.lexend(fontSize: 12, color: textColor),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Priority',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  Text(
                    ticket['priority'],
                    style: GoogleFonts.lexend(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: priorityColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
