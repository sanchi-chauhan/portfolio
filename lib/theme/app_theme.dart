import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Periwinkle & Mauve Gradient - Dreamy & Elegant
  static const Color primaryColor = Color(0xFFAFB1FF); // Periwinkle
  static const Color secondaryColor = Color(0xFFD8C2FF); // Periwinkle 5
  static const Color accentColor = Color(0xFFECCAFF); // Mauve 2
  static const Color backgroundColor = Color(0xFF1A1625); // Deep Purple Navy
  static const Color surfaceColor = Color(0xFF2D2438); // Soft Dark Purple
  static const Color textPrimary = Color(0xFFE8E6FF); // Soft lavender white
  static const Color textSecondary = Color(0xFFB8B5D9); // Muted lavender grey

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: accentColor,
        surface: surfaceColor,
        background: backgroundColor,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.poppins(
          color: textPrimary,
          fontSize: 72,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: GoogleFonts.poppins(
          color: textPrimary,
          fontSize: 48,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: GoogleFonts.poppins(
          color: textPrimary,
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: GoogleFonts.poppins(
          color: textPrimary,
          fontSize: 28,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: GoogleFonts.poppins(
          color: secondaryColor, // Periwinkle 5 for titles
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: GoogleFonts.inter(
          color: textSecondary,
          fontSize: 18,
        ),
        bodyMedium: GoogleFonts.inter(
          color: textSecondary,
          fontSize: 16,
        ),
      ),
    );
  }

  static ThemeData get lightTheme {
    // Elegant Mauve/Pink Palette for Light Mode
    const Color mountbattenPink = Color(0xFFA288A6); // Muted purple-pink
    const Color roseQuartz = Color(0xFFBB9BB0); // Soft pink
    const Color silver = Color(0xFFCCBCBC); // Light gray with pink tint
    const Color lavenderBlush = Color(0xFFF1E3E4); // Very light pink-white

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: mountbattenPink,
      scaffoldBackgroundColor: lavenderBlush, // Main background
      colorScheme: const ColorScheme.light(
        primary: mountbattenPink, // Muted purple-pink
        secondary: roseQuartz, // Soft pink
        tertiary: silver, // Light gray with pink tint
        surface: const Color(0xFFFAF5F5), // Even lighter surface
        background: lavenderBlush, // Very light pink-white
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.poppins(
          color: const Color(0xFF5A5A5F), // Medium grey for headings
          fontSize: 72,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: GoogleFonts.poppins(
          color: const Color(0xFF5A5A5F), // Medium grey
          fontSize: 48,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: GoogleFonts.poppins(
          color: const Color(0xFF5A5A5F), // Medium grey
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: GoogleFonts.poppins(
          color:
              const Color(0xFF6A6A6F), // Slightly lighter grey for subheadings
          fontSize: 28,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: GoogleFonts.poppins(
          color: mountbattenPink, // Muted purple-pink for titles
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: GoogleFonts.inter(
          color: const Color(0xFF4A4A4E), // Slightly lighter for body
          fontSize: 18,
        ),
        bodyMedium: GoogleFonts.inter(
          color: const Color(0xFF4A4A4E),
          fontSize: 16,
        ),
      ),
    );
  }
}
