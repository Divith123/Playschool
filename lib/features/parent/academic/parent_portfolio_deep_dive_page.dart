import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playschool/core/app_theme.dart';
import 'package:playschool/widgets/primary_button.dart';

class ParentPortfolioDeepDivePage extends StatefulWidget {
  const ParentPortfolioDeepDivePage({super.key});

  @override
  State<ParentPortfolioDeepDivePage> createState() =>
      _ParentPortfolioDeepDivePageState();
}

class _ParentPortfolioDeepDivePageState
    extends State<ParentPortfolioDeepDivePage> {
  // Mock data - normally passed via constructor
  final String _imageUrl = 'https://placehold.co/600x800/png?text=Art+Work';
  final String _title = 'Abstract Finger Painting';
  final String _date = 'Oct 28, 2025';
  final String _teacherNote =
      'Leo showed great focus today! He explored mixing red and blue to make purple. His fine motor skills in handling the brush were impressive.';
  bool _isLiked = false;

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
      backgroundColor: Colors.black, // Immersive view
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.download, color: Colors.white),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Zoomable Image
          Positioned.fill(
            child: InteractiveViewer(
              child: Image.network(_imageUrl, fit: BoxFit.contain),
            ),
          ),

          // Bottom Sheet with Info
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _title,
                            style: GoogleFonts.lexend(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          Text(
                            _date,
                            style: GoogleFonts.lexend(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () => setState(() => _isLiked = !_isLiked),
                        icon: Icon(
                          _isLiked ? Icons.favorite : Icons.favorite_border,
                          color: _isLiked ? Colors.red : Colors.grey,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Teacher\'s Observation:',
                    style: GoogleFonts.lexend(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _teacherNote,
                    style: GoogleFonts.lexend(
                      fontSize: 14,
                      color: textColor.withOpacity(0.8),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    label: 'Leave a Comment',
                    onPressed: () {},
                    width: double.infinity,
                    backgroundColor: isDarkMode
                        ? Colors.grey[800]
                        : Colors.grey[100],
                    textColor: textColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
