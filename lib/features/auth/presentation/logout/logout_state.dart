import 'package:equatable/equatable.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/features/auth/domain/entity/logout_entity.dart';

class LogoutStates extends Equatable {
  final BaseState<LogoutEntity>? logoutState;

  const LogoutStates({this.logoutState});

  @override
  List<Object?> get props => [logoutState];

  LogoutStates copyWith({BaseState<LogoutEntity>? logoutState}) {
    return LogoutStates(logoutState: logoutState ?? this.logoutState);
  }
}
