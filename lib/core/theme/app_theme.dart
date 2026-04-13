import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─── Color Tokens (Stitch: designTheme.namedColors) ───────────────────────────

class AppColors {
  AppColors._();

  static const Color background = Color(0xFF0E0E0E);
  static const Color surface = Color(0xFF1A1919);
  static const Color surfaceLow = Color(0xFF131313);
  static const Color surfaceHigh = Color(0xFF262626);
  static const Color primary = Color(0xFFCAFD00);
  static const Color onPrimary = Color(0xFF516700);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFADAAAA);
}

// ─── Radius Tokens ────────────────────────────────────────────────────────────

class AppRadius {
  AppRadius._();

  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double full = 999;
}

// ─── Text Styles (Space Grotesk = headlines, Inter = body) ───────────────────

class AppTextStyles {
  AppTextStyles._();

  static TextStyle headlineBold(double size, {Color color = AppColors.textPrimary}) =>
      GoogleFonts.spaceGrotesk(
        fontWeight: FontWeight.bold,
        fontSize: size,
        color: color,
      );

  static TextStyle headlineBoldItalic(double size,
          {Color color = AppColors.textPrimary}) =>
      GoogleFonts.spaceGrotesk(
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        fontSize: size,
        color: color,
      );

  static TextStyle body(double size, {Color color = AppColors.textSecondary}) =>
      GoogleFonts.inter(
        fontWeight: FontWeight.normal,
        fontSize: size,
        color: color,
      );

  static TextStyle bodyBold(double size, {Color color = AppColors.textPrimary}) =>
      GoogleFonts.inter(
        fontWeight: FontWeight.bold,
        fontSize: size,
        color: color,
      );

  // All-caps tracking labels used for form field headers
  static TextStyle label(double size, {Color color = AppColors.textSecondary}) =>
      GoogleFonts.inter(
        fontWeight: FontWeight.bold,
        fontSize: size,
        color: color,
        letterSpacing: 1.5,
      );
}

// ─── Decoration Helpers ───────────────────────────────────────────────────────

/// Solid surface container with rounded corners. Pass [useBlur] for glassmorphism.
BoxDecoration glassDecoration({
  double radius = AppRadius.lg,
  bool useBlur = false,
}) {
  return BoxDecoration(
    color: AppColors.surface,
    borderRadius: BorderRadius.circular(radius),
  );
}

/// Neon glow shadow for primary-colored elements.
List<BoxShadow> neonGlow({
  Color color = AppColors.primary,
  double blurRadius = 20,
  double spread = 0,
  double opacity = 0.35,
}) {
  return [
    BoxShadow(
      color: color.withValues(alpha: opacity),
      blurRadius: blurRadius,
      spreadRadius: spread,
    ),
  ];
}

// ─── ThemeData ────────────────────────────────────────────────────────────────

class AppTheme {
  AppTheme._();

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        surface: AppColors.surface,
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        onSurface: AppColors.textPrimary,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.surfaceHigh,
        contentTextStyle: GoogleFonts.inter(color: AppColors.textPrimary),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
      ),
    );
  }
}
