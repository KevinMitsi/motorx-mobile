import 'package:flutter/material.dart';

/// MotorX brand color palette.
///
/// Primary: Deep Navy Blue
/// Secondary: MotorX Red
/// Neutral: Black/Gray scale
///
/// Supports both light and dark themes via [lightColorScheme] / [darkColorScheme].
class AppColors {
  AppColors._();

  // ── Brand Colors ──────────────────────────────────────────
  static const Color brand = Color(0xFF0D47A1);
  static const Color brandLight = Color(0xFF5472D3);
  static const Color brandDark = Color(0xFF002171);

  static const Color accent = Color(0xFFC62828);
  static const Color accentLight = Color(0xFFFF5F52);
  static const Color accentDark = Color(0xFF8E0000);

  // ── Neutrals ──────────────────────────────────────────────
  static const Color black = Color(0xFF121212);
  static const Color darkGray = Color(0xFF1E1E1E);
  static const Color mediumGray = Color(0xFF424242);
  static const Color gray = Color(0xFF757575);
  static const Color lightGray = Color(0xFFBDBDBD);
  static const Color offWhite = Color(0xFFF5F5F5);
  static const Color white = Color(0xFFFFFFFF);

  // ── Semantic Colors ───────────────────────────────────────
  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFF57F17);
  static const Color error = Color(0xFFC62828);
  static const Color info = Color(0xFF0288D1);

  // ── Light Theme Color Scheme ──────────────────────────────
  static ColorScheme get lightColorScheme => const ColorScheme(
        brightness: Brightness.light,
        primary: brand,
        onPrimary: white,
        primaryContainer: Color(0xFFD1E4FF),
        onPrimaryContainer: Color(0xFF001D36),
        secondary: accent,
        onSecondary: white,
        secondaryContainer: Color(0xFFFFDAD6),
        onSecondaryContainer: Color(0xFF410002),
        tertiary: Color(0xFF006B5F),
        onTertiary: white,
        tertiaryContainer: Color(0xFF73F8E4),
        onTertiaryContainer: Color(0xFF00201C),
        error: Color(0xFFBA1A1A),
        onError: white,
        errorContainer: Color(0xFFFFDAD6),
        onErrorContainer: Color(0xFF410002),
        surface: white,
        onSurface: Color(0xFF1A1C1E),
        surfaceContainerHighest: Color(0xFFDFE2EB),
        onSurfaceVariant: Color(0xFF43474E),
        outline: Color(0xFF73777F),
        outlineVariant: Color(0xFFC3C6CF),
        shadow: Color(0xFF000000),
        scrim: Color(0xFF000000),
        inverseSurface: Color(0xFF2F3033),
        onInverseSurface: Color(0xFFF1F0F4),
        inversePrimary: Color(0xFF9ECAFF),
        surfaceTint: brand,
      );

  // ── Dark Theme Color Scheme ───────────────────────────────
  static ColorScheme get darkColorScheme => const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFF9ECAFF),
        onPrimary: Color(0xFF003258),
        primaryContainer: Color(0xFF094880),
        onPrimaryContainer: Color(0xFFD1E4FF),
        secondary: Color(0xFFFFB4AB),
        onSecondary: Color(0xFF690005),
        secondaryContainer: Color(0xFF93000A),
        onSecondaryContainer: Color(0xFFFFDAD6),
        tertiary: Color(0xFF52DBC8),
        onTertiary: Color(0xFF003731),
        tertiaryContainer: Color(0xFF005047),
        onTertiaryContainer: Color(0xFF73F8E4),
        error: Color(0xFFFFB4AB),
        onError: Color(0xFF690005),
        errorContainer: Color(0xFF93000A),
        onErrorContainer: Color(0xFFFFDAD6),
        surface: Color(0xFF121316),
        onSurface: Color(0xFFE2E2E6),
        surfaceContainerHighest: Color(0xFF43474E),
        onSurfaceVariant: Color(0xFFC3C6CF),
        outline: Color(0xFF8D9199),
        outlineVariant: Color(0xFF43474E),
        shadow: Color(0xFF000000),
        scrim: Color(0xFF000000),
        inverseSurface: Color(0xFFE2E2E6),
        onInverseSurface: Color(0xFF2F3033),
        inversePrimary: brand,
        surfaceTint: Color(0xFF9ECAFF),
      );
}
