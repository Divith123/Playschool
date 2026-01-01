import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StaffMedicineLogPage extends StatefulWidget {
  const StaffMedicineLogPage({super.key});

  @override
  State<StaffMedicineLogPage> createState() => _StaffMedicineLogPageState();
}

class _StaffMedicineLogPageState extends State<StaffMedicineLogPage> {
  // Theme Colors from HTML
  static const Color primary = Color(0xFF2bee6c);
  static const Color backgroundLight = Color(0xFFf6f8f6);
  static const Color backgroundDark = Color(0xFF102216);
  static const Color surfaceLight = Color(0xFFffffff);
  static const Color surfaceDark = Color(0xFF1c3022);
  static const Color darkText = Color(0xFF0d1b12);

  // Form State
  String selectedStudent = '';
  String dosage = '5 ml';
  TimeOfDay selectedTime = const TimeOfDay(hour: 12, minute: 0);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode ? backgroundDark : backgroundLight;
    final surfaceColor = isDarkMode ? surfaceDark : surfaceLight;
    final textColor = isDarkMode ? Colors.white : darkText;
    final subTextColor = isDarkMode ? Colors.grey[400]! : Colors.grey[500]!;

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // Sticky Header
              SliverPersistentHeader(
                pinned: true,
                delegate: _StickyHeaderDelegate(
                  maxHeight: 80,
                  minHeight: 80,
                  child: Container(
                    color: bgColor.withOpacity(0.95),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: SafeArea(
                      bottom: false,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            borderRadius: BorderRadius.circular(20),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.arrow_back, color: textColor),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Medicine Log',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lexend(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                //  color: isDarkMode ? surfaceDark : Colors.transparent, // Hover effect usually handled by InkWell
                              ),
                              child: Icon(Icons.tune, color: textColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 150,
                  ), // Padding for sticky bottom button
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Due Soon Section
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Due Soon',
                              style: GoogleFonts.lexend(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                                height: 1.1,
                              ),
                            ),
                            Text(
                              'View Schedule',
                              style: GoogleFonts.lexend(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: isDarkMode ? primary : Colors.green[600],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Carousel
                      SizedBox(
                        height: 220,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          children: [
                            _buildDueCard(
                              name: 'Liam J.',
                              med: 'Amoxicillin',
                              time: '12:00 PM',
                              imgUrl:
                                  'https://lh3.googleusercontent.com/aida-public/AB6AXuBBMXarnYuAgvuEXk7rCam38Xu5fC0nWY4jUsWhlkWSZpgX1Clp8UY5GbxD9DR5nGQkqH7-ltFcsEsIq1oMnXKf5coNogvVfjLJSQ8Q6AMLWKiVCCLORQwvMT5vvZ9x9Q7987411s42JXlti9JDLz64ZzEXAtGGRM3Xq2jsM3DBgkz3-QY9X-O3ag4ggvffEnGJig95Z9M0BCTGogHQ7dtE2Hsyhqfn6uipwBpo-WWQqZf-ePAg5xw57W_T1G792XuWkLWQ-6Kp8sA',
                              color: Colors.red,
                              bgColor: isDarkMode ? surfaceDark : surfaceLight,
                              textColor: textColor,
                              subTextColor: subTextColor,
                              borderColor: isDarkMode
                                  ? Colors.red.withOpacity(0.3)
                                  : Colors.red[100]!,
                              isUrgent: true,
                            ),
                            const SizedBox(width: 16),
                            _buildDueCard(
                              name: 'Emma W.',
                              med: 'Tylenol',
                              time: '12:15 PM',
                              imgUrl:
                                  'https://lh3.googleusercontent.com/aida-public/AB6AXuC3bsktMftO8BK1PeLFBxE8V9YkDk04eYs5AujkjArgpKpPz2Q0lmV92UUtANPWOzqMrqVtujxpqfw5R-TS4CGm1v2NmiB4Iw3GAB8i5jcU_R24PjIBgh236vDZKdaQq8dYiaNOTjStQl8nvLkYBL94x6MLoJloDrHc8DT_DMbLgmUuGZxhCJ5k7xs_jUH_qkm0vhpIH4q06zB-0aqaz9ijuHKQKvVIQuRUqBR8hqFElO0KXKL1CxwI2XemqyhjFApQFCMOeCCZYUo',
                              color: Colors.amber,
                              bgColor: isDarkMode ? surfaceDark : surfaceLight,
                              textColor: textColor,
                              subTextColor: subTextColor,
                              borderColor: isDarkMode
                                  ? Colors.grey[800]!
                                  : Colors.grey[100]!,
                            ),
                            const SizedBox(width: 16),
                            _buildDueCard(
                              name: 'Noah S.',
                              med: 'Inhaler',
                              time: '1:00 PM',
                              imgUrl:
                                  'https://lh3.googleusercontent.com/aida-public/AB6AXuDkfLBWvysvdJY003tp28M-q0LhXZYIqX3MILJTmVMqmJ4CyUCUqJU3lyxix5-mHyIqRFZn07tG7F2mobZfUeqeqx61uRd_N6wLPZfGZBpdB9FZ46IKWCx4lZXhSJUxIu01xjmjh-aQypHlectfWPlso5Tvrah5B_MGCy5QKx3mQzl8G9joWn8EbyNKwBcCj2RyJmRRBH-zot7-489Grq1EH9Y2R6hXwxsM8cdYko1-o2ODNs0NfyllkePdOxU8qUfG8rwxOsRdeY0',
                              color: Colors.grey,
                              bgColor: isDarkMode ? surfaceDark : surfaceLight,
                              textColor: textColor,
                              subTextColor: subTextColor,
                              borderColor: isDarkMode
                                  ? Colors.grey[800]!
                                  : Colors.grey[100]!,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),
                      Divider(
                        thickness: 16,
                        color: bgColor,
                        height: 16,
                      ), // Visual separator logic from HTML "h-4 bg-background"
                      // Form Section
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Record Administration',
                              style: GoogleFonts.lexend(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                                height: 1.1,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Student Dropdown
                            _buildLabel('Student', textColor),
                            const SizedBox(height: 8),
                            _buildDropdown(
                              hint: 'Select a student',
                              value: selectedStudent.isNotEmpty
                                  ? selectedStudent
                                  : null,
                              items: const [
                                DropdownMenuItem(
                                  value: 'liam',
                                  child: Text('Liam Johnson'),
                                ),
                                DropdownMenuItem(
                                  value: 'emma',
                                  child: Text('Emma Watson'),
                                ),
                                DropdownMenuItem(
                                  value: 'noah',
                                  child: Text('Noah Smith'),
                                ),
                              ],
                              onChanged: (val) => setState(
                                () => selectedStudent = val.toString(),
                              ),
                              icon: Icons.face,
                              bgColor: surfaceColor,
                              textColor: textColor,
                              borderColor: isDarkMode
                                  ? Colors.grey[700]!
                                  : Colors.grey[200]!,
                            ),

                            const SizedBox(height: 20),

                            // Medicine Input
                            _buildLabel('Medicine', textColor),
                            const SizedBox(height: 8),
                            _buildInput(
                              hint: 'e.g. Children\'s Tylenol',
                              icon: Icons.medication,
                              bgColor: surfaceColor,
                              textColor: textColor,
                              borderColor: isDarkMode
                                  ? Colors.grey[700]!
                                  : Colors.grey[200]!,
                            ),

                            const SizedBox(height: 20),

                            // Row: Dosage & Time
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildLabel('Dosage', textColor),
                                      const SizedBox(height: 8),
                                      Container(
                                        height: 56,
                                        decoration: BoxDecoration(
                                          color: surfaceColor,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color: isDarkMode
                                                ? Colors.grey[700]!
                                                : Colors.grey[200]!,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.05,
                                              ),
                                              blurRadius: 2,
                                              offset: const Offset(0, 1),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            _buildStepperButton(
                                              Icons.remove,
                                              isDarkMode,
                                            ),
                                            Expanded(
                                              child: Text(
                                                dosage,
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.lexend(
                                                  fontWeight: FontWeight.bold,
                                                  color: textColor,
                                                ),
                                              ),
                                            ),
                                            _buildStepperButton(
                                              Icons.add,
                                              isDarkMode,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildLabel('Time', textColor),
                                      const SizedBox(height: 8),
                                      Container(
                                        height: 56,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        decoration: BoxDecoration(
                                          color: surfaceColor,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color: isDarkMode
                                                ? Colors.grey[700]!
                                                : Colors.grey[200]!,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.05,
                                              ),
                                              blurRadius: 2,
                                              offset: const Offset(0, 1),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.schedule,
                                              color: isDarkMode
                                                  ? Colors.grey[500]
                                                  : Colors.grey[400],
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              '12:00', // Hardcoded for demo matching HTML
                                              style: GoogleFonts.lexend(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: textColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            // Notes
                            _buildLabel('Notes', textColor, optional: true),
                            const SizedBox(height: 8),
                            Container(
                              height: 100,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: surfaceColor,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isDarkMode
                                      ? Colors.grey[700]!
                                      : Colors.grey[200]!,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 2,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: TextField(
                                maxLines: null,
                                decoration: InputDecoration.collapsed(
                                  hintText:
                                      'Any observations (e.g. taken with food)',
                                  hintStyle: GoogleFonts.lexend(
                                    color: isDarkMode
                                        ? Colors.grey[600]
                                        : Colors.grey[400],
                                  ),
                                ),
                                style: GoogleFonts.lexend(
                                  color: textColor,
                                  fontSize: 16,
                                ),
                              ),
                            ),

                            const SizedBox(height: 8),

                            // Reminder Toggle
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: surfaceColor,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isDarkMode
                                      ? Colors.grey[700]!
                                      : Colors.grey[200]!,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 2,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isDarkMode
                                          ? Colors.blue[900]!.withOpacity(0.3)
                                          : Colors.blue[50],
                                    ),
                                    child: Icon(
                                      Icons.notifications_active,
                                      color: isDarkMode
                                          ? Colors.blue[400]
                                          : Colors.blue[600],
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Set Next Reminder',
                                          style: GoogleFonts.lexend(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: textColor,
                                          ),
                                        ),
                                        Text(
                                          'Alert in 4 hours',
                                          style: GoogleFonts.lexend(
                                            fontSize: 12,
                                            color: subTextColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Switch(
                                    value: false,
                                    onChanged: (val) {},
                                    activeColor: primary,
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 32),

                            // Logged Today
                            Text(
                              'LOGGED TODAY',
                              style: GoogleFonts.lexend(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode
                                    ? Colors.grey[500]
                                    : Colors.grey[400],
                                letterSpacing: 1.5,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Opacity(
                              opacity: 0.7,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: surfaceColor,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isDarkMode
                                        ? Colors.grey[800]!
                                        : Colors.grey[100]!,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: const DecorationImage(
                                          image: NetworkImage(
                                            'https://lh3.googleusercontent.com/aida-public/AB6AXuAv0Jqx7yiU75o5g0L2iJdavEiTdaE6lZ6IFYNf3KTI88T0B39jRUdKY2HI-vctWMTOPkRyq-eDHFyQ6iWcWbH0Io2Jf06nDvYmbP9bAHAlZWa4vIhcux_b55bsFiFAWLeTisUa48EUmufgKXW7K8oX7unX6VvZqlgBialfi8XEHNqkeLupTkfs86AUg_4s1TSVyGxK5X7N5Oq4nOM5HAm7fYJmgMj1BKeQdtGTkfqlMvm6uRcFP3dLVzrq5uXF23J0_g8UeDWB0D8',
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                        color: Colors.grey[200],
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Liam J.',
                                            style: GoogleFonts.lexend(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: textColor,
                                            ),
                                          ),
                                          Text(
                                            'Amoxicillin • 8:00 AM',
                                            style: GoogleFonts.lexend(
                                              fontSize: 12,
                                              color: Colors.grey[500],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.green[500],
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Sticky Bottom Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: bgColor.withOpacity(0.8),
                border: Border(
                  top: BorderSide(
                    color: isDarkMode ? Colors.grey[800]! : Colors.grey[200]!,
                  ),
                ),
              ),
              child: SafeArea(
                // Ensure button isn't obscured by system gestures
                top: false,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    foregroundColor: const Color(0xFF102216),
                    fixedSize: const Size.fromHeight(56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: GoogleFonts.lexend(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    elevation: 5,
                    shadowColor: primary.withOpacity(0.2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.check),
                      SizedBox(width: 8),
                      Text('Confirm Administration'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text, Color color, {bool optional = false}) {
    return RichText(
      text: TextSpan(
        text: text,
        style: GoogleFonts.lexend(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: color.withOpacity(
            isDarkMode(context) ? 0.9 : 1,
          ), // slightly softer for labels? No, design says font-medium text-dark-text
        ),
        children: optional
            ? [
                TextSpan(
                  text: ' (Optional)',
                  style: GoogleFonts.lexend(
                    fontWeight: FontWeight.normal,
                    color: Colors.grey[400],
                  ),
                ),
              ]
            : [],
      ),
    );
  }

  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<DropdownMenuItem> items,
    required Function(dynamic) onChanged,
    required IconData icon,
    required Color bgColor,
    required Color textColor,
    required Color borderColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: value,
          hint: Row(
            children: [
              Icon(
                icon,
                color: isDarkMode(context)
                    ? Colors.grey[500]
                    : Colors.grey[400],
              ),
              const SizedBox(width: 12),
              Text(
                hint,
                style: GoogleFonts.lexend(
                  color: isDarkMode(context)
                      ? Colors.grey[600]
                      : Colors.grey[400],
                  fontSize: 16,
                ),
              ),
            ],
          ),
          icon: Icon(
            Icons.expand_more,
            color: isDarkMode(context) ? Colors.grey[500] : Colors.grey[400],
          ),
          items: items,
          onChanged: onChanged,
          isExpanded: true,
          dropdownColor: bgColor,
          style: GoogleFonts.lexend(color: textColor, fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildInput({
    required String hint,
    required IconData icon,
    required Color bgColor,
    required Color textColor,
    required Color borderColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(
            icon,
            color: isDarkMode(context) ? Colors.grey[500] : Colors.grey[400],
          ),
          hintText: hint,
          hintStyle: GoogleFonts.lexend(
            color: isDarkMode(context) ? Colors.grey[600] : Colors.grey[400],
            fontSize: 16,
          ),
        ),
        style: GoogleFonts.lexend(color: textColor, fontSize: 16),
      ),
    );
  }

  Widget _buildStepperButton(IconData icon, bool isDarkMode) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 48,
          height: double.infinity,
          alignment: Alignment.center,
          child: Icon(icon, size: 20, color: Colors.grey[500]),
        ),
      ),
    );
  }

  Widget _buildDueCard({
    required String name,
    required String med,
    required String time,
    required String imgUrl,
    required Color color,
    required Color bgColor,
    required Color textColor,
    required Color subTextColor,
    required Color borderColor,
    bool isUrgent = false,
  }) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(imgUrl),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.grey[300],
                  ),
                ),
                if (isUrgent)
                  Positioned(
                    top: 0,
                    left: 0,
                    bottom: 0,
                    width: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            name,
            style: GoogleFonts.lexend(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: textColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            med,
            style: GoogleFonts.lexend(fontSize: 12, color: subTextColor),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isDarkMode(context)
                  ? color.withOpacity(0.2)
                  : color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.schedule, size: 14, color: color),
                const SizedBox(width: 4),
                Text(
                  time,
                  style: GoogleFonts.lexend(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
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
