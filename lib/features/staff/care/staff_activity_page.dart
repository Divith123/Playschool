import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StaffActivityPage extends StatefulWidget {
  const StaffActivityPage({super.key});

  @override
  State<StaffActivityPage> createState() => _StaffActivityPageState();
}

class _StaffActivityPageState extends State<StaffActivityPage> {
  static const Color primary = Color(0xFF2bee6c);
  static const Color primaryDark = Color(0xFF25cf5e);
  static const Color backgroundLight = Color(0xFFf6f8f6);
  static const Color backgroundDark = Color(0xFF102216);
  static const Color surfaceLight = Color(0xFFffffff);
  static const Color surfaceDark = Color(
    0xFF1a2c20,
  ); // greenish-dark surface from HTML theme

  // We'll use blueGrey for slate-like colors as established previously

  String selectedChild = 'Leo';
  String mealIntake = 'most';
  List<String> pottyStatus = [];
  bool creamApplied = false;

  final List<Map<String, String>> children = [
    {
      'name': 'Leo',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDV6K14tky5GzyxPCcvDxMgpwLjS4kFOecE5tSArqoohtPIdzSEMXJM6dOHDpWo1dhdhzKVE3QbJsdmJS7xIavCPUCzRvzlMZpXeEZJ1GSvYRA86ZS3zy41mIH-BpD_gmoT1KeVB4VJLcowSlj7eJqwZrWe8i_uRhI2N3GCCwHQ6zVjVqewNFHk-3p4JYUbxBn_BW6XUKrxP0p_GpFF24i3VNGvnXCA5_uS61vLbSVBXTOzWxzcrshfwJtIg_CuPjDWqVO5eYB6ENo',
    },
    {
      'name': 'Mia',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuB9ao6lD6Gd3OHl2tdqjt6c4B47lMGjFBq2S8gcao4X-8dApvxYGoKnr14L5fucaXJTHokWmqmFsyrSs84kNGLb6a_brC7uSjsKzKYjLrZ01H1PU4pz1NpgmJiztgnskxXGJAh89HvowYKWgpEN17aUjwpY15wBl2CmwI05bcs96jlxNpwfZWWz1HmibGLMNLO1-TFKQNyEVKrYoElB_HI9-MMQpbU37jN9V_UFgQI9ZystmENayik7Ko0qyxrEJxqbdJypJ-CucCI',
    },
    {
      'name': 'Noah',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDdKeWlqGe3h9qNMeyb-dOEj5GAmmbnI6Fwxo-uH2bjkX8m-FrQc3L4vlYHnsPZJimjH0M3qVVlNfbG22HpU_2k3I36hGngDl3y2Z8UlWnBGky5EI6cqnelKkAz_rvnPg1APEY4GdtrvynO79b0bA8DibB5UXByKeBfQVNdoLqcCoEdpkzGjRKJV-WiV6gekdYu7pOGlaZ8MiQvGcDeZl6qKvbuHOeuMhliNT9L0WCBJe2gVx6klDI_rBNaU_uWcEqfahnm1Wm7crk',
    },
    {
      'name': 'Ava',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCxawrooLfQfPtFsmirAZAHpuTSw9dto_ShKefe3KfKnXGd6TSeXTqb8fAxrM4S0LHO5VB0YuFyeYRYsGbK-m1ZKLKvoXEU5wnSkQGx7rjyD6KSkQRtYfse7jsvs-R5oOMEQvpHx5Dy0Ba0Xhu7Q0Wu3sXKwS3NZ1bKZ6qhUKLTXzmU4ZbP6b8Dl85rd7dvfCqJQKWA8U-hmPLCwoVHKOWLIbR70Lou3SupRyhkedAhiJVA2tgnXDkvTAdaTnMRw9hThzwOUwZt8VU',
    },
    {
      'name': 'Sam',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAdKb4CNY62r8JrXSEPo-4dog_IBQZ71gaHF_nJQ3hHNfVPitXufvNwvrYDyk9w9XsNZkWWpYQC6OkrFGCzm_g7ZjULMM9XFTe8wDs9I15X18rM9l7ovBQAvt6L22XNI3ba4PEPCnkrPCi4SW9wOnHImVG2GWtSoIHMlCpAnvI-NS8M8feLpOlSdYJoGLFpvilzPFbeDbYX6MMXFlO95JLNd6mCLUloQ92xlHuhMkQ8xo9TiJLRMMPCj65nI61fH4m_LULK-jSTWMk',
    },
  ];

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
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: bgColor.withValues(alpha: 0.95),
                    border: Border(
                      bottom: BorderSide(
                        color: isDarkMode ? Colors.white10 : Colors.grey[200]!,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildCircleButton(
                        icon: Icons.arrow_back,
                        onTap: () => Navigator.pop(context),
                        isDarkMode: isDarkMode,
                      ),
                      Expanded(
                        child: Text(
                          'Daily Activity',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lexend(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: primary.withValues(alpha: 0.1),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          minimumSize: Size.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'History',
                          style: GoogleFonts.lexend(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Child Selector
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 16),
                          height: 90,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: children.length + 1,
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 24),
                            itemBuilder: (context, index) {
                              if (index == children.length) {
                                return _buildAddChildButton(isDarkMode);
                              }
                              final child = children[index];
                              return _buildChildAvatar(
                                name: child['name']!,
                                image: child['image']!,
                                isSelected: selectedChild == child['name'],
                                isDarkMode: isDarkMode,
                              );
                            },
                          ),
                        ),

                        // Quick Log Grid
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Quick Log',
                                style: GoogleFonts.lexend(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(height: 12),
                              GridView.count(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisCount: 4,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 0.9,
                                children: [
                                  _buildQuickLogBtn(
                                    'Meal',
                                    Icons.restaurant,
                                    true,
                                    isDarkMode,
                                  ),
                                  _buildQuickLogBtn(
                                    'Nap',
                                    Icons.bedtime,
                                    false,
                                    isDarkMode,
                                  ),
                                  _buildQuickLogBtn(
                                    'Potty',
                                    Icons.wc,
                                    false,
                                    isDarkMode,
                                  ),
                                  _buildQuickLogBtn(
                                    'Mood',
                                    Icons.mood,
                                    false,
                                    isDarkMode,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Meal Section
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: surfaceColor,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isDarkMode
                                    ? Colors.white10
                                    : Colors.grey[100]!,
                              ),
                              boxShadow: isDarkMode
                                  ? null
                                  : [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.02,
                                        ),
                                        blurRadius: 4,
                                      ),
                                    ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.green[100]!
                                                .withValues(
                                                  alpha: isDarkMode ? 0.3 : 1,
                                                ),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.lunch_dining,
                                            color: isDarkMode
                                                ? Colors.green[400]
                                                : Colors.green[700],
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Meal Intake',
                                              style: GoogleFonts.lexend(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: textColor,
                                              ),
                                            ),
                                            Text(
                                              "Today's Menu: Pasta & Veggies",
                                              style: GoogleFonts.lexend(
                                                fontSize: 12,
                                                color: subTextColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.edit,
                                      color: subTextColor,
                                      size: 20,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: isDarkMode
                                        ? Colors.black26
                                        : Colors.grey[100],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      _buildSegmentOption(
                                        'all',
                                        'All',
                                        isDarkMode,
                                      ),
                                      _buildSegmentOption(
                                        'most',
                                        'Most',
                                        isDarkMode,
                                      ),
                                      _buildSegmentOption(
                                        'some',
                                        'Some',
                                        isDarkMode,
                                      ),
                                      _buildSegmentOption(
                                        'none',
                                        'None',
                                        isDarkMode,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Nap Section
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: surfaceColor,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isDarkMode
                                    ? Colors.white10
                                    : Colors.grey[100]!,
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.indigo[100]!.withValues(
                                          alpha: isDarkMode ? 0.3 : 1,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.schedule,
                                        color: isDarkMode
                                            ? Colors.indigo[400]
                                            : Colors.indigo[600],
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      'Nap Time',
                                      style: GoogleFonts.lexend(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: textColor,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Start Time',
                                            style: GoogleFonts.lexend(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: subTextColor,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              color: isDarkMode
                                                  ? Colors.black26
                                                  : Colors.grey[50],
                                              border: Border.all(
                                                color: isDarkMode
                                                    ? Colors.white10
                                                    : Colors.grey[200]!,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '12:30',
                                                  style: GoogleFonts.lexend(
                                                    fontWeight: FontWeight.bold,
                                                    color: textColor,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.access_time,
                                                  size: 16,
                                                  color: subTextColor,
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
                                          Text(
                                            'End Time',
                                            style: GoogleFonts.lexend(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: subTextColor,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              color: isDarkMode
                                                  ? Colors.black26
                                                  : Colors.grey[50],
                                              border: Border.all(
                                                color: isDarkMode
                                                    ? Colors.white10
                                                    : Colors.grey[200]!,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '--:--',
                                                  style: GoogleFonts.lexend(
                                                    fontWeight: FontWeight.bold,
                                                    color: subTextColor
                                                        .withValues(alpha: 0.5),
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.access_time,
                                                  size: 16,
                                                  color: subTextColor,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Potty Section
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: surfaceColor,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isDarkMode
                                    ? Colors.white10
                                    : Colors.grey[100]!,
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.orange[100]!.withValues(
                                          alpha: isDarkMode ? 0.3 : 1,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.baby_changing_station,
                                        color: isDarkMode
                                            ? Colors.orange[400]
                                            : Colors.orange[600],
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      'Potty & Diaper',
                                      style: GoogleFonts.lexend(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: textColor,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    _buildPottyOption(
                                      'Wet',
                                      '💧',
                                      Colors.blue,
                                      isDarkMode,
                                    ),
                                    const SizedBox(width: 8),
                                    _buildPottyOption(
                                      'Soiled',
                                      '💩',
                                      Colors.orange,
                                      isDarkMode,
                                    ),
                                    const SizedBox(width: 8),
                                    _buildPottyOption(
                                      'Dry',
                                      '✨',
                                      Colors.green,
                                      isDarkMode,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Divider(
                                  color: isDarkMode
                                      ? Colors.white10
                                      : Colors.grey[100],
                                ),
                                const SizedBox(height: 8),
                                GestureDetector(
                                  onTap: () => setState(
                                    () => creamApplied = !creamApplied,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color: creamApplied
                                              ? primary
                                              : Colors.transparent,
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                          border: Border.all(
                                            color: creamApplied
                                                ? primary
                                                : (isDarkMode
                                                      ? Colors.grey[600]!
                                                      : Colors.grey[300]!),
                                            width: 2,
                                          ),
                                        ),
                                        child: creamApplied
                                            ? Icon(
                                                Icons.check,
                                                size: 16,
                                                color: backgroundDark,
                                              )
                                            : null,
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        'Cream Applied',
                                        style: GoogleFonts.lexend(
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
                        ),

                        // Notes
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 4,
                                  bottom: 8,
                                ),
                                child: Text(
                                  'Additional Notes',
                                  style: GoogleFonts.lexend(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                                ),
                              ),
                              TextField(
                                maxLines: 3,
                                decoration: InputDecoration(
                                  hintText: 'Add a note for parents...',
                                  hintStyle: GoogleFonts.lexend(
                                    color: subTextColor,
                                  ),
                                  filled: true,
                                  fillColor: surfaceColor,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                      color: isDarkMode
                                          ? Colors.white10
                                          : Colors.grey[200]!,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                      color: isDarkMode
                                          ? Colors.white10
                                          : Colors.grey[200]!,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: const BorderSide(
                                      color: primary,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                style: GoogleFonts.lexend(color: textColor),
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
          ),

          // Bottom Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: bgColor.withValues(alpha: 0.9),
                border: Border(
                  top: BorderSide(
                    color: isDarkMode ? Colors.white10 : Colors.grey[200]!,
                  ),
                ),
              ),
              child: SafeArea(
                top: false,
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.save),
                        label: Text(
                          'Log Activity',
                          style: GoogleFonts.lexend(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          foregroundColor: backgroundDark,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.white10 : Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.more_vert,
                          color: isDarkMode ? Colors.white : Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
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
          color: isDarkMode
              ? Colors.white10
              : Colors.black.withValues(alpha: 0.05),
        ),
        child: Icon(
          icon,
          color: isDarkMode ? Colors.white : Colors.blueGrey[900],
        ),
      ),
    );
  }

  Widget _buildChildAvatar({
    required String name,
    required String image,
    required bool isSelected,
    required bool isDarkMode,
  }) {
    return GestureDetector(
      onTap: () => setState(() => selectedChild = name),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: isSelected ? Border.all(color: primary, width: 3) : null,
            ),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isDarkMode ? backgroundDark : Colors.white,
                  width: 2,
                ),
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                ),
              ),
              child: !isSelected
                  ? Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.4),
                      ),
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            name,
            style: GoogleFonts.lexend(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected
                  ? (isDarkMode ? Colors.white : Colors.blueGrey[900])
                  : (isDarkMode ? Colors.white60 : Colors.blueGrey[400]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddChildButton(bool isDarkMode) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDarkMode ? Colors.white10 : Colors.grey[200],
            ),
            child: Icon(
              Icons.add,
              color: isDarkMode ? Colors.white60 : Colors.grey[500],
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Add',
          style: GoogleFonts.lexend(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isDarkMode ? Colors.white60 : Colors.blueGrey[400],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickLogBtn(
    String label,
    IconData icon,
    bool isActive,
    bool isDarkMode,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: isActive
            ? primary.withValues(alpha: isDarkMode ? 0.2 : 0.2)
            : (isDarkMode ? surfaceDark : surfaceLight),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isActive
              ? primary
              : (isDarkMode ? Colors.white10 : Colors.grey[100]!),
        ),
        boxShadow: isActive || isDarkMode
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 4,
                ),
              ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive
                ? primaryDark
                : (isDarkMode ? Colors.grey[400] : Colors.grey[600]),
            size: 28,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.lexend(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isActive
                  ? (isDarkMode ? Colors.white : Colors.blueGrey[900])
                  : (isDarkMode ? Colors.grey[400] : Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentOption(String value, String label, bool isDarkMode) {
    final isSelected = mealIntake == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => mealIntake = value),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? (isDarkMode ? backgroundDark : Colors.white)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
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
            textAlign: TextAlign.center,
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isSelected
                  ? (isDarkMode ? Colors.white : Colors.blueGrey[900])
                  : (isDarkMode ? Colors.grey[400] : Colors.grey[500]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPottyOption(
    String label,
    String emoji,
    MaterialColor color,
    bool isDarkMode,
  ) {
    final isSelected = pottyStatus.contains(label);
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() {
          if (isSelected) {
            pottyStatus.remove(label);
          } else {
            pottyStatus.add(label);
          }
        }),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? color[50]!.withValues(alpha: isDarkMode ? 0.2 : 1)
                : (isDarkMode ? Colors.transparent : Colors.white),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? color[200]!.withValues(alpha: isDarkMode ? 0.5 : 1)
                  : (isDarkMode ? Colors.white10 : Colors.grey[200]!),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 16)),
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? color[700]!.withValues(alpha: isDarkMode ? 0.9 : 1)
                      : (isDarkMode ? Colors.grey[300] : Colors.grey[600]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
