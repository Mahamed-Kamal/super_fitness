import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/di/di.dart';
import 'package:super_fitness/core/route_manager/app_routes.dart';
import 'package:super_fitness/features/auth/presentation/change_password/view/change_password_view.dart';
import 'package:super_fitness/features/auth/presentation/change_password/view_model/change_password_view_model.dart';
import 'package:super_fitness/features/auth/presentation/login/view_model/login_view_model.dart';
import 'package:super_fitness/features/auth/presentation/login/views/login_view.dart';
import 'package:super_fitness/features/auth/presentation/forget_password/view_model/forget_password_view_model.dart';
import 'package:super_fitness/features/auth/presentation/forget_password/views/forget_password_view.dart';
import 'package:super_fitness/features/auth/presentation/forget_password/views/otp_view.dart';
import 'package:super_fitness/features/auth/presentation/forget_password/views/reset_password_view.dart';
import 'package:super_fitness/features/app_section/view_model/app_section_view_model.dart';
import 'package:super_fitness/features/app_section/views/app_section_view.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_view_model.dart';
import 'package:super_fitness/features/auth/presentation/register/views/register_view.dart';
import 'package:super_fitness/features/exercises/presentation/view/exercise_view.dart';
import 'package:super_fitness/features/exercises/presentation/view_model/exercises_view_model.dart';
import 'package:super_fitness/features/meals/presentation/meal_details/meal_details_view.dart';
import 'package:super_fitness/features/meals/presentation/meal_details/view_model/meal_details_view_model.dart';
import 'package:super_fitness/features/exercises/presentation/view/exercise_view.dart';
import 'package:super_fitness/features/exercises/presentation/view_model/exercises_view_model.dart';
import 'package:super_fitness/features/explore/presentation/view_model/explore_state.dart';
import 'package:super_fitness/features/explore/presentation/view_model/explore_view_model.dart';
import 'package:super_fitness/features/meals/presentation/meal_details/meal_details_view.dart';
import 'package:super_fitness/features/meals/presentation/meal_details/view_model/meal_details_view_model.dart';
import 'package:super_fitness/features/meals/presentation/meals/view_model/meals_view_model.dart';
import 'package:super_fitness/features/meals/presentation/meals/views/meals_view.dart';
import 'package:super_fitness/features/chat_ai/presentation/view_model/chat_view_model.dart';
import 'package:super_fitness/features/on_boarding/views/on_boarding_view.dart';
import '../../features/chat_ai/presentation/views/smart_coach_view.dart';
import 'package:super_fitness/features/profile/presentation/view_model/profile_events.dart';
import 'package:super_fitness/features/profile/presentation/view_model/profile_view_model.dart';

class RouteGenerator {
  static final _forgetPasswordViewModel = getIt.get<ForgetPasswordViewModel>();

  static Route<dynamic>? getRoute(RouteSettings setting) {
    switch (setting.name) {
      case AppRoutes.login:
        return _buildRoute(
          BlocProvider(
            create: (context) => getIt<LoginViewModel>(),
            child: const LoginView(),
          ),
          setting,
        );
      case AppRoutes.onBoarding:
      case AppRoutes.onboardingView:
        return _buildRoute(
          BlocProvider(
            create: (context) => getIt<ExercisesViewModel>(),
            child: const OnBoardingView(),
          ),
          setting,
        );

      case AppRoutes.registerAndCompleteRegistration:
        return _buildRoute(
          BlocProvider(
            create: (_) => getIt.get<RegisterViewModel>(),
            child: const RegisterView(),
          ),
          setting,
        );

      case AppRoutes.appSectionView:
        return _buildRoute(
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt.get<AppSectionViewModel>(),
              ),
              BlocProvider(
                create: (context) => getIt.get<ExploreViewModel>()
                  ..doIntent(LoadDataEvent())
                  ..loadPopular(),
              ),

              BlocProvider(
                create: (_) =>
                getIt<ProfileViewModel>()..doIntent(GetUserDataEvent()),
              ),

            ],
            child: const AppSectionView(),
          ),
          setting,
        );

      case AppRoutes.smartChatAi:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: getIt<ChatViewModel>(),
            child: const SmartCoachChatView(),
          ),
        );
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

      case AppRoutes.exercise:
        return _buildRoute(
          BlocProvider(
            create: (context) => getIt<ExercisesViewModel>(),
            child: const ExerciseView(),
          ),
          setting,
        );

      case AppRoutes.mealDetails:
        var vm = getIt.get<MealDetailsViewModel>();
        final String mealId = setting.arguments as String;
        return MaterialPageRoute(
          builder: (context) => BlocProvider<MealDetailsViewModel>(
            create: (_) => vm,
            child: MealDetailsView(id: mealId),
          ),
        );


      case AppRoutes.mealDetails:
        var vm = getIt.get<MealDetailsViewModel>();
        final String mealId = setting.arguments as String;
        return MaterialPageRoute(
          builder: (context) => BlocProvider<MealDetailsViewModel>(
            create: (_) => vm,
            child: MealDetailsView(id: mealId),
          ),
        );

      case AppRoutes.meals:
        return _buildRoute(
          BlocProvider(
            create: (context) => getIt<MealsViewModel>(),
            child: const MealsView(),
          ),
          setting,
        );
      case AppRoutes.changePassword:
        var viewModel = getIt.get<ChangePasswordViewModel>();
        return _buildRoute(
          BlocProvider(create: (_) => viewModel, child: ChangePasswordView()),
        );

      default:
        return null;
    }
  }

  static Route _buildRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (_, _, _) => page,
      transitionsBuilder: (_, animation, _, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
