import 'package:super_fitness/core/api/models/user_dto.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/data/models/requests/register_request_model.dart';
import 'package:super_fitness/features/auth/data/models/requests/update_user_data_request.dart';

abstract interface class AuthDataSource {
  Future<Result<String>> register(RegisterRequestModel registerRequestModel);

  Future<Result<UserDto>> updateUserData({
    String token = "",
    required UpdateUserDataRequest updateUserDataRequest,
  });
}
