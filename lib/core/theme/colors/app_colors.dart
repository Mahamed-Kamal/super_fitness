import 'package:flutter/material.dart';

/// Brand and UI tokens shared across themes.
/// Opacity hex: CC ≈ 80%, 33 ≈ 20%, 1A ≈ 10%.
abstract class AppColors {
  MaterialColor get primary;
  MaterialColor get neutral;

  Color get neutralBase => neutral[900]!;
  Color get backgroundColor;
  Color get surface;
  Color get onBackground;
  Color get textSecondary;
  Color get error;

  // ── Fitness  ─────────────────────────────────────
  /// #242424 @ ~80% — glass panels (`#242424CC`).
  Color get glassBackground;

  /// #242424 @ ~10% — soft fills, inputs on glass (`#2424241A`).
  Color get surfaceOverlayLow;
  Color get borderMuted;
  Color get textMuted;
  Color get inputOutline;
  Color get scaffoldBase;
  Color get blackElevated;
  Color get blackPure;
}
