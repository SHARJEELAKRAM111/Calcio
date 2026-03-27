import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF131313);
  static const Color darkSurface = Color(0xFF1C1B1B);
  static const Color darkSurfaceHigh = Color(0xFF2A2A2A);
  static const Color primaryCyan = Color(0xFF00E5FF);
  static const Color onPrimary = Color(0xFF00363D);
  static const Color operatorColor = Color(0xFF2C2C2E);
  static const Color textHighContrast = Color(0xFFE5E2E1);
  static const Color textMuted = Color(0xFFBAC9CC);
  
  // Light Theme Colors (Inverse logic)
  static const Color lightBackground = Color(0xFFF0F0F0);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceHigh = Color(0xFFE0E0E0);
  static const Color textHighContrastLight = Color(0xFF131313);
  static const Color textMutedLight = Color(0xFF555555);

  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: darkBackground,
        colorScheme: const ColorScheme.dark(
          primary: primaryCyan,
          surface: darkSurface,
          onSurface: textHighContrast,
        ),
        textTheme: TextTheme(
          displayLarge: GoogleFonts.spaceGrotesk(
            fontSize: 56, // Large result
            fontWeight: FontWeight.bold,
            letterSpacing: -0.04 * 56,
            color: textHighContrast,
          ),
          headlineSmall: GoogleFonts.spaceGrotesk(
            fontSize: 24, // Expression input
            fontWeight: FontWeight.w500,
            color: textMuted,
          ),
          titleMedium: GoogleFonts.inter(
            fontSize: 18, // Keypad labels
            fontWeight: FontWeight.w500,
            color: textHighContrast,
          ),
          labelSmall: GoogleFonts.inter(
            fontSize: 11, // Scientific sub-labels
            color: primaryCyan,
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: darkBackground,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: GoogleFonts.spaceGrotesk(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: textHighContrast,
          ),
        ),
      );

  static ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: lightBackground,
        colorScheme: const ColorScheme.light(
          primary: primaryCyan,
          surface: lightSurface,
          onSurface: textHighContrastLight,
        ),
        textTheme: TextTheme(
          displayLarge: GoogleFonts.spaceGrotesk(
            fontSize: 56,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.04 * 56,
            color: textHighContrastLight,
          ),
          headlineSmall: GoogleFonts.spaceGrotesk(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: textMutedLight,
          ),
          titleMedium: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: textHighContrastLight,
          ),
          labelSmall: GoogleFonts.inter(
            fontSize: 11,
            color: primaryCyan,
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: lightBackground,
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: textHighContrastLight),
          titleTextStyle: GoogleFonts.spaceGrotesk(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: textHighContrastLight,
          ),
        ),
      );
}
