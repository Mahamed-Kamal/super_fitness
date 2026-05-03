import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness/core/route_manager/app_routes.dart';
import 'package:super_fitness/core/route_manager/route_generator.dart';
import 'package:super_fitness/core/theme/app_theme/dark_theme.dart';

class SuperFitnessApp extends StatefulWidget {
  const SuperFitnessApp({super.key});

  @override
  State<SuperFitnessApp> createState() => _SuperFitnessAppState();
}

class _SuperFitnessAppState extends State<SuperFitnessApp> {
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Super Fitness',
    locale: context.locale,
    supportedLocales: context.supportedLocales,
    localizationsDelegates: context.localizationDelegates,
    theme: DarkTheme().themeData,
    themeMode: ThemeMode.dark,
    initialRoute: AppRoutes.splash,
    // Always start here
    onGenerateRoute: RouteGenerator.getRoute,
  );
}
