import 'package:equatable/equatable.dart';

sealed class RegisterIntent {}

class SwitchToSelectGender extends RegisterIntent with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class SwitchToSelectAge extends RegisterIntent with EquatableMixin {
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

class RegisterButtonClickedIntent extends RegisterIntent with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class LoginNavigationButtonClickedIntent extends RegisterIntent
    with EquatableMixin {
  @override
  List<Object?> get props => [];
}
