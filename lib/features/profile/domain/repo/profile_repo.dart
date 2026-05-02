import 'package:dio/dio.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/data/models/requests/update_user_data_request.dart';
import 'package:super_fitness/features/auth/domain/entities/user_entity.dart';

abstract interface class ProfileRepo {
  Future<Result<UserEntity>> getLoggedUserData();

  Future<Result<UserEntity>> editProfile({
    required UpdateUserDataRequest updateUserDataRequest,
  });

  Future<Result<String>> uploadProfilePhoto({required MultipartFile photo});
}
