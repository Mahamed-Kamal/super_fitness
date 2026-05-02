import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/profile/domain/use_cases/get_profile_data_use_case.dart';
import 'package:super_fitness/features/profile/presentation/view_model/profile_events.dart';
import 'package:super_fitness/features/profile/presentation/view_model/profile_states.dart';

import '../../domain/entity/user_entity.dart' show UserEntity;

@injectable
// ignore: must_be_immutable
class ProfileViewModel extends Cubit<ProfileStates> with EquatableMixin {
  final GetProfileDataUseCase _getProfileDataUseCase;

  ProfileViewModel(this._getProfileDataUseCase) : super(ProfileStates());

  @override
  List<Object> get props {
    return [state];
  }

  final _uiController = StreamController<ProfileUiEvents>.broadcast();

  Stream<ProfileUiEvents> get uiEvents => _uiController.stream;

  void doEvent(ProfileUiEvents event) {
    switch (event) {
      case OnLogoutClickIntent():
        _uiController.add(OnLogoutClickIntent());
      case OnLSecurityClickIntent():
        _uiController.add(OnLSecurityClickIntent());
      case OnPrivacyClickIntent():
        _uiController.add(OnPrivacyClickIntent());
      case OnHeloClickIntent():
        _uiController.add(OnHeloClickIntent());
      case OnEditProfileClickIntent():
        _uiController.add(OnEditProfileClickIntent());
    }
  }

  void doIntent(ProfileEvents event) {
    switch (event) {
      case GetUserDataEvent():
        _getUserData();
    }
  }

  Future<void> _getUserData() async {
    emit(
      state.copyWith(userData: BaseState(requestState: RequestState.loading)),
    );
    final Result<UserEntity> result = await _getProfileDataUseCase.call();
    switch (result) {
      case SuccessResponse<UserEntity>():
        {
          emit(
            state.copyWith(
              userData: BaseState(
                requestState: RequestState.loaded,
                data: result.data,
              ),
            ),
          );
        }

      case FailureResponse<UserEntity>():
        {
          emit(
            state.copyWith(
              userData: BaseState(
                requestState: RequestState.error,
                errorMessage: result.errorMessage,
              ),
            ),
          );
        }
    }
  }
}
