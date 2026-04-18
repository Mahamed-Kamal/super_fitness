import 'package:equatable/equatable.dart';

sealed class RegisterEvent {}

class NavigateFromRegisterToLoginEvent extends RegisterEvent
    with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class UserRegisterFailedEvent extends RegisterEvent with EquatableMixin {
  final String message;

  UserRegisterFailedEvent({required this.message});

  @override
  List<Object?> get props => [message];
}

class RegisterCompletedEvent extends RegisterEvent with EquatableMixin {
  @override
  List<Object?> get props => [];
}
