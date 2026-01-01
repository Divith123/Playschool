import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ParentTransportTrackingPage extends StatefulWidget {
  const ParentTransportTrackingPage({super.key});

  @override
  State<ParentTransportTrackingPage> createState() =>
      _ParentTransportTrackingPageState();
}

class _ParentTransportTrackingPageState
    extends State<ParentTransportTrackingPage>
    with SingleTickerProviderStateMixin {
  // Color palette
  static const Color primary = Color(0xFF2bee6c);
  static const Color backgroundLight = Color(0xFFf6f8f6);
  static const Color backgroundDark = Color(0xFF102216);
  static const Color surfaceLight = Color(0xFFffffff);
  static const Color surfaceDark = Color(0xFF1a2e22);
  static const Color textMainLight = Color(0xFF0d1b12);
  static const Color textMainDark = Color(0xFFf0fdf4);
  static const Color textSubLight = Color(0xFF4c9a66);
  static const Color textSubDark = Color(0xFF86c598);

  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = isDarkMode ? surfaceDark : surfaceLight;
    final textMain = isDarkMode ? textMainDark : textMainLight;
    final textSub = isDarkMode ? textSubDark : textSubLight;

    return Scaffold(
      body: Stack(
        children: [
          // 1. Map Background Layer
          Positioned.fill(
            child: InteractiveViewer(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Simulated Map Image
                  Image.network(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuDU09YXf293ZEcP40gHYI9LMPNdTkYNNeRMDCtzWRudf4R61_jAyORR3-pScLBW6swBNr6L_YOOKd8DruikebFzprfrJM4PuSDhawm8C-f57KKcyxjCNNYkzeU82M5T4F77MXQdc0St6C2x6pBDRNqfdcEvq-IbRGCsNvtTcNg5LI4jL_3dO8Z7dzaT8LfzkLnmpUChG3Qx9A9H60hQaB4738xCOIGU_tbn027LCLrlVub67bZcmHnjFKIA0PBAb7Qm83uF2jhZMC4',
                    fit: BoxFit.cover,
                    color: isDarkMode
                        ? Colors.black.withOpacity(0.6)
                        : Colors.white.withOpacity(0.2),
                    colorBlendMode: isDarkMode
                        ? BlendMode.darken
                        : BlendMode.lighten,
                  ),

                  // Route Path (Curved Dotted Line Simulation)
                  // In a real app we'd use CustomPaint or Google Map Polylines.
                  // Here we'll just try to place markers logicially as this is a UI demo.

                  // Bus Marker
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.28,
                    left: MediaQuery.of(context).size.width * 0.45,
                    child: FractionalTranslation(
                      translation: const Offset(-0.5, -0.5),
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              // Pulse Ring
                              AnimatedBuilder(
                                animation: _pulseController,
                                builder: (context, child) {
                                  return Container(
                                    width:
                                        80 *
                                        _pulseAnimationValue(
                                          _pulseController.value,
                                        ),
                                    height:
                                        80 *
                                        _pulseAnimationValue(
                                          _pulseController.value,
                                        ),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: primary.withOpacity(
                                        0.4 * (1 - _pulseController.value),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              // Bus Icon Circle
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: surfaceColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: primary, width: 2),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.directions_bus,
                                  color: primary,
                                  size: 24,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: surfaceColor,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: Text(
                              "Bus No. 42",
                              style: GoogleFonts.lexend(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: textMain,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Home Marker
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.55,
                    left: MediaQuery.of(context).size.width * 0.75,
                    child: FractionalTranslation(
                      translation: const Offset(-0.5, -0.5),
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.pinkAccent,
                        size: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. Top UI Overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    isDarkMode
                        ? Colors.black.withOpacity(0.9)
                        : Colors.white.withOpacity(0.9),
                    isDarkMode
                        ? Colors.black.withOpacity(0.5)
                        : Colors.white.withOpacity(0.5),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Column(
                children: [
                  // Header Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildCircleBtn(
                        icon: Icons.arrow_back,
                        color: textMain,
                        bg: surfaceColor,
                        onTap: () => Navigator.pop(context),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: surfaceColor.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Text(
                          "Transport Tracking",
                          style: GoogleFonts.lexend(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textMain,
                          ),
                        ),
                      ),
                      _buildCircleBtn(
                        icon: Icons.support_agent,
                        color: Colors.pinkAccent,
                        bg: surfaceColor,
                        onTap: () {}, // Support action
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Notification Toast
                  Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 400),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: surfaceColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border(
                        left: BorderSide(color: primary, width: 4),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: primary.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.notifications_active,
                            color: primary,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Bus is 5 mins away",
                                style: GoogleFonts.lexend(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: textMain,
                                ),
                              ),
                              Text(
                                "Please be ready at the stop",
                                style: GoogleFonts.lexend(
                                  fontSize: 12,
                                  color: textSub,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close, size: 20, color: textSub),
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 3. Map Control (My Location)
          Positioned(
            bottom:
                MediaQuery.of(context).size.height * 0.5 +
                20, // push above sheet
            right: 16,
            child: _buildCircleBtn(
              icon: Icons.my_location,
              color: textMain,
              bg: surfaceColor,
              onTap: () {},
              size: 48,
            ),
          ),

          // 4. Bottom Sheet (Draggable)
          DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.4,
            maxChildSize: 0.8,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: surfaceColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(32),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Handle
                      Center(
                        child: Container(
                          width: 48,
                          height: 6,
                          margin: const EdgeInsets.only(bottom: 24),
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? Colors.grey[700]
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),

                      // Child & Status
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              // Avatar
                              Stack(
                                children: [
                                  Container(
                                    width: 56,
                                    height: 56,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: primary,
                                        width: 2,
                                      ),
                                      image: const DecorationImage(
                                        image: NetworkImage(
                                          'https://lh3.googleusercontent.com/aida-public/AB6AXuD5ViI10REoBSAXfiRB5mlfQKMtREKW3b4ahnofr7IHT25OxptUwAgD2lH7wcVFaUAPiBGXnSIqBGGFIG1mJP3ckVL7nL8aTYsHdTqveMwAEbGnbknRL6s7O_kR_3OKB2ohwcWA6p-_0196p47MFYt0XkhlfdGEHWDtZ7nNg7pL7dcNfDFhY0sDZ-_qTQIBUkqm2Ht0NxR0frKzTwDAuxoWuWUH-_-3M-7UisFAC4FzaopvJMxUb1BiZD0E_QFsaJtfadlCA-i1UZs',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      width: 16,
                                      height: 16,
                                      decoration: BoxDecoration(
                                        color: primary,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: surfaceColor,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "TRACKING",
                                    style: GoogleFonts.lexend(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: textSub,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    "Leo Anderson",
                                    style: GoogleFonts.lexend(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: textMain,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isDarkMode
                                          ? Colors.green[900]!.withOpacity(0.3)
                                          : Colors.green[50],
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 6,
                                          height: 6,
                                          decoration: const BoxDecoration(
                                            color: Colors.green,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          "ON BOARD",
                                          style: GoogleFonts.lexend(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "12 ",
                                      style: GoogleFonts.lexend(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: primary,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "min",
                                      style: GoogleFonts.lexend(
                                        fontSize: 16,
                                        color: textMain,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "Estimated Arrival",
                                style: GoogleFonts.lexend(
                                  fontSize: 12,
                                  color: textSub,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Stats Grid
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              icon: Icons.speed,
                              value: "Moving",
                              label: "Current Status",
                              surfaceColor: isDarkMode
                                  ? backgroundDark.withOpacity(0.5)
                                  : backgroundLight,
                              borderColor: isDarkMode
                                  ? Colors.grey[800]!
                                  : Colors.grey[200]!,
                              textMain: textMain,
                              textSub: textSub,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildStatCard(
                              icon: Icons.straighten,
                              value: "2.5 km",
                              label: "Distance Left",
                              surfaceColor: isDarkMode
                                  ? backgroundDark.withOpacity(0.5)
                                  : backgroundLight,
                              borderColor: isDarkMode
                                  ? Colors.grey[800]!
                                  : Colors.grey[200]!,
                              textMain: textMain,
                              textSub: textSub,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Driver Card
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? backgroundDark.withOpacity(0.5)
                              : backgroundLight,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isDarkMode
                                ? Colors.grey[800]!
                                : Colors.grey[200]!,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey,
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                        "https://lh3.googleusercontent.com/aida-public/AB6AXuBFTip9jkP8W8OWta8Bh8HvQYjGNBkYqt2MSKHrTQm7F7jHdKUU3euxFpe9eM-jugMqT21B11fSy5On1Gj7AfgZrVJlelmRqqHx9XyqA0rQNehT3hhXcEisveEXPyeeNJR4hYrNFeHNYc1ZF83fJ09jxg6SDbBXrUR5MN2Zs7Ed2v1pTeBUp9Co2nea6HEHWAj9c-KYpdoRQM85Zgd6Hxq47dDxJmsW4EbCf5SitBGsxNp5f_Gf5dCkpbfzWw9DdNf-UBKljNYQCdE",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Mr. John Doe",
                                      style: GoogleFonts.lexend(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: textMain,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.directions_bus,
                                          size: 14,
                                          color: textSub,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          "Bus No. 42 (Yellow Van)",
                                          style: GoogleFonts.lexend(
                                            fontSize: 12,
                                            color: textSub,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: primary,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.call,
                                color: Color(0xFF102216),
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Timeline
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Column(
                          children: [
                            // Step 1
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: 16,
                                      height: 16,
                                      decoration: BoxDecoration(
                                        color: isDarkMode
                                            ? Colors.grey[600]
                                            : Colors.grey[300],
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: surfaceColor,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 2,
                                      height: 40,
                                      color: isDarkMode
                                          ? Colors.grey[700]
                                          : Colors.grey[200],
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "14:30 PM",
                                      style: GoogleFonts.lexend(
                                        fontSize: 12,
                                        color: textSub,
                                      ),
                                    ),
                                    Text(
                                      "Departed School",
                                      style: GoogleFonts.lexend(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: textSub,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // Step 2
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: 16,
                                      height: 16,
                                      decoration: BoxDecoration(
                                        color: primary,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: surfaceColor,
                                          width: 2,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: primary.withOpacity(0.3),
                                            blurRadius: 0,
                                            spreadRadius: 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Now",
                                      style: GoogleFonts.lexend(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: primary,
                                      ),
                                    ),
                                    Text(
                                      "In Transit",
                                      style: GoogleFonts.lexend(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: textMain,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 40), // Bottom padding
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCircleBtn({
    required IconData icon,
    required Color color,
    required Color bg,
    required VoidCallback onTap,
    double size = 40,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: bg,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: color, size: size * 0.5),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color surfaceColor,
    required Color borderColor,
    required Color textMain,
    required Color textSub,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          Icon(icon, color: textSub, size: 20),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: textMain,
            ),
          ),
          Text(label, style: GoogleFonts.lexend(fontSize: 10, color: textSub)),
        ],
      ),
    );
  }

  double _pulseAnimationValue(double val) {
    // Mimic the keyframes: 0% -> scale 0.8, 50% -> scale 1, 100% -> scale 0.8  (Actually the pulse-ring in CSS is different)
    // The CSS pulse-ring is scale 0.33 -> opacity 0.
    // The pulse dot is scale 0.8 -> 1 -> 0.8.
    // Let's implement simpler pulse here: just grow and fade.
    return 1 + (val * 0.5); // 1.0 to 1.5
  }
}
