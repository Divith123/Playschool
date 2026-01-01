import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminStaffSchedulerPage extends StatefulWidget {
  const AdminStaffSchedulerPage({super.key});

  @override
  State<AdminStaffSchedulerPage> createState() =>
      _AdminStaffSchedulerPageState();
}

class _AdminStaffSchedulerPageState extends State<AdminStaffSchedulerPage> {
  static const Color primary = Color(0xFF2bee6c);
  static const Color backgroundLight = Color(0xFFf6f8f6);
  static const Color backgroundDark = Color(0xFF102216);
  static const Color surfaceLight = Color(0xFFffffff);
  static const Color surfaceDark = Color(0xFF1a2c20);
  static const Color textMainLight = Color(0xFF0d1b12);
  static const Color textMainDark = Color(0xFFe0e7e3);
  static const Color textSubLight = Color(0xFF4e6d97);
  static const Color textSubDark = Color(0xFF8fcba3);

  final List<String> _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
  String _selectedDay = 'Mon';

  final List<Map<String, String>> _staffShifts = [
    {
      'name': 'Sarah Johnson',
      'role': 'Lead Teacher',
      'shift': 'Morning (8:00 - 13:00)',
      'status': 'Confirmed',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBrrVSxINESDiUltmNe6HzBc-NrKI7T0gpK7tExQON5ncyXEa8adlRhb36ttwNxFoXDED_LfIT2amXfY8XYsokX2ynMt3qEbqRZOo7BvbNY2_Z7U1a4d0G0JzP1G78V17zwgt6-adGuqk3mgFv0ReojGQkatvBby8ijE0bG2SGjDlIYRYIi4UsqPTUQdDP70GI6kdLhskabH5fqPoIUt1KHPJKYmT_oayvuqBWzlovv3U3KYJjDEcgGZ7yHMgPesO02sDTWpiLQPCg',
    },
    {
      'name': 'Mike Ross',
      'role': 'Assistant',
      'shift': 'Full Day (8:00 - 17:00)',
      'status': 'Confirmed',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDns3GWXpFYplBAleTn3okZ3AaMFot2iIzyxHqggrj93p9Cpl9vvvVTF4i1vXZ3ouLkozNX15LLTYlFlRoeoj_yNDLRMqYvEag3OHYPPFC-SIVepOuJros_o0pN-4EQEIb-2pC2a_MJ50PcvWzgHHaJ06EzjCSCrX1ymIlRgcC08ehvExVOYpPJ8WPeEkpDwwT2X-B4GfvWHJ_aSqLjDKAqBRlCDH1WYqpOMytwUh1M1Gc6sfz-wE2KQUKwnrLLKqmM-ic25Ykgxz8',
    },
    {
      'name': 'Emily Clark',
      'role': 'Nurse',
      'shift': 'Afternoon (12:00 - 18:00)',
      'status': 'Pending',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDsmGTrIiXsQZYy0gWVr8NmT75g79P_zcu9Dl5AMLCRiz9dH6Np-o2KUdAYYoNxEB9sdRGqgaESmZjAUSejxDVRP3nSHb-Ule6m0vRUEKExByUApSEUO0saMK3jJpJsGivM9z1cMgqqRQhbB-7wchFNRhqaHjfr3h5mwo7JZ_4jHFJKlCQoQxB-MTZKdrsuuHab9jAvIBNTE9eVwWMueWCEzaOSIChDWBmB8oJx1nK-CRu6QMypuc1gWs56xwbbjKlrgDKYVs3X8sA',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode ? backgroundDark : backgroundLight;
    final surfaceColor = isDarkMode ? surfaceDark : surfaceLight;
    final textColor = isDarkMode ? textMainDark : textMainLight;
    final subTextColor = isDarkMode ? textSubDark : textSubLight;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          'Shift Scheduler',
          style: GoogleFonts.lexend(fontWeight: FontWeight.bold),
        ),
        backgroundColor: bgColor,
        foregroundColor: textColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Add shift logic
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Day Selector
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _days.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final day = _days[index];
                final isSelected = day == _selectedDay;
                return GestureDetector(
                  onTap: () => setState(() => _selectedDay = day),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected ? primary : surfaceColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? primary
                            : (isDarkMode
                                  ? Colors.transparent
                                  : Colors.grey[300]!),
                      ),
                    ),
                    child: Text(
                      day,
                      style: GoogleFonts.lexend(
                        fontWeight: FontWeight.bold,
                        color: isSelected ? backgroundDark : subTextColor,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _staffShifts.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final shift = _staffShifts[index];
                return _buildShiftCard(
                  shift,
                  isDarkMode,
                  surfaceColor,
                  textColor,
                  subTextColor,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShiftCard(
    Map<String, String> shift,
    bool isDarkMode,
    Color surfaceColor,
    Color textColor,
    Color subTextColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
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
          CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(shift['image']!),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shift['name']!,
                  style: GoogleFonts.lexend(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                Text(
                  shift['role']!,
                  style: GoogleFonts.lexend(fontSize: 12, color: subTextColor),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.white10 : Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.access_time, size: 14, color: subTextColor),
                      const SizedBox(width: 4),
                      Text(
                        shift['shift']!,
                        style: GoogleFonts.lexend(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit_outlined, color: subTextColor),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
