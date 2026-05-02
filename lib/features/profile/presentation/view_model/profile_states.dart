import 'package:equatable/equatable.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import '../../domain/entity/user_entity.dart' show UserEntity;

class ProfileStates extends Equatable {
  final BaseState<UserEntity>? userData;
  const ProfileStates({this.userData});
  @override
  List<Object?> get props => [userData];

  ProfileStates copyWith({BaseState<UserEntity>? userData}) {
    return ProfileStates(userData: userData ?? this.userData);
  }
}
