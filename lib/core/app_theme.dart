import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Brand Colors
  static const Color primary = Color(0xFF2bee6c); // Vibrant Green
  static const Color primaryDark = Color(0xFF22bd56);
  static const Color secondary = Color(0xFF135bec); // Trust Blue
  static const Color accent = Color(0xFFff9f1c); // Playful Orange
  static const Color error = Color(0xFFef4444);
  static const Color success = Color(0xFF22c55e);

  // Background Colors
  static const Color backgroundLight = Color(0xFFf6f8f6);
  static const Color backgroundDark = Color(0xFF102216);
  static const Color surfaceLight = Color(0xFFffffff);
  static const Color surfaceDark = Color(0xFF1a2c20);

  // Text Colors
  static const Color textMainLight = Color(0xFF0d1b12);
  static const Color textMainDark = Color(0xFFf0fdf4);
  static const Color textSubLight = Color(0xFF4c9a66);
  static const Color textSubDark = Color(0xFF8fc7a6);
}

class AppTextStyles {
  static TextStyle headingLarge(bool isDarkMode) => GoogleFonts.lexend(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: isDarkMode ? AppColors.textMainDark : AppColors.textMainLight,
  );

  static TextStyle headingMedium(bool isDarkMode) => GoogleFonts.lexend(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: isDarkMode ? AppColors.textMainDark : AppColors.textMainLight,
  );

  static TextStyle bodyLarge(bool isDarkMode) => GoogleFonts.lexend(
    fontSize: 16,
    color: isDarkMode ? AppColors.textMainDark : AppColors.textMainLight,
  );

  static TextStyle bodyMedium(bool isDarkMode) => GoogleFonts.lexend(
    fontSize: 14,
    color: isDarkMode ? AppColors.textSubDark : AppColors.textSubLight,
  );

  static TextStyle buttonText = GoogleFonts.lexend(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: const Color(0xFF102216), // Dark text on primary button
  );
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surfaceLight,
        background: AppColors.backgroundLight,
        error: AppColors.error,
      ),
      iconTheme: const IconThemeData(color: AppColors.textMainLight),
      textTheme: GoogleFonts.lexendTextTheme(ThemeData.light().textTheme).apply(
        bodyColor: AppColors.textMainLight,
        displayColor: AppColors.textMainLight,
      ),
      useMaterial3: true,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surfaceDark,
        background: AppColors.backgroundDark,
        error: AppColors.error,
      ),
      iconTheme: const IconThemeData(color: AppColors.textMainDark),
      textTheme: GoogleFonts.lexendTextTheme(ThemeData.dark().textTheme).apply(
        bodyColor: AppColors.textMainDark,
        displayColor: AppColors.textMainDark,
      ),
      useMaterial3: true,
    );
  }
}
