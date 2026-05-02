part of 'edit_profile_view_model.dart';

class EditProfileState with EquatableMixin {
  final BaseState<UserEntity> getProfileDataState;
  final BaseState<UserEntity> editProfileState;
  final BaseState<String> uploadPhotoState;
  final File? localImage;

  const EditProfileState({
    required this.getProfileDataState,
    required this.editProfileState,
    required this.uploadPhotoState,
    this.localImage,
  });

  factory EditProfileState.init() => EditProfileState(
    getProfileDataState: BaseState.init(),
    editProfileState: BaseState.init(),
    uploadPhotoState: BaseState.init(),
  );

  /// In-memory profile used by the form: filled after [getProfileDataState] loads, then patched by
  /// sub-screens (weight / goal / activity) and refreshed after save or photo upload.
  UserEntity get currentUser => getProfileDataState.data ?? UserEntity();

  EditProfileState copyWith({
    BaseState<UserEntity>? getProfileDataState,
    BaseState<UserEntity>? editProfileState,
    BaseState<String>? uploadPhotoState,
    File? localImage,
    bool clearLocalImage = false,
  }) => EditProfileState(
    getProfileDataState: getProfileDataState ?? this.getProfileDataState,
    editProfileState: editProfileState ?? this.editProfileState,
    uploadPhotoState: uploadPhotoState ?? this.uploadPhotoState,
    localImage: clearLocalImage ? null : (localImage ?? this.localImage),
  );

  @override
  List<Object?> get props => [
    getProfileDataState,
    editProfileState,
    uploadPhotoState,
    localImage?.path,
  ];
}
