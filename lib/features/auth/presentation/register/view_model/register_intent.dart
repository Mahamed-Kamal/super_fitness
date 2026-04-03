import 'package:equatable/equatable.dart';
import 'package:super_fitness/features/auth/domain/entities/activity_level.dart';
import 'package:super_fitness/features/auth/domain/entities/user_gender.dart';
import 'package:super_fitness/features/auth/domain/entities/user_goal.dart';

sealed class RegisterIntent {}

class RegisterButtonClickedIntent extends RegisterIntent with EquatableMixin {
  final String firstName, lastName, email, password;

  RegisterButtonClickedIntent({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [firstName, lastName, email, password];
}

class LoginNavigationButtonClickedIntent extends RegisterIntent
    with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class SwitchViewToSelectWeight extends RegisterIntent with EquatableMixin {
  final UserGender userGender;

  SwitchViewToSelectWeight({required this.userGender});

  @override
  List<Object?> get props => [userGender];
}

class SwitchViewToSelectHeight extends RegisterIntent with EquatableMixin {
  final int weight;

  SwitchViewToSelectHeight({required this.weight});

  @override
  List<Object?> get props => [weight];
}

class SwitchViewToSelectGoal extends RegisterIntent with EquatableMixin {
  final int height;

  SwitchViewToSelectGoal({required this.height});

  @override
  List<Object?> get props => [height];
}

class SwitchViewToSelectActivityLevel extends RegisterIntent
    with EquatableMixin {
  final UserGoal goal;

  SwitchViewToSelectActivityLevel({required this.goal});

  @override
  List<Object?> get props => [goal];
}

class FinishRegisterIntent extends RegisterIntent with EquatableMixin {
  final ActivityLevel activityLevel;

  FinishRegisterIntent({required this.activityLevel});

  @override
  List<Object?> get props => [activityLevel];
}

class RegisterStepNavBackIntent extends RegisterIntent with EquatableMixin {
  @override
  List<Object?> get props => [];
}
