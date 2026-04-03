import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/route_manager/app_routes.dart';
import 'package:super_fitness/features/app_section/view_model/app_section_view_model.dart';
import 'package:super_fitness/features/app_section/views/app_section_view.dart';
import 'package:super_fitness/features/on_boarding/views/on_boarding_view.dart';

class RouteGenerator {
  static Route<dynamic>? getRoute(RouteSettings setting) {
    switch (setting.name) {
      case AppRoutes.onBoarding:
        return _buildRoute(const OnBoardingView());
      case AppRoutes.appSectionView:
        return _buildRoute(
          BlocProvider(
            create: (context) => AppSectionViewModel(),
            child: const AppSectionView(),
          ),
        );
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
