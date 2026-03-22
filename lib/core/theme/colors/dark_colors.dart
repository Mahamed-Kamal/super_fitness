import 'package:flutter/material.dart';
import 'package:super_fitness/core/theme/colors/app_colors.dart';

/// Dark fitness UI — glass, orange primary.
class DarkColors extends AppColors {
  @override
  MaterialColor get primary => const MaterialColor(0xFFFF4100, {
    50: Color(0xFFFFECE5),
    100: Color(0xFFFFD9CC),
    200: Color(0xFFFFC6B2),
    300: Color(0xFFFFB399),
    400: Color(0xFFFFA080),
    500: Color(0xFFFF8D66),
    600: Color(0xFFFF7A4D),
    700: Color(0xFFFF6733),
    800: Color(0xFFFF541A),
    900: Color(0xFFE52800),
  });

  @override
  MaterialColor get neutral => const MaterialColor(0xFF242424, {
    50: Color(0xFFE9E9E9),
    100: Color(0xFFD3D3D3),
    200: Color(0xFFBDBDBD),
    300: Color(0xFFA7A7A7),
    400: Color(0xFF919191),
    500: Color(0xFF7C7C7C),
    600: Color(0xFF666666),
    700: Color(0xFF505050),
    800: Color(0xFF3A3A3A),
    900: Color(0xFF242424),
  });

  @override
  Color get backgroundColor => scaffoldBase;

  @override
  Color get surface => glassBackground;

  @override
  Color get onBackground => const Color(0xFFFFFFFF);

  @override
  Color get textSecondary => textMuted;

  @override
  Color get error => const Color(0xFFB20000);

  @override
  Color get glassBackground => const Color(0xCC242424);

  @override
  Color get surfaceOverlayLow => const Color(0x1A242424);

  @override
  Color get borderMuted => const Color(0x33D3D3D3);

  @override
  Color get textMuted => const Color(0xFFD3D3D3);

  @override
  Color get inputOutline => const Color(0xFFD9D9D9);

  @override
  Color get scaffoldBase => blackPure;

  @override
  Color get blackElevated => const Color(0xFF0B0B0B);

  @override
  Color get blackPure => const Color(0xFF000000);
}
