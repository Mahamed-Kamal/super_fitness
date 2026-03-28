import 'package:equatable/equatable.dart';

sealed class RegisterIntent {}

class RegisterButtonClickedIntent extends RegisterIntent with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class LoginNavigationButtonClickedIntent extends RegisterIntent
    with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class SwitchToSelectWeight extends RegisterIntent with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class SwitchToSelectHeight extends RegisterIntent with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class SwitchToSelectGoal extends RegisterIntent with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class SwitchToSelectActivityLevel extends RegisterIntent with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class FinishOnboardingIntent extends RegisterIntent with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class UpdateFirstNameIntent extends RegisterIntent with EquatableMixin {
  final String value;

  UpdateFirstNameIntent(this.value);

  @override
  List<Object?> get props => [value];
}

class UpdateLastNameIntent extends RegisterIntent with EquatableMixin {
  final String value;

  UpdateLastNameIntent(this.value);

  @override
  List<Object?> get props => [value];
}

class UpdateEmailIntent extends RegisterIntent with EquatableMixin {
  final String value;

  UpdateEmailIntent(this.value);

  @override
  List<Object?> get props => [value];
}

class UpdatePasswordIntent extends RegisterIntent with EquatableMixin {
  final String value;

  UpdatePasswordIntent(this.value);

  @override
  List<Object?> get props => [value];
}

class UpdateRePasswordIntent extends RegisterIntent with EquatableMixin {
  final String value;

  UpdateRePasswordIntent(this.value);

  @override
  List<Object?> get props => [value];
}

class UpdateGenderIntent extends RegisterIntent with EquatableMixin {
  final String gender;

  UpdateGenderIntent(this.gender);

  @override
  List<Object?> get props => [gender];
}

class UpdateWeightIntent extends RegisterIntent with EquatableMixin {
  final int weight;

  UpdateWeightIntent(this.weight);

  @override
  List<Object?> get props => [weight];
}

class UpdateHeightIntent extends RegisterIntent with EquatableMixin {
  final int height;

  UpdateHeightIntent(this.height);

  @override
  List<Object?> get props => [height];
}

class UpdateAgeIntent extends RegisterIntent with EquatableMixin {
  final int age;

  UpdateAgeIntent(this.age);

  @override
  List<Object?> get props => [age];
}

class UpdateGoalIntent extends RegisterIntent with EquatableMixin {
  final String goal;

  UpdateGoalIntent(this.goal);

  @override
  List<Object?> get props => [goal];
}

class UpdateActivityLevelIntent extends RegisterIntent with EquatableMixin {
  final String activityLevel;

  UpdateActivityLevelIntent(this.activityLevel);

  @override
  List<Object?> get props => [activityLevel];
}
