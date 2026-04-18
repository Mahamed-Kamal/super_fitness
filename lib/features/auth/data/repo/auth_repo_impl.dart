import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/api/models/user_dto.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/data/data_source/auth_data_source.dart';
import 'package:super_fitness/features/auth/data/mappers/user_mapper.dart';
import 'package:super_fitness/features/auth/data/models/requests/register_request_model.dart';

import 'package:super_fitness/features/auth/data/models/login/login_response_dto.dart';
import 'package:super_fitness/features/auth/data/models/request/forgot_password_request.dart';
import 'package:super_fitness/features/auth/data/models/request/reset_password_request.dart';
import 'package:super_fitness/features/auth/data/models/request/verify_reset_code_request.dart';
import 'package:super_fitness/features/auth/data/models/response/forgot_password_response.dart';
import 'package:super_fitness/features/auth/data/models/response/reset_password_response.dart';
import 'package:super_fitness/features/auth/data/models/response/verify_reset_code_response.dart';
import 'package:super_fitness/features/auth/domain/entity/forget_password_entity.dart';
import 'package:super_fitness/features/auth/domain/entity/reset_password_entity.dart';
import 'package:super_fitness/features/auth/domain/entity/verify_reset_code_entity.dart';
import 'package:super_fitness/features/auth/data/models/requests/update_user_data_request.dart';
import 'package:super_fitness/features/auth/domain/entities/user_entity.dart';
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
  @override
  Future<Result<LoginResponseDto>> login({
    required String email,
    required String password,
  }) async {
    final response = await _authDataSource.login(
      email: email,
      password: password,
    );
    switch (response) {
      case SuccessResponse<LoginResponseDto>():
        return SuccessResponse(data: response.data);
      case FailureResponse<LoginResponseDto>():
        return FailureResponse(errorMessage: response.errorMessage);
    }
  }

  @override
  Future<Result<ForgotPasswordEntity>> forgotPassword({
    required String email,
  }) async {
    var forgotPassword = ForgotPasswordRequest(email: email);
    var response = await _authDataSource.forgotPassword(
      forgotPassword: forgotPassword,
    );
    switch (response) {
      case SuccessResponse<ForgotPasswordResponse>():
        {
          return SuccessResponse<ForgotPasswordEntity>(
            data: response.data.toEntity(),
          );
        }
      case FailureResponse<ForgotPasswordResponse>():
        {
          return FailureResponse<ForgotPasswordEntity>(
            errorMessage: response.errorMessage,
          );
        }
    }
  }

  @override
  Future<Result<VerifyResetCodeEntity>> verifyOtp({
    required String resetCode,
  }) async {
    var verifyResetCodeRequest = VerifyResetCodeRequest(resetCode: resetCode);
    var response = await _authDataSource.verifyOtp(
      verifyResetCodeRequest: verifyResetCodeRequest,
    );
    switch (response) {
      case SuccessResponse<VerifyResetCodeResponse>():
        {
          return SuccessResponse<VerifyResetCodeEntity>(
            data: response.data.toEntity(),
          );
        }
      case FailureResponse<VerifyResetCodeResponse>():
        {
          return FailureResponse<VerifyResetCodeEntity>(
            errorMessage: response.errorMessage,
          );
        }
    }
  }

  @override
  Future<Result<ResetPasswordEntity>> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    var resetPassword = ResetPasswordRequest(
      email: email,
      newPassword: newPassword,
    );
    var response = await _authDataSource.resetPassword(
      resetPassword: resetPassword,
    );
    switch (response) {
      case SuccessResponse<ResetPasswordResponse>():
        {
          return SuccessResponse<ResetPasswordEntity>(
            data: response.data.toEntity(),
          );
        }
      case FailureResponse<ResetPasswordResponse>():
        {
          return FailureResponse<ResetPasswordEntity>(
            errorMessage: response.errorMessage,
          );
        }
    }
  }

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
