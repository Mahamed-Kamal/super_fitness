import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/api/models/user_dto.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/data/data_source/auth_data_source.dart';
import 'package:super_fitness/features/auth/data/mappers/user_mapper.dart';
import 'package:super_fitness/features/auth/data/models/requests/register_request_model.dart';
import 'package:super_fitness/features/auth/data/models/requests/update_user_data_request.dart';
import 'package:super_fitness/features/auth/domain/entities/user_entity.dart';
import 'package:super_fitness/features/auth/domain/repo/auth_repo.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthDataSource _authDataSource;

  AuthRepoImpl(this._authDataSource);

  @override
  Future<Result<String>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String gender,
    required int height,
    required int weight,
    required int age,
    required String goal,
    required String activityLevel,
  }) {
    final registerRequestModel = RegisterRequestModel(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      rePassword: rePassword,
      gender: gender,
      height: height,
      weight: weight,
      age: age,
      goal: goal,
      activityLevel: activityLevel,
    );
    return _authDataSource.register(registerRequestModel);
  }

  @override
  Future<Result<UserEntity>> updateUserData({
    String token = "",
    String? firstName,
    String? lastName,
    String? email,
    String? gender,
    int? height,
    int? weight,
    int? age,
    String? goal,
    String? activityLevel,
  }) async {
    final updateUserDataRequest = UpdateUserDataRequest(
      firstName: firstName,
      lastName: lastName,
      email: email,
      gender: gender,
      height: height,
      weight: weight,
      age: age,
      goal: goal,
      activityLevel: activityLevel,
    );
    final result = await _authDataSource.updateUserData(
      token: token,
      updateUserDataRequest: updateUserDataRequest,
    );
    switch (result) {
      case SuccessResponse<UserDto>():
        return SuccessResponse(data: result.data.toUserEntity());
      case FailureResponse<UserDto>():
        return FailureResponse(errorMessage: result.errorMessage);
    }
  }
}
