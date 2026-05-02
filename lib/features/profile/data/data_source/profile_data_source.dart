import 'package:dio/dio.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/data/models/requests/update_user_data_request.dart';
import 'package:super_fitness/features/auth/data/models/responses/update_user_data_response_dto.dart';
import 'package:super_fitness/features/profile/data/models/upload_profile/upload_profile_message_response.dart';

abstract interface class ProfileDataSource {
  Future<Result<UpdateUserDataResponseDto>> getLoggedUserData();

  Future<Result<UpdateUserDataResponseDto>> editProfile({
    required UpdateUserDataRequest updateUserDataRequest,
  });

  Future<Result<UploadProfileMessageResponse>> uploadProfilePhoto({
    required MultipartFile photo,
  });
}
