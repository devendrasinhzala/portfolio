import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  // Dark Theme Palette (Deep Ocean/Slate theme)
  static const Color darkBg = Color(0xff0B0F19);
  static const Color darkCardBg = Color(0xff111A2E);
  static const Color darkAccentTeal = Color(0xff64FFDA);
  static const Color darkAccentIndigo = Color(0xff6366F1);
  static const Color darkTextPrimary = Color(0xffF2F5FA);
  static const Color darkTextSecondary = Color(0xff94A3B8);

  // Light Theme Palette (Clean Slate/Indigo theme)
  static const Color lightBg = Color(0xffF8FAFC);
  static const Color lightCardBg = Color(0xffFFFFFF);
  static const Color lightAccentIndigo = Color(0xff4F46E5);
  static const Color lightAccentTeal = Color(0xff0D9488);
  static const Color lightTextPrimary = Color(0xff0F172A);
  static const Color lightTextSecondary = Color(0xff475569);

  // Gradients
  static const Gradient darkHeroGradient = LinearGradient(
    colors: [darkAccentIndigo, darkAccentTeal],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient lightHeroGradient = LinearGradient(
    colors: [lightAccentIndigo, lightAccentTeal],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Glassmorphic Card decoration helper
  static Decoration glassDecoration({
    required BuildContext context,
    required double opacity,
    required double borderRadius,
    required Color borderColor,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BoxDecoration(
      color: (isDark ? darkCardBg : lightCardBg).withOpacity(opacity),
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: borderColor,
        width: 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: isDark 
              ? Colors.black.withOpacity(0.3) 
              : Colors.grey.withOpacity(0.1),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }

  // Dark Theme Settings
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBg,
      primaryColor: darkAccentTeal,
      colorScheme: const ColorScheme.dark(
        primary: darkAccentTeal,
        secondary: darkAccentIndigo,
        surface: darkCardBg,
        onSurface: darkTextPrimary,
        error: Colors.redAccent,
      ),
      cardColor: darkCardBg,
      textTheme: TextTheme(
        displayLarge: GoogleFonts.outfit(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: darkTextPrimary,
          letterSpacing: -1.0,
        ),
        displayMedium: GoogleFonts.outfit(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: darkTextPrimary,
        ),
        titleLarge: GoogleFonts.outfit(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: darkTextPrimary,
        ),
        titleMedium: GoogleFonts.outfit(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: darkAccentTeal,
        ),
        bodyLarge: GoogleFonts.outfit(
          fontSize: 16,
          color: darkTextPrimary,
          height: 1.6,
        ),
        bodyMedium: GoogleFonts.outfit(
          fontSize: 14,
          color: darkTextSecondary,
          height: 1.5,
        ),
        labelLarge: GoogleFonts.firaCode(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: darkAccentTeal,
        ),
        labelSmall: GoogleFonts.firaCode(
          fontSize: 12,
          color: darkTextSecondary,
        ),
      ),
      iconTheme: const IconThemeData(color: darkTextPrimary),
      dividerColor: darkTextSecondary.withOpacity(0.2),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: darkTextPrimary),
      ),
    );
  }

  // Light Theme Settings
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightBg,
      primaryColor: lightAccentIndigo,
      colorScheme: const ColorScheme.light(
        primary: lightAccentIndigo,
        secondary: lightAccentTeal,
        surface: lightCardBg,
        onSurface: lightTextPrimary,
        error: Colors.redAccent,
      ),
      cardColor: lightCardBg,
      textTheme: TextTheme(
        displayLarge: GoogleFonts.outfit(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: lightTextPrimary,
          letterSpacing: -1.0,
        ),
        displayMedium: GoogleFonts.outfit(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: lightTextPrimary,
        ),
        titleLarge: GoogleFonts.outfit(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: lightTextPrimary,
        ),
        titleMedium: GoogleFonts.outfit(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: lightAccentIndigo,
        ),
        bodyLarge: GoogleFonts.outfit(
          fontSize: 16,
          color: lightTextPrimary,
          height: 1.6,
        ),
        bodyMedium: GoogleFonts.outfit(
          fontSize: 14,
          color: lightTextSecondary,
          height: 1.5,
        ),
        labelLarge: GoogleFonts.firaCode(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: lightAccentIndigo,
        ),
        labelSmall: GoogleFonts.firaCode(
          fontSize: 12,
          color: lightTextSecondary,
        ),
      ),
      iconTheme: const IconThemeData(color: lightTextPrimary),
      dividerColor: lightTextSecondary.withOpacity(0.2),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: lightTextPrimary),
      ),
    );
  }
}
