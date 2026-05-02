import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/api/models/users_dto.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/data/mappers/user_mapper.dart';
import 'package:super_fitness/features/auth/data/models/requests/update_user_data_request.dart';
import 'package:super_fitness/features/auth/data/models/responses/update_user_data_response_dto.dart';
import 'package:super_fitness/features/auth/domain/entities/user_entity.dart';
import 'package:super_fitness/features/profile/data/data_source/profile_data_source.dart';
import 'package:super_fitness/features/profile/data/models/upload_profile/upload_profile_message_response.dart';
import 'package:super_fitness/features/profile/domain/repo/profile_repo.dart';

@Injectable(as: ProfileRepo)
class ProfileRepoImpl implements ProfileRepo {
  final ProfileDataSource _profileDataSource;

  ProfileRepoImpl(this._profileDataSource);

  @override
  Future<Result<UserEntity>> getLoggedUserData() async {
    final response = await _profileDataSource.getLoggedUserData();
    switch (response) {
      case SuccessResponse<UpdateUserDataResponseDto>():
        return SuccessResponse<UserEntity>(
          data: (response.data.user ?? const UsersDto()).toUserEntity(),
        );
      case FailureResponse<UpdateUserDataResponseDto>():
        return FailureResponse<UserEntity>(errorMessage: response.errorMessage);
    }
  }

  @override
  Future<Result<String>> uploadProfilePhoto({
    required MultipartFile photo,
  }) async {
    final response = await _profileDataSource.uploadProfilePhoto(photo: photo);
    switch (response) {
      case SuccessResponse<UploadProfileMessageResponse>():
        return SuccessResponse<String>(
          data: response.data.message ?? "success",
        );
      case FailureResponse<UploadProfileMessageResponse>():
        return FailureResponse<String>(errorMessage: response.errorMessage);
    }
  }

  @override
  Future<Result<UserEntity>> editProfile({
    required UpdateUserDataRequest updateUserDataRequest,
  }) async {
    var response = await _profileDataSource.editProfile(
      updateUserDataRequest: updateUserDataRequest,
    );
    switch (response) {
      case SuccessResponse<UpdateUserDataResponseDto>():
        return SuccessResponse<UserEntity>(
          data: response.data.user?.toUserEntity() ?? UserEntity(),
        );
      case FailureResponse<UpdateUserDataResponseDto>():
        return FailureResponse<UserEntity>(errorMessage: response.errorMessage);
    }
  }
}
