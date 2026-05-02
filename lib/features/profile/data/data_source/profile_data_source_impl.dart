import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/api/api_client.dart';
import 'package:super_fitness/core/api/execute_api.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/data/models/requests/update_user_data_request.dart';
import 'package:super_fitness/features/auth/data/models/responses/update_user_data_response_dto.dart';
import 'package:super_fitness/features/profile/data/data_source/profile_data_source.dart';
import 'package:super_fitness/features/profile/data/models/response/profile_response.dart';
import 'package:super_fitness/features/profile/data/models/upload_profile/upload_profile_message_response.dart';

@Injectable(as: ProfileDataSource)
class ProfileDataSourceImpl implements ProfileDataSource {
  final ApiClient _apiClient;

  ProfileDataSourceImpl(this._apiClient);

  @override
  Future<Result<UpdateUserDataResponseDto>> getLoggedUserData() {
    return executeApi(() => _apiClient.getLoggedUserData());
  }

  @override
  Future<Result<ProfileResponse>> getProfileData() {
    return executeApi(() => _apiClient.getUserData());
  Future<Result<UploadProfileMessageResponse>> uploadProfilePhoto({
    required MultipartFile photo,
  }) {
    return executeApi(() => _apiClient.uploadProfilePhoto(photo: photo));
  }

  @override
  Future<Result<UpdateUserDataResponseDto>> editProfile({
    required UpdateUserDataRequest updateUserDataRequest,
  }) {
    return executeApi(
      () =>
          _apiClient.editProfile(updateUserDataRequest: updateUserDataRequest),
    );
  }
}
