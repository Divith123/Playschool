import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminLeadDashboardPage extends StatefulWidget {
  const AdminLeadDashboardPage({super.key});

  @override
  State<AdminLeadDashboardPage> createState() => _AdminLeadDashboardPageState();
}

class _AdminLeadDashboardPageState extends State<AdminLeadDashboardPage>
    with SingleTickerProviderStateMixin {
  static const Color primary = Color(0xFF2bee6c);
  static const Color backgroundLight = Color(0xFFf6f8f6);
  static const Color backgroundDark = Color(0xFF102216);
  static const Color surfaceLight = Color(0xFFffffff);
  static const Color surfaceDark = Color(0xFF1a2c20);
  static const Color textMainLight = Color(0xFF0d1b12);
  static const Color textMainDark = Color(0xFFe0e7e3);
  static const Color textSubLight = Color(0xFF4e6d97);
  static const Color textSubDark = Color(0xFF8fcba3);

  late TabController _tabController;

  final List<Map<String, dynamic>> _leads = [
    {
      'name': 'Oliver Twist',
      'program': 'Toddlers',
      'parent': 'John Twist',
      'date': '2 hrs ago',
      'status': 'New',
      'priority': 'High',
    },
    {
      'name': 'Alice Wonderland',
      'program': 'Pre-K',
      'parent': 'Martha W.',
      'date': 'Yesterday',
      'status': 'Contacted',
      'priority': 'Medium',
    },
    {
      'name': 'Peter Pan',
      'program': 'Kindergarten',
      'parent': 'Mary Pan',
      'date': 'Oct 24',
      'status': 'Tour Scheduled',
      'priority': 'Low',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode ? backgroundDark : backgroundLight;

    final textColor = isDarkMode ? textMainDark : textMainLight;
    final subTextColor = isDarkMode ? textSubDark : textSubLight;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () {
            HapticFeedback.lightImpact();
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Lead Management',
          style: GoogleFonts.lexend(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: primary,
          unselectedLabelColor: subTextColor,
          indicatorColor: primary,
          labelStyle: GoogleFonts.lexend(fontWeight: FontWeight.bold),
          tabs: const [
            Tab(text: 'New'),
            Tab(text: 'Contacted'),
            Tab(text: 'Tour'),
            Tab(text: 'Registered'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildLeadList(isDarkMode, 'New'),
          _buildLeadList(isDarkMode, 'Contacted'),
          _buildLeadList(
            isDarkMode,
            'Tour Scheduled',
          ), // Use exact string match or logic
          _buildLeadList(isDarkMode, 'Registered'),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          HapticFeedback.lightImpact();
          // Add manual lead
        },
        backgroundColor: primary,
        label: Text(
          'Add Lead',
          style: GoogleFonts.lexend(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        icon: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  Widget _buildLeadList(bool isDarkMode, String statusFilter) {
    // Filter logic placeholder (in real app)
    // For demo, we just show list or empty state
    final filteredLeads = _leads; // Should filter by status

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredLeads.length,
      itemBuilder: (context, index) {
        final lead = filteredLeads[index];
        return _buildLeadCard(lead, isDarkMode);
      },
    );
  }

  Widget _buildLeadCard(Map<String, dynamic> lead, bool isDarkMode) {
    final surfaceColor = isDarkMode ? surfaceDark : surfaceLight;
    final textColor = isDarkMode ? textMainDark : textMainLight;
    final subTextColor = isDarkMode ? textSubDark : textSubLight;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  lead['status'],
                  style: GoogleFonts.lexend(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primary,
                  ),
                ),
              ),
              Text(
                lead['date'],
                style: GoogleFonts.lexend(fontSize: 12, color: subTextColor),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: isDarkMode
                    ? Colors.grey[700]
                    : Colors.grey[200],
                child: Text(
                  lead['name'][0],
                  style: GoogleFonts.lexend(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lead['name'],
                      style: GoogleFonts.lexend(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    Text(
                      '${lead['program']} • Parent: ${lead['parent']}',
                      style: GoogleFonts.lexend(
                        fontSize: 13,
                        color: subTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.phone, color: primary),
                onPressed: () {
                  HapticFeedback.lightImpact();
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          Divider(color: isDarkMode ? Colors.white10 : Colors.grey[100]),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildActionBtn('Schedule Tour', Icons.calendar_today, textColor),
              _buildActionBtn('Message', Icons.message_outlined, textColor),
              _buildActionBtn('Reject', Icons.close, Colors.red),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionBtn(String label, IconData icon, Color color) {
    return InkWell(
      onTap: () {
        HapticFeedback.lightImpact();
        // Handle action
      },
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.lexend(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
