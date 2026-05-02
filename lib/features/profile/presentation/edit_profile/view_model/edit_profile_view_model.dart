import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/data/models/requests/update_user_data_request.dart';
import 'package:super_fitness/features/auth/domain/entities/user_entity.dart';
import 'package:super_fitness/features/profile/domain/use_cases/edit_profile_use_case.dart';
import 'package:super_fitness/features/profile/domain/use_cases/get_profile_data_use_case.dart';
import 'package:super_fitness/features/profile/domain/use_cases/upload_profile_photo_use_case.dart';
import 'package:super_fitness/features/profile/presentation/edit_profile/view_model/edit_profile_intent.dart';

part 'edit_profile_state.dart';

@injectable
class EditProfileViewModel extends Cubit<EditProfileState> {
  final EditProfileUseCase _editProfileUseCase;
  final GetProfileDataUseCase _getProfileDataUseCase;
  final UploadProfilePhotoUseCase _uploadProfilePhotoUseCase;

  final _uiEvents = StreamController<EditProfileUIEvent>.broadcast();
  Stream<EditProfileUIEvent> get uiEvents => _uiEvents.stream;

  EditProfileViewModel(
    this._editProfileUseCase,
    this._getProfileDataUseCase,
    this._uploadProfilePhotoUseCase,
  ) : super(EditProfileState.init());

  void doIntent(EditProfileIntent intent) {
    switch (intent) {
      case GetProfileDataIntent():
        _loadUser();
      case SubmitProfileIntent(:final request):
        _save(request);
      case OpenEditWeightIntent():
        _uiEvents.add(NavigateToEditWeightUIEvent(state.currentUser.weight));
      case OpenEditGoalIntent():
        _uiEvents.add(NavigateToEditGoalUIEvent(state.currentUser.goal));
      case OpenEditActivityLevelIntent():
        _uiEvents.add(
          NavigateToEditActivityLevelUIEvent(state.currentUser.activityLevel),
        );
      case final ApplyProfileDraftFromSubRouteIntent draft:
        _mergeDraftFromSubRoute(draft);
      case SelectLocalPhotoIntent(:final file):
        emit(state.copyWith(localImage: file));
      case UploadPhotoIntent(:final imageFile):
        _uploadPhoto(imageFile);
      case PickImageFromGalleryIntent():
        _uiEvents.add(const PopWithImageSourceEvent(ImageSource.gallery));
      case PickImageFromCameraIntent():
        _uiEvents.add(const PopWithImageSourceEvent(ImageSource.camera));
    }
  }

  void _mergeDraftFromSubRoute(ApplyProfileDraftFromSubRouteIntent intent) {
    final base = state.currentUser;
    if (state.getProfileDataState.data == null) return;

    final merged = base.copyWith(
      weight: intent.weight ?? base.weight,
      goal: intent.goal ?? base.goal,
      activityLevel: intent.activityLevel ?? base.activityLevel,
    );
    emit(
      state.copyWith(
        getProfileDataState: state.getProfileDataState.loaded(merged),
      ),
    );
  }

  Future<void> _loadUser() async {
    emit(
      state.copyWith(
        getProfileDataState: BaseState<UserEntity>.loading(
          state.getProfileDataState.data,
        ),
      ),
    );
    final response = await _getProfileDataUseCase.call();
    switch (response) {
      case SuccessResponse<UserEntity>():
        emit(
          state.copyWith(
            getProfileDataState: state.getProfileDataState.loaded(
              response.data,
            ),
          ),
        );
      case FailureResponse<UserEntity>():
        emit(
          state.copyWith(
            getProfileDataState: state.getProfileDataState.error(
              response.errorMessage,
            ),
          ),
        );
        _toast(response.errorMessage, isError: true);
    }
  }

  Future<void> _save(UpdateUserDataRequest request) async {
    emit(state.copyWith(editProfileState: state.editProfileState.loading));
    final response = await _editProfileUseCase.call(
      updateUserDataRequest: request,
    );
    switch (response) {
      case SuccessResponse<UserEntity>():
        emit(
          state.copyWith(
            editProfileState: BaseState<UserEntity>.init(),
            getProfileDataState: state.getProfileDataState.loaded(
              response.data,
            ),
          ),
        );
        _toast('Profile updated successfully');
        _uiEvents.add(const PopScreenEvent());
      case FailureResponse<UserEntity>():
        emit(
          state.copyWith(
            editProfileState: state.editProfileState.error(
              response.errorMessage,
            ),
          ),
        );
        _toast(response.errorMessage, isError: true);
    }
  }

  Future<void> _uploadPhoto(File imageFile) async {
    emit(state.copyWith(uploadPhotoState: state.uploadPhotoState.loading));
    final photo = await MultipartFile.fromFile(
      imageFile.path,
      filename: imageFile.path.split(RegExp(r'[\\/]')).last,
    );
    final result = await _uploadProfilePhotoUseCase.call(photo: photo);
    switch (result) {
      case SuccessResponse<String>():
        emit(
          state.copyWith(
            uploadPhotoState: state.uploadPhotoState.loaded(result.data),
            clearLocalImage: true,
          ),
        );
        _toast('Photo uploaded successfully');
        await _loadUser();
      case FailureResponse<String>():
        emit(
          state.copyWith(
            uploadPhotoState: state.uploadPhotoState.error(result.errorMessage),
            clearLocalImage: true,
          ),
        );
        _toast(result.errorMessage, isError: true);
    }
  }

  void _toast(String message, {bool isError = false}) {
    _uiEvents.add(ShowToastUIEvent(message: message, isError: isError));
  }

  @override
  Future<void> close() {
    _uiEvents.close();
    return super.close();
  }
}
