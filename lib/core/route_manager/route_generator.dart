import 'package:flutter/material.dart';
import 'package:super_fitness/core/route_manager/app_routes.dart';
import 'package:super_fitness/features/auth/presentation/register/views/register_view.dart';
import 'package:super_fitness/features/on_boarding/views/on_boarding_view.dart';

class RouteGenerator {
  static Route<dynamic>? getRoute(RouteSettings setting) {
    switch (setting.name) {
      case AppRoutes.onBoarding:
        return _buildRoute(const OnBoardingView());
      case AppRoutes.registerAndCompleteRegistration:
        return _buildRoute(const RegisterView());
      default:
        return null;
    }
  }

  static Route _buildRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (_, _, _) => page,
      transitionsBuilder: (_, animation, _, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
