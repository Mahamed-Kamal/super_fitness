import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_fitness/core/extensions/theme_extension.dart';
import 'package:super_fitness/core/theme/app_theme/app_theme.dart';
import 'package:super_fitness/core/theme/colors/app_colors.dart';
import 'package:super_fitness/core/theme/colors/dark_colors.dart';
import 'package:super_fitness/core/theme/fonts/app_font.dart';
import 'package:super_fitness/core/theme/fonts/my_font_weight.dart';

class DarkTheme extends AppTheme {
  @override
  AppColors get color => DarkColors();

  @override
  AppThemeExtension get appThemeExtension => AppThemeExtension(
    semiBold24: AppFont.semiBold24.copyWith(color: color.onBackground),
    medium20: AppFont.medium20.copyWith(color: color.onBackground),
    semiBold18: AppFont.semiBold18.copyWith(color: color.onBackground),
    semiBold16: AppFont.semiBold16.copyWith(color: color.onBackground),
    medium16: AppFont.medium16.copyWith(color: color.onBackground),
    medium13: AppFont.medium13.copyWith(color: color.onBackground),
    regular16: AppFont.regular16.copyWith(color: color.onBackground),
    regular14: AppFont.regular14.copyWith(color: color.onBackground),
    regular12: AppFont.regular12.copyWith(color: color.onBackground),
    semiBold12: AppFont.semiBold12.copyWith(color: color.onBackground),
    primary: color.primary,
    neutral: color.neutral,
    backgroundColor: color.backgroundColor,
    surface: color.surface,
    onBackground: color.onBackground,
    textSecondary: color.textSecondary,
    error: color.error,
    glassBackground: color.glassBackground,
    surfaceOverlayLow: color.surfaceOverlayLow,
    borderMuted: color.borderMuted,
    textMuted: color.textMuted,
    inputOutline: color.inputOutline,
    scaffoldBase: color.scaffoldBase,
    blackElevated: color.blackElevated,
    blackPure: color.blackPure,
  );
  @override
  ElevatedButtonThemeData get elevatedButtonTheme => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: color.primary,
      foregroundColor: color.onBackground,
      disabledBackgroundColor: color.neutral[100],
      disabledForegroundColor: color.onBackground,
      textStyle: AppFont.semiBold16.copyWith(
        fontWeight: MyFontWeight.extraBold,
          fontSize: 14
      ),
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      minimumSize: const Size(double.infinity, 40),
      shape: const StadiumBorder(),
    ),
  );

  @override
  OutlinedButtonThemeData get outlinedButtonTheme => OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: color.onBackground,
      backgroundColor: Colors.transparent,
      side: BorderSide(color: color.primary, width: 1),
      textStyle: AppFont.semiBold16.copyWith(
        fontWeight: MyFontWeight.extraBold,
      ),
      minimumSize: const Size(0, 52),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
    ),
  );

  @override
  TextButtonThemeData get textButtonTheme => TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: color.onBackground,
      backgroundColor: color.primary,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      textStyle: AppFont.semiBold16.copyWith(
        fontWeight: MyFontWeight.extraBold,
        fontSize: 14,
      ),
    ),
  );

  @override
  InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
    filled: true,
    fillColor: Colors.transparent,
    hintStyle: AppFont.regular16.copyWith(color: color.textMuted),
    labelStyle: AppFont.regular14.copyWith(color: color.textMuted),
    prefixIconColor: color.textMuted,
    suffixIconColor: color.textMuted,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: BorderSide(color: color.inputOutline),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: BorderSide(color: color.inputOutline),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: BorderSide(color: color.primary),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: BorderSide(color: color.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: BorderSide(color: color.error, width: 1.5),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  );

  @override
  AppBarTheme get appBarTheme => AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: color.onBackground,
    elevation: 0,
    centerTitle: true,
    surfaceTintColor: Colors.transparent,
    titleTextStyle: AppFont.semiBold18.copyWith(color: color.onBackground),
    iconTheme: IconThemeData(color: color.onBackground, size: 24),
    actionsIconTheme: IconThemeData(color: color.onBackground, size: 24),
  );

  @override
  BottomNavigationBarThemeData get bottomNavigationBarTheme =>
      BottomNavigationBarThemeData(
        backgroundColor: color.glassBackground,
        selectedItemColor: color.primary,
        unselectedItemColor: color.onBackground,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: AppFont.medium13,
        unselectedLabelStyle: AppFont.regular12,
      );

  @override
  ThemeData get themeData => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: color.scaffoldBase,
    primaryColor: color.primary,
    iconTheme: IconThemeData(color: color.textMuted),
    textTheme: GoogleFonts.balooThambi2TextTheme(
      ThemeData(brightness: Brightness.dark).textTheme.apply(
        bodyColor: color.onBackground,
        displayColor: color.onBackground,
      ),
    ),
    colorScheme: ColorScheme.dark(
      brightness: Brightness.dark,
      primary: color.primary,
      onPrimary: Colors.white,
      primaryContainer: color.primary[200]!,
      onPrimaryContainer: color.primary[900]!,
      secondary: color.neutral[500]!,
      onSecondary: color.onBackground,
      secondaryContainer: color.neutral[800]!,
      onSecondaryContainer: color.onBackground,
      error: color.error,
      onError: const Color(0xFF601410),
      errorContainer: const Color(0xFF93000A),
      onErrorContainer: const Color(0xFFFFDAD6),
      surface: color.neutral[900]!,
      onSurface: color.onBackground,
      surfaceContainerHighest: color.glassBackground,
      outline: color.borderMuted,
      outlineVariant: color.neutral[700]!,
    ),
    extensions: [appThemeExtension],
    elevatedButtonTheme: elevatedButtonTheme,
    outlinedButtonTheme: outlinedButtonTheme,
    textButtonTheme: textButtonTheme,
    inputDecorationTheme: inputDecorationTheme,
    appBarTheme: appBarTheme,
    bottomNavigationBarTheme: bottomNavigationBarTheme,
    dividerTheme: DividerThemeData(
      color: color.borderMuted,
      thickness: 1,
      space: 1,
    ),
    cardTheme: CardThemeData(
      color: color.glassBackground,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
        side: BorderSide(color: color.borderMuted),
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: color.glassBackground,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    ),
    switchTheme: SwitchThemeData(
      trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) return color.primary;
        return color.inputOutline;
      }),
      trackColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) return color.neutral;
        return color.neutral;
      }),
    ),
  );
}
