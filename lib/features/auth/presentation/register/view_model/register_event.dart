import 'package:equatable/equatable.dart';

sealed class RegisterEvent {}

class NavigateFromRegisterToLoginEvent extends RegisterEvent
    with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class UserRegisterSuccessfulEvent extends RegisterEvent with EquatableMixin {
  final String message;

  UserRegisterSuccessfulEvent({required this.message});

  @override
  List<Object?> get props => [message];
}

class UserRegisterFailedEvent extends RegisterEvent with EquatableMixin {
  final String message;

  UserRegisterFailedEvent({required this.message});

  @override
  List<Object?> get props => [message];
}

class OnboardingCompletedEvent extends RegisterEvent with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class UpdateUserDataFailedEvent extends RegisterEvent with EquatableMixin {
  final String message;

  UpdateUserDataFailedEvent({required this.message});

  @override
  List<Object?> get props => [message];
}
