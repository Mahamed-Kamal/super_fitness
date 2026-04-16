import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/di/di.dart';
import 'package:super_fitness/core/route_manager/app_routes.dart';
import 'package:super_fitness/features/auth/presentation/forget_password/view_model/forget_password_view_model.dart';
import 'package:super_fitness/features/auth/presentation/forget_password/views/forget_password_view.dart';
import 'package:super_fitness/features/auth/presentation/forget_password/views/otp_view.dart';
import 'package:super_fitness/features/auth/presentation/forget_password/views/reset_password_view.dart';
import 'package:super_fitness/features/on_boarding/views/on_boarding_view.dart';

class RouteGenerator {
  static final _forgetPasswordViewModel = getIt.get<ForgetPasswordViewModel>();

  static Route<dynamic>? getRoute(RouteSettings setting) {
    switch (setting.name) {
      case AppRoutes.onBoarding:
        return _buildRoute(const OnBoardingView());
      case AppRoutes.forgetPassword:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _forgetPasswordViewModel,
            child: const ForgetPasswordView(),
          ),
        );
      case AppRoutes.otp:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _forgetPasswordViewModel,
            child: const OtpView(),
          ),
        );

      case AppRoutes.resetPassword:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _forgetPasswordViewModel,
            child: const ResetPasswordView(),
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
