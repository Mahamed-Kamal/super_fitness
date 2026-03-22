import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness/core/theme/app_theme/dark_theme.dart';

Widget pumpWithDarkTheme(
  Widget body, {
  bool scaffold = true,
  GlobalKey<NavigatorState>? navigatorKey,
}) {
  final wrapped = scaffold ? Scaffold(body: Center(child: body)) : body;

  return MaterialApp(
    navigatorKey: navigatorKey,
    theme: DarkTheme().themeData,
    home: wrapped,
  );
}

Widget pumpWithDarkThemeAndI18n(Widget body) {
  return EasyLocalization(
    saveLocale: false,
    supportedLocales: const [Locale('en'), Locale('ar')],
    path: 'assets/translations',
    fallbackLocale: const Locale('en'),
    child: Builder(
      builder: (context) {
        return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: DarkTheme().themeData,
          home: Scaffold(body: Center(child: body)),
        );
      },
    ),
  );
}
