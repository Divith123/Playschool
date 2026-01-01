import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StaffAttendancePage extends StatefulWidget {
  const StaffAttendancePage({super.key});

  @override
  State<StaffAttendancePage> createState() => _StaffAttendancePageState();
}

class _StaffAttendancePageState extends State<StaffAttendancePage> {
  static const Color primary = Color(0xFF2bee6c);
  static const Color backgroundLight = Color(0xFFf6f8f6);
  static const Color backgroundDark = Color(0xFF102216);
  static const Color surfaceLight = Color(0xFFffffff);
  static const Color surfaceDark = Color(0xFF1a2c20);

  String selectedClassroom = 'caterpillars';
  String checkMode = 'in'; // 'in' or 'out'

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode ? backgroundDark : backgroundLight;
    final surfaceColor = isDarkMode ? surfaceDark : surfaceLight;
    final textColor = isDarkMode ? Colors.white : Colors.blueGrey[900]!;
    final subTextColor = isDarkMode
        ? Colors.blueGrey[400]!
        : Colors.blueGrey[500]!;

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  color: bgColor.withValues(alpha: 0.95),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildCircleButton(
                            icon: Icons.menu,
                            onTap: () => Navigator.pop(context),
                            isDarkMode: isDarkMode,
                          ),
                          Text(
                            'Wednesday, Oct 24',
                            style: GoogleFonts.lexend(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          _buildProfileButton(),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Classroom Selector
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: surfaceColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isDarkMode
                                ? Colors.blueGrey[700]!
                                : Colors.blueGrey[200]!,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedClassroom,
                            isExpanded: true,
                            icon: const Icon(Icons.expand_more),
                            style: GoogleFonts.lexend(
                              color: textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            dropdownColor: surfaceColor,
                            items: const [
                              DropdownMenuItem(
                                value: 'caterpillars',
                                child: Text('The Caterpillars (Toddlers)'),
                              ),
                              DropdownMenuItem(
                                value: 'butterflies',
                                child: Text('The Butterflies (Pre-K)'),
                              ),
                              DropdownMenuItem(
                                value: 'grasshoppers',
                                child: Text('The Grasshoppers (K)'),
                              ),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                setState(() => selectedClassroom = value);
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Stats Overview
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    _buildStatCard(
                                      label: 'Checked In',
                                      value: '12',
                                      bgColor: isDarkMode
                                          ? primary.withValues(alpha: 0.1)
                                          : primary.withValues(alpha: 0.2),
                                      borderColor: primary.withValues(alpha: 0.2),
                                      textColor: textColor,
                                      labelColor: isDarkMode
                                          ? Colors.blueGrey[300]!
                                          : Colors.blueGrey[700]!,
                                      isDarkMode: isDarkMode,
                                    ),
                                    const SizedBox(width: 12),
                                    _buildStatCard(
                                      label: 'Absent',
                                      value: '3',
                                      bgColor: surfaceColor,
                                      borderColor: isDarkMode
                                          ? Colors.blueGrey[700]!
                                          : Colors.blueGrey[100]!,
                                      textColor: textColor,
                                      labelColor: subTextColor,
                                      isDarkMode: isDarkMode,
                                    ),
                                    const SizedBox(width: 12),
                                    _buildStatCard(
                                      label: 'Expected',
                                      value: '5',
                                      bgColor: surfaceColor,
                                      borderColor: isDarkMode
                                          ? Colors.blueGrey[700]!
                                          : Colors.blueGrey[100]!,
                                      textColor: textColor,
                                      labelColor: subTextColor,
                                      isDarkMode: isDarkMode,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: _StickyHeaderDelegate(
                          child: Container(
                            color: bgColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: Column(
                              children: [
                                // Segmented Control
                                Container(
                                  height: 48,
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: isDarkMode
                                        ? Colors.blueGrey[800]
                                        : Colors.blueGrey[200],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: _buildSegmentButton(
                                          'in',
                                          'Check In',
                                          isDarkMode,
                                        ),
                                      ),
                                      Expanded(
                                        child: _buildSegmentButton(
                                          'out',
                                          'Check Out',
                                          isDarkMode,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12),
                                // Search
                                Container(
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: surfaceColor,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.05),
                                        blurRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Search student name...',
                                      hintStyle: GoogleFonts.lexend(
                                        color: Colors.blueGrey[400],
                                      ),
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: Colors.blueGrey[400],
                                      ),
                                      border: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 12,
                                          ),
                                    ),
                                    style: GoogleFonts.lexend(color: textColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          maxHeight: 120,
                          minHeight: 120,
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate([
                            _buildStudentItem(
                              name: 'Liam Smith',
                              status: 'Checked In',
                              time: '8:15 AM',
                              image:
                                  'https://lh3.googleusercontent.com/aida-public/AB6AXuAcLpS2XTY5bsA2Pkl6sGFHr6pLq5awnbf3gOhszAmlgh0wrtnV3sxVJ6TfMhpJYcvYvitF0TUFuLyZEYcQYvZMTuO3ZCLJJHcodjgr-bvzJNBde9V0UFkBcLzpqkXysIIHoVySJBclVz0IPyQW937s5nqh69hJHRvcoAk-WJbXULBbY1BoT5A3kNQ7mrdg7Y-Gz_8a2bQR_Z-yLEw8dbnTI0_I-6-w3FoA98I2bP5g9sqxPfFKOeEulqc59mCFTIvaGZVIJgcTHE4',
                              isDarkMode: isDarkMode,
                              surfaceColor: surfaceColor,
                              textColor: textColor,
                              subTextColor: subTextColor,
                            ),
                            const SizedBox(height: 12),
                            _buildStudentItem(
                              name: 'Sarah Johnson',
                              status: 'Pending',
                              note: 'Dad (Pick-up)',
                              image:
                                  'https://lh3.googleusercontent.com/aida-public/AB6AXuBzM0mc46h-cKSoDzXVObxiddfetd5xyrVoXZEhCntwv_xS23gnpOzjnvtPr0uzdj7POOF0HvFAO1pKEM78E00HJwAI8KpJJzWiPZ-nIeFXIyrWLHKfshWuTB92Eh227rmBh0rN0h2_bMu6UDGoApTDC4PG_O9zNHd3BR6IAahUCfcyxAX80rwTpCGwTBdCpFFXE7CWBiAOpOZzG5nkWVRURkTKeOxgOIL5ny2qkBs2R0VtJbE_TzqYehmUTUoauJ4C6sritZCIJ5g',
                              isDarkMode: isDarkMode,
                              surfaceColor: surfaceColor,
                              textColor: textColor,
                              subTextColor: subTextColor,
                            ),
                            const SizedBox(height: 12),
                            _buildStudentItem(
                              name: 'Noah Brown',
                              status: 'Pending',
                              note: 'Mom (Drop-off)',
                              image:
                                  'https://lh3.googleusercontent.com/aida-public/AB6AXuCnt0DF8QJgI6cCtBY3OFdYdyW7XIEvuz98zbMPfepc-yGKNbwnBFLbmSlPiLBk7vCM7sFCEwaBv1NnkUR3rRew4Czm0MQyY6jCWqd7vwhz0QqxaKJHbccvyzGL4_AJHyDPLdTouxLqYeCTYQF-xj9FWiB0UVr2YdOJX5r4npykK5C4z0-TO_IqRKXOtvGtQJsK411ZN83-vGUzqnxGlp1ZrUo9djNN-izWsucussDkyiBGeuKnQCMGDTByZ6YKTw9gHIQMkzYLIYQ',
                              isDarkMode: isDarkMode,
                              surfaceColor: surfaceColor,
                              textColor: textColor,
                              subTextColor: subTextColor,
                            ),
                            const SizedBox(height: 12),
                            _buildStudentItem(
                              name: 'Emma Wilson',
                              status: 'Absent',
                              image:
                                  'https://lh3.googleusercontent.com/aida-public/AB6AXuBEhRqkXqjDSkb9cof_fyUA1xmGZD2Sb01XIUzoxsdiV6DyC_OFdFAgnOsU76cYjGL5xX36SSV2GNMhVoK6BJcePQDQEZDvMNaHE3KPa-VJTZdFN-uAoYGH7r9rmg7jyxK84RLQDJfC_sbQOW3pZ_vy__jKA6OsJj-EL5uhjoZqkgUG-nFz5ag5ByRcoR43_VLlu1Cgi3JaehkqYl2Mr7J7kqJ4ZruZXymFvsjL2jIt6XDi2TiXe6CTh4sILJYHMvJbRFh_8nzInwA',
                              isDarkMode: isDarkMode,
                              surfaceColor: surfaceColor,
                              textColor: textColor,
                              subTextColor: subTextColor,
                            ),
                            const SizedBox(height: 12),
                            _buildStudentItem(
                              name: 'Jayden Lee',
                              status: 'Pending',
                              note: 'Grandma',
                              image:
                                  'https://lh3.googleusercontent.com/aida-public/AB6AXuBuyXqq36eBzStpTk9EF8BmIkLqa9nSM4uG_D43HAFdPqHep9ossbMBMh1DyQfk2mv4nSiXx7fVtmCXa-WZwoO5j4wNo40hHm6HZfi0JCOITW1STHkLxJ4iT2R8s2hO5E-JfRleQTGRBLjmGSpboxc-HpK-alPC-PvC7feE0eTlWR87avTBG9rI1iA9BlidyDm4DHJk_jdZ-ABPfyuU3j1NWfKj0-d923uvlgw3lP04iaFEYmUHho_OQZV6XLsUinwi-ETjDavsIIU',
                              isDarkMode: isDarkMode,
                              surfaceColor: surfaceColor,
                              textColor: textColor,
                              subTextColor: subTextColor,
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: primary.withValues(alpha: 0.25),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.qr_code_scanner, size: 28),
                  label: Text(
                    'Scan QR',
                    style: GoogleFonts.lexend(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    foregroundColor: backgroundDark,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleButton({
    required IconData icon,
    required VoidCallback onTap,
    required bool isDarkMode,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
          border: Border.all(color: Colors.transparent),
        ),
        child: Icon(
          icon,
          color: isDarkMode ? Colors.white : Colors.blueGrey[900],
        ),
      ),
    );
  }

  Widget _buildProfileButton() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: const DecorationImage(
          image: NetworkImage(
            'https://lh3.googleusercontent.com/aida-public/AB6AXuCOxiFtrNzxoBnrmTAjY8v6fwqtkhpQTWiwjtv32ntOIoklHLg0DPN1EpcIPCQNxLD1NoUELc9NpFGfRP5yd3fDDZrFPTr83R8SKo0NDZOyP26wLsmTeSvMdC99aYkHe99OfzLr1ewsBS0HHiiGIh0lJs3Vn6Zyga14hg_7zfvbsdcR_kBKbKOe8trfDKYqpMsSWxldHYu7uWlKZEDRu42N_cVsmudHh4f5AkpFr0lVr0uzwR6TcrhOwW_7EpQiJ__ylfhw7QcUszc',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String label,
    required String value,
    required Color bgColor,
    required Color borderColor,
    required Color textColor,
    required Color labelColor,
    required bool isDarkMode,
  }) {
    return Container(
      constraints: const BoxConstraints(minWidth: 140),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: labelColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.lexend(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentButton(String value, String label, bool isDarkMode) {
    final isSelected = checkMode == value;
    return GestureDetector(
      onTap: () => setState(() => checkMode = value),
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDarkMode ? Colors.blueGrey[700] : Colors.white)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 2,
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: GoogleFonts.lexend(
            fontWeight: FontWeight.bold,
            color: isSelected
                ? primary
                : (isDarkMode ? Colors.blueGrey[400] : Colors.blueGrey[500]),
          ),
        ),
      ),
    );
  }

  Widget _buildStudentItem({
    required String name,
    required String status,
    required String image,
    required bool isDarkMode,
    required Color surfaceColor,
    required Color textColor,
    required Color subTextColor,
    String? time,
    String? note,
  }) {
    final isAbsent = status == 'Absent';
    final isCheckedIn = status == 'Checked In';

    return Opacity(
      opacity: isAbsent ? 0.8 : 1.0,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isAbsent ? surfaceColor.withValues(alpha: 0.6) : surfaceColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.transparent),
          boxShadow: [
            if (!isAbsent)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.cover,
                      colorFilter: isAbsent
                          ? const ColorFilter.mode(
                              Colors.grey,
                              BlendMode.saturation,
                            )
                          : null,
                    ),
                    border: isCheckedIn
                        ? Border.all(color: primary, width: 2)
                        : null,
                  ),
                ),
                if (isCheckedIn)
                  Positioned(
                    bottom: -2,
                    right: -2,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: backgroundDark,
                        size: 14,
                      ),
                    ),
                  ),
                if (isAbsent)
                  Positioned(
                    bottom: -2,
                    right: -2,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? Colors.blueGrey[600]
                            : Colors.blueGrey[200],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.remove_circle_outline,
                        color: Colors.blueGrey[500],
                        size: 14,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.lexend(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isAbsent
                          ? (isDarkMode
                                ? Colors.blueGrey[300]
                                : Colors.blueGrey[700])
                          : textColor,
                    ),
                  ),
                  if (time != null)
                    Row(
                      children: [
                        Icon(Icons.schedule, size: 16, color: subTextColor),
                        const SizedBox(width: 4),
                        Text(
                          time,
                          style: GoogleFonts.lexend(
                            fontSize: 14,
                            color: subTextColor,
                          ),
                        ),
                      ],
                    ),
                  if (note != null)
                    Text(
                      note,
                      style: GoogleFonts.lexend(
                        fontSize: 14,
                        color: subTextColor,
                      ),
                    ),
                  if (isAbsent)
                    Text(
                      'Reported Absent',
                      style: GoogleFonts.lexend(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.red[500],
                      ),
                    ),
                ],
              ),
            ),
            if (status == 'Pending')
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDarkMode
                      ? Colors.blueGrey[700]
                      : Colors.blueGrey[100],
                  foregroundColor: primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 0,
                  ),
                  minimumSize: const Size(90, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Check In',
                  style: GoogleFonts.lexend(fontWeight: FontWeight.bold),
                ),
              ),
            if (status == 'Checked In')
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(foregroundColor: subTextColor),
                child: Text(
                  'Edit',
                  style: GoogleFonts.lexend(fontWeight: FontWeight.bold),
                ),
              ),

            if (isAbsent)
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_vert, color: subTextColor),
              ),
          ],
        ),
      ),
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double maxHeight;
  final double minHeight;

  _StickyHeaderDelegate({
    required this.child,
    required this.maxHeight,
    required this.minHeight,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(_StickyHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
