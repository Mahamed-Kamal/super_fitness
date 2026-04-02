import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/di/di.dart';
import 'package:super_fitness/core/route_manager/app_routes.dart';
import 'package:super_fitness/features/auth/presentation/login/view_model/login_view_model.dart';
import 'package:super_fitness/features/auth/presentation/login/views/login_view.dart';

class RouteGenerator {
  static Route<dynamic>? getRoute(RouteSettings setting) {
    switch (setting.name) {
        case AppRoutes.login:
        return _buildRoute(BlocProvider(
            create: (context) => getIt<LoginViewModel>(),
            child: const LoginView()));
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
