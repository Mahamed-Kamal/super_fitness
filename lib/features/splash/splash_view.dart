import 'package:flutter/material.dart';
import 'package:super_fitness/core/route_manager/app_routes.dart';
import 'package:super_fitness/core/utils/local/app_local_storage.dart';
import 'package:super_fitness/core/utils/local/local_keys.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _resolveInitialRoute();
  }

  Future<void> _resolveInitialRoute() async {
    final seenOnBoarding = await AppLocalStorage.getBool(LocalKeys.onBoarding);

    if (!seenOnBoarding) {
      _navigate(AppRoutes.onboardingView);
      return;
    }

    final token = await AppLocalStorage.getSecuredString(
      key: LocalKeys.authToken,
    );

    if (token.isNotEmpty) {
      _navigate(AppRoutes.appSectionView);
    } else {
      _navigate(AppRoutes.login);
    }
  }

  void _navigate(String route) {
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(route);
  }

  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: CircularProgressIndicator()));
}
