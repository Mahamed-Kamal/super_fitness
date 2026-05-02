import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness/core/route_manager/app_routes.dart';
import 'package:super_fitness/core/route_manager/route_generator.dart';
import 'package:super_fitness/core/theme/app_theme/dark_theme.dart';
import 'package:super_fitness/core/utils/local/app_local_storage.dart';
import 'package:super_fitness/core/utils/local/local_keys.dart';

class SuperFitnessApp extends StatefulWidget {
  const SuperFitnessApp({super.key});

  @override
  State<SuperFitnessApp> createState() => _SuperFitnessAppState();
}

class _SuperFitnessAppState extends State<SuperFitnessApp> {
  Future<String?> checkInitRoute() async {
    // OnBoarding
    final seenOnBoarding = await AppLocalStorage.getBool(LocalKeys.onBoarding);
    if (!seenOnBoarding) return AppRoutes.onboardingView;

    // Auto Login
    final token = await AppLocalStorage.getSecuredString(
      key: LocalKeys.authToken,
    );
    if (token.isNotEmpty) return AppRoutes.appSectionView;

    return AppRoutes.login;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: AppRoutes.login,
      future: checkInitRoute(),
      builder: (context, asyncSnapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Super Fitness',
          // Localization
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          theme: DarkTheme().themeData,
          themeMode: ThemeMode.dark,
          initialRoute: asyncSnapshot.data,
          onGenerateRoute: RouteGenerator.getRoute,
        );
      },
    );
  }
}
