import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness/core/route_manager/app_routes.dart';
import 'package:super_fitness/core/route_manager/route_generator.dart';

import 'package:super_fitness/core/theme/app_theme/dark_theme.dart';

class SuperFitnessApp extends StatelessWidget {
  const SuperFitnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Super Fitness',
      // Localization
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      // Themes
      theme: DarkTheme().themeData,
      themeMode: ThemeMode.dark,
      initialRoute: AppRoutes.registerAndCompleteRegistration,
      onGenerateRoute: RouteGenerator.getRoute,
    );
  }
}
