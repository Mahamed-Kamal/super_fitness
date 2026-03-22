import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// AppThemeExtension
// ─────────────────────────────────────────────────────────────────────────────

class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  // ── Text styles ───────────────────────────────────────────────────────────
  final TextStyle semiBold24;
  final TextStyle medium20;
  final TextStyle semiBold18;
  final TextStyle semiBold16;
  final TextStyle medium16;
  final TextStyle medium13;
  final TextStyle regular16;
  final TextStyle regular14;
  final TextStyle regular12;
  final TextStyle semiBold12;

  // ── Colors ────────────────────────────────────────────────────────────────
  final MaterialColor primary;
  final MaterialColor neutral;
  final Color backgroundColor;
  final Color surface;
  final Color onBackground;
  final Color textSecondary;
  final Color error;
  final Color glassBackground;
  final Color surfaceOverlayLow;
  final Color borderMuted;
  final Color textMuted;
  final Color inputOutline;
  final Color scaffoldBase;
  final Color blackElevated;
  final Color blackPure;

  const AppThemeExtension({
    // text
    required this.semiBold24,
    required this.medium20,
    required this.semiBold18,
    required this.semiBold16,
    required this.medium16,
    required this.medium13,
    required this.regular16,
    required this.regular14,
    required this.regular12,
    required this.semiBold12,
    // colors
    required this.primary,
    required this.neutral,
    required this.backgroundColor,
    required this.surface,
    required this.onBackground,
    required this.textSecondary,
    required this.error,
    required this.glassBackground,
    required this.surfaceOverlayLow,
    required this.borderMuted,
    required this.textMuted,
    required this.inputOutline,
    required this.scaffoldBase,
    required this.blackElevated,
    required this.blackPure,
  });

  @override
  AppThemeExtension copyWith({
    TextStyle? semiBold24,
    TextStyle? medium20,
    TextStyle? semiBold18,
    TextStyle? semiBold16,
    TextStyle? medium16,
    TextStyle? medium13,
    TextStyle? regular16,
    TextStyle? regular14,
    TextStyle? regular12,
    TextStyle? semiBold12,
    MaterialColor? primary,
    MaterialColor? neutral,
    Color? backgroundColor,
    Color? surface,
    Color? onBackground,
    Color? textSecondary,
    Color? error,
    Color? glassBackground,
    Color? surfaceOverlayLow,
    Color? borderMuted,
    Color? textMuted,
    Color? inputOutline,
    Color? scaffoldBase,
    Color? blackElevated,
    Color? blackPure,
  }) {
    return AppThemeExtension(
      semiBold24: semiBold24 ?? this.semiBold24,
      medium20: medium20 ?? this.medium20,
      semiBold18: semiBold18 ?? this.semiBold18,
      semiBold16: semiBold16 ?? this.semiBold16,
      medium16: medium16 ?? this.medium16,
      medium13: medium13 ?? this.medium13,
      regular16: regular16 ?? this.regular16,
      regular14: regular14 ?? this.regular14,
      regular12: regular12 ?? this.regular12,
      semiBold12: semiBold12 ?? this.semiBold12,
      primary: primary ?? this.primary,
      neutral: neutral ?? this.neutral,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      surface: surface ?? this.surface,
      onBackground: onBackground ?? this.onBackground,
      textSecondary: textSecondary ?? this.textSecondary,
      error: error ?? this.error,
      glassBackground: glassBackground ?? this.glassBackground,
      surfaceOverlayLow: surfaceOverlayLow ?? this.surfaceOverlayLow,
      borderMuted: borderMuted ?? this.borderMuted,
      textMuted: textMuted ?? this.textMuted,
      inputOutline: inputOutline ?? this.inputOutline,
      scaffoldBase: scaffoldBase ?? this.scaffoldBase,
      blackElevated: blackElevated ?? this.blackElevated,
      blackPure: blackPure ?? this.blackPure,
    );
  }

  @override
  AppThemeExtension lerp(AppThemeExtension? other, double t) {
    if (other == null) return this;
    return AppThemeExtension(
      semiBold24: TextStyle.lerp(semiBold24, other.semiBold24, t)!,
      medium20: TextStyle.lerp(medium20, other.medium20, t)!,
      semiBold18: TextStyle.lerp(semiBold18, other.semiBold18, t)!,
      semiBold16: TextStyle.lerp(semiBold16, other.semiBold16, t)!,
      medium16: TextStyle.lerp(medium16, other.medium16, t)!,
      medium13: TextStyle.lerp(medium13, other.medium13, t)!,
      regular16: TextStyle.lerp(regular16, other.regular16, t)!,
      regular14: TextStyle.lerp(regular14, other.regular14, t)!,
      regular12: TextStyle.lerp(regular12, other.regular12, t)!,
      semiBold12: TextStyle.lerp(semiBold12, other.semiBold12, t)!,
      primary: _interpolateMaterialColor(primary, other.primary, t),
      neutral: _interpolateMaterialColor(neutral, other.neutral, t),
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      onBackground: Color.lerp(onBackground, other.onBackground, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      error: Color.lerp(error, other.error, t)!,
      glassBackground: Color.lerp(glassBackground, other.glassBackground, t)!,
      surfaceOverlayLow: Color.lerp(
        surfaceOverlayLow,
        other.surfaceOverlayLow,
        t,
      )!,
      borderMuted: Color.lerp(borderMuted, other.borderMuted, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      inputOutline: Color.lerp(inputOutline, other.inputOutline, t)!,
      scaffoldBase: Color.lerp(scaffoldBase, other.scaffoldBase, t)!,
      blackElevated: Color.lerp(blackElevated, other.blackElevated, t)!,
      blackPure: Color.lerp(blackPure, other.blackPure, t)!,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Helpers
// ─────────────────────────────────────────────────────────────────────────────

MaterialColor _interpolateMaterialColor(
  MaterialColor a,
  MaterialColor b,
  double t,
) {
  final shades = <int, Color>{};
  for (final key in a.keys) {
    final colorA = a[key]!;
    final colorB = b[key] ?? colorA;

    shades[key] = Color.lerp(colorA, colorB, t)!;
  }

  return MaterialColor(
    Color.lerp(a.shade500, b.shade500, t)!.toARGB32(),
    shades,
  );
}
