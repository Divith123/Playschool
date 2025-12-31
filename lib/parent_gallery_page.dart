import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ParentGalleryPage extends StatefulWidget {
  const ParentGalleryPage({super.key});

  @override
  State<ParentGalleryPage> createState() => _ParentGalleryPageState();
}

class _ParentGalleryPageState extends State<ParentGalleryPage> {
  // Color palette
  static const Color primary = Color(0xFFeca413);
  static const Color backgroundLight = Color(0xFFf8f7f6);
  static const Color backgroundDark = Color(
    0xFF1a150c,
  ); // Darkened from #221c10 for better contrast or matching user's dark theme preference if needed, but sticking to HTML #221c10 for now. Using 0xFF221c10 as per HTML.

  // Actually, let's stick to the HTML hex codes
  static const Color bgDarkHtml = Color(0xFF221c10);
  static const Color textLight = Color(0xFF1b170d);
  static const Color textDark = Color(0xFFf3efe7);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode ? bgDarkHtml : backgroundLight;
    final textColor = isDarkMode ? textDark : textLight;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          "Sarah's Gallery",
          style: GoogleFonts.lexend(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: isDarkMode ? bgDarkHtml : backgroundLight,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.transparent, width: 2),
              ),
              child: ClipOval(
                child: Image.network(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuDshyMxFTdQLwOpdCMwDGvnvuHnK8jh--vjnFdGoMoRElQrrZWiCNh6-Z9zLeDaPzbo9xaBQLO15lTZ7GkM3WlmYPUplp6eZehclrwcG1rb_h-1Fw9s1sVyHEPX995tVmpSRYfcdFAXmFCrnThKg5rwJWL45gaPjh_rMkbCetU7MQuiygEyt9ajvye09uoUbJl00nXa8slib7fUONNL8Cr2TyRzvwmEBjkin87KdM-kJdjtch88U6VLBPWTWpeZ-UUxpQpYphe2JQ4',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                _buildFilterChip('All', true, isDarkMode),
                const SizedBox(width: 12),
                _buildFilterChip('Today', false, isDarkMode),
                const SizedBox(width: 12),
                _buildFilterChip('Art', false, isDarkMode),
                const SizedBox(width: 12),
                _buildFilterChip('Playtime', false, isDarkMode),
                const SizedBox(width: 12),
                _buildFilterChip('Events', false, isDarkMode),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Featured Memory Card
                  Container(
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? const Color(0xFF2c261a)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(
                        color: isDarkMode
                            ? Colors.white.withOpacity(0.05)
                            : Colors.black.withOpacity(0.05),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image
                        Stack(
                          children: [
                            Container(
                              height: 200, // Aspect video approx
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    'https://lh3.googleusercontent.com/aida-public/AB6AXuAg5w2sgIZBEG9gZ6S8t2m4M_jsNKfL_DuhjcPWoYRrWXirI2X18WV82wFkG08yJ4k3xccL4jfa36W625z6s13HCKmO9_7XA4f_VC5VlEMbO0BAwFjLaYoFi1s--Gh8QCD9OHkYh6R7N5wmjMRkatwXWkPTsrJi3_1kYlGhTLk8TqpfMwqZpn8wmvrz-s5kd0CDvEz6zrqhhIBR7lDcifkoReE-qkHyqQCiaG8x40jv5M8T9T87Ky_xta04gwX-xkY7uJtjBSRtlx4',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 12,
                              left: 12,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: primary,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      size: 14,
                                      color: Color(0xFF1b170d),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Memory of the Day',
                                      style: GoogleFonts.lexend(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF1b170d),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Content
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Sarah's Masterpiece 🎨",
                                style: GoogleFonts.lexend(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Today, 10:30 AM • Art Class",
                                style: GoogleFonts.lexend(
                                  fontSize: 14,
                                  color: isDarkMode
                                      ? const Color(0xFFd4c39c)
                                      : const Color(0xFF9a804c),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Divider(
                                color: isDarkMode
                                    ? const Color(0xFF3a352a)
                                    : const Color(0xFFf3efe7),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.visibility,
                                        size: 18,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        "Seen by Dad",
                                        style: GoogleFonts.lexend(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isDarkMode
                                          ? const Color(0xFF3a352a)
                                          : const Color(0xFFfcfaf8),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      "View Memory",
                                      style: GoogleFonts.lexend(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: textColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Today Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Today, Oct 24",
                        style: GoogleFonts.lexend(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "3 New",
                          style: GoogleFonts.lexend(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.8, // Vertical aspect
                    children: [
                      _buildMediaItem(
                        imageUrl:
                            'https://lh3.googleusercontent.com/aida-public/AB6AXuCL2TGI1prJiLz6srMVDh63XxMrCv5J3_RZQNoHLa7-ro5MzCSErT00uun5KniIbdHSaN2Q3mzswbNtUkJlgb_PYc1ExfzGNC0zLTN9p8dSTlXsF10RWVQJfTf-oZzWW852cW-VEKf09yOA5IeZNE-zDNmFC6Rhp5vad685qHC3JRnbqdjxXHhn0nNm-OdYjJpWfeU76X5fzlaG_guX-7G_lPxsNHfD5Y9UzQq_LjPWYbXFfXhRpIOT2ux8y_Zr9wPgN6bGEg9UUq8',
                        isVideo: true,
                        duration: "0:45",
                      ),
                      _buildMediaItem(
                        imageUrl:
                            'https://lh3.googleusercontent.com/aida-public/AB6AXuClAUWlEnQ0EI9jS9TGOUSoYxk126FGIMZVEWyNCKsBDLDN8QRzVfx4uLjpEdWWcNw9qMRZdZKEYNdxzSEzI3b4CVIPTCOMaJNfRth1yVwJwUQ_wp-iFvbk5nHJIDPh34RzAb6KQRlxOmqOpa6N3lk_QznjT3yh-80emZZDhlF7m62MTGB9sWRAN9gpNyd9e8aQiXC2_lFb3BEMJqOLNKEZGuGHk6ho-7DyTs2DmDY1tQwwQHfdK1fk_NOeRFYsqZcTZFRzqkGaMJM',
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Horizontal Span Photo
                  Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                        image: NetworkImage(
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuA5PpYu_jP5MpEAeis4z-rAgJi0mMLIfX6ipykBN94Uf03MADBeQJqgYcQcM35fInCyaN8xScAA_kNVIQlsffWvlv7vxatrAHTcS2lr39_zquDCb_FOaXaQJ74Vz18JlGerRRmAstwkz8qJkvL8vLAUK4gQ6T5ieu5wIhncyiL5KI-jny_HB8JNq88hLU7x6C-Lb-7StYr5w8htbsLuXhAujkIkaSWjwkVa4iBRJyc5JerL4_kFT5Dc_SIyo4yQWqSMUezCGNXLZC4',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 12,
                          left: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.black.withOpacity(0.6)
                                  : Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.photo_library,
                                  size: 16,
                                  color: primary,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Playtime Collection',
                                  style: GoogleFonts.lexend(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Yesterday Section
                  Text(
                    "Yesterday, Oct 23",
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
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 1, // Square
                    children: [
                      _buildSquareImage(
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuAx67mgkqkZWdhZYSKyxVtXp8fKqQAYhnC_NgW6UfIRoym1lK0j_Iqs_nGdpNDGp7D0dzj2_xZGjF2JDGuHoAeBLN5E-_Lsqss8x_aSXllypimzeQc2EoEJsRWZ5CnHw3BkAizdvBGppGymr0QwXkTK5YH1QenVPj-dTlEzmfbeCVbGmbMxYHIzauEWjjO2dT-4BUc90mKat4eKE51WrHBcjYQkHFZg1LomN7y1UnDkoNSOGExkRAv0YXh4wl6pLdEJl6BeRwndq6U',
                      ),
                      _buildSquareImage(
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuCJDiRZFMqhC8X-tZuEGJXLMH5OGLXEgLBXo-Q5GVsDINOtYfspXlSNOS4CefJ3rtJiksBm2mOckSgo72QGOPdo2TAYQYeWDgRYwnVS3Ggc0Ukbp79n4Ts3SMwBFH5q5lJyQmXdVYI2TjyJW_UTiiWCInpDRhcz_WnbHLJu3YibHdceWIeqyfCCYdnXjGy40WdvRk6cUyGl0OM9bSweXKfO6m6p2_ZwO6uzh4oxlMkQsUYUrSDhqU6BEpYMcQPEzi_o4pGnS9TCNLE',
                      ),
                      _buildSquareImage(
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuDoPuuwKvtorOZlDK2RgaKmi8eXtDlFGFWqJb-tAi5eWdO_3Hltlo4bkR4bYsexJmhAoUsBpCSh1p2o5NM9tGri66BD3G_3_TUMbgfjOszQBMCzB2AZGaaK2Mdr3Vz6lLCjq0nQTAc3nrw6z8aNjCB506QaOwUGUHO2l0m-HWSlHJYSGbm7J3gkKHcyO8ktF-lAYN5wtBqdCRXuqM_XF4Hax0ZYn3K0z437e7BBJLOKZIOGDoNp7Ym_NruYWlgsxaVYtdhxcMN32G4',
                      ),
                      _buildSquareImage(
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuB9uTx-p5qEBL-N9SLKqjdHspm265lyT2cVpeT7nKR6U7I3hEfStAClE6klGrLT9_1H2ALF-hKo5849ZgSmVbqOxQyh8EEAtbCbD-W0gUW_q-pQiHGNk2l50nkIhFsIHS-cuC94fBsR26eQKhWmQwz8kEhgKudLNeuSDWts3cy9_9ecrSTWFq5hhbaPjAsCWHj9r3H8nDLZtXjeb7HCL7uO7NQMAbcIUUuQdV6yeAI67tZ3eRLanJ6cN4PC6PJ5hMJhFTZFGGVFSnY',
                      ),
                      _buildSquareImage(
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuANdSEmZJi4r5aTK-OrILSleoXXgnjLQAbQf0cCGNfaxASf7VD6NnXEL4XG585Wp5mw32a2oBUW27p6rvag9jPD3E90bYJwvIuCaBqlX7qp4fDgmHzxgsYiJE9kp5YFx4Pl1HtcviFScm1FYcCwXcqQq1ZPvv6y8lQNgjEG_63dwgbzTzZWTfi-T5jnaHfhXB6WSLx6v3RBMpzec4U-fc0HWa4nuKs_pCtCxbapWgBno_tUykCHG2pbHqQ9TFjqxSOiHKR2t5LNGMg',
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.arrow_forward, color: primary),
                            const SizedBox(height: 4),
                            Text(
                              "View All",
                              style: GoogleFonts.lexend(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),
                  Center(
                    child: Text(
                      "You're all caught up! 🌟",
                      style: GoogleFonts.lexend(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, bool isDarkMode) {
    // Colors from HTML
    // Selected: bg-primary
    // Unselected: bg-[#ebe8e0] dark:bg-[#3a352a]
    final bg = isSelected
        ? primary
        : (isDarkMode ? const Color(0xFF3a352a) : const Color(0xFFebe8e0));
    final textColor = isSelected
        ? const Color(0xFF1b170d)
        : (isDarkMode ? const Color(0xFFf3efe7) : const Color(0xFF1b170d));

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: GoogleFonts.lexend(
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildMediaItem({
    required String imageUrl,
    bool isVideo = false,
    String? duration,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey,
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: isVideo
          ? Stack(
              alignment: Alignment.center,
              children: [
                Container(color: Colors.black.withOpacity(0.2)),
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: primary.withOpacity(0.9),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    color: Color(0xFF1b170d),
                    size: 28,
                  ),
                ),
                if (duration != null)
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        duration,
                        style: GoogleFonts.lexend(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            )
          : null,
    );
  }

  Widget _buildSquareImage(String imageUrl) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
