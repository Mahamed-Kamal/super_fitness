import 'package:flutter/material.dart';
import 'package:super_fitness/core/extensions/theme_extension.dart';
import 'package:super_fitness/core/theme/colors/app_colors.dart';

abstract class AppTheme {
  AppColors get color;
  AppThemeExtension get appThemeExtension;
  ThemeData get themeData;
  ElevatedButtonThemeData get elevatedButtonTheme;
  OutlinedButtonThemeData get outlinedButtonTheme;
  TextButtonThemeData get textButtonTheme;
  InputDecorationTheme get inputDecorationTheme;
  AppBarTheme get appBarTheme;
  BottomNavigationBarThemeData get bottomNavigationBarTheme;
}
