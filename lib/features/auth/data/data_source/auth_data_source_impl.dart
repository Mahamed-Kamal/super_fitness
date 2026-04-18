import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/api/api_client.dart';
import 'package:super_fitness/core/api/execute_api.dart';
import 'package:super_fitness/core/api/models/user_dto.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/data/data_source/auth_data_source.dart';
import 'package:super_fitness/features/auth/data/models/requests/register_request_model.dart';
import 'package:super_fitness/features/auth/data/models/requests/update_user_data_request.dart';

@Injectable(as: AuthDataSource)
class AuthDataSourceImpl implements AuthDataSource {
  final ApiClient _apiClient;

  AuthDataSourceImpl(this._apiClient);
  @override
  Future<Result<LoginResponseDto>> login({
    required String email,
    required String password,
  }) {
    return executeApi(() => _apiClient.login(email: email, password: password));
  }

  @override
  Future<Result<ForgotPasswordResponse>> forgotPassword({
    required ForgotPasswordRequest forgotPassword,
  }) => executeApi(() async {
    var response = await _apiClient.forgotPassword(
      forgotPassword: forgotPassword,
    );
    return response;
  });

  @override
  Future<Result<VerifyResetCodeResponse>> verifyOtp({
    required VerifyResetCodeRequest verifyResetCodeRequest,
  }) => executeApi(() async {
    var response = await _apiClient.verifyOtp(
      verifyResetCodeRequest: verifyResetCodeRequest,
    );
    return response;
  });

  @override
  Future<Result<ResetPasswordResponse>> resetPassword({
    required ResetPasswordRequest resetPassword,
  }) => executeApi(() async {
    var response = await _apiClient.resetPassword(resetPassword: resetPassword);
    return response;
  });
  @override
  Future<Result<String>> register(RegisterRequestModel registerRequestModel) =>
      executeApi(() async {
        var result = await _apiClient.register(registerRequestModel);
        return result.token ?? "";
      });

  @override
  Future<Result<UserDto>> updateUserData({
    String token = "",
    required UpdateUserDataRequest updateUserDataRequest,
  }) => executeApi(() async {
    var bearerToken = token.isNotEmpty ? "Bearer $token" : null;
    var result = await _apiClient.updateUserData(
      token: bearerToken,
      updateUserDataRequest: updateUserDataRequest,
    );
    return result.user ?? UserDto();
  });
  @override
  Future<Result<String>> register(RegisterRequestModel registerRequestModel) =>
      executeApi(() async {
        var result = await _apiClient.register(registerRequestModel);
        return result.token ?? "";
      });

  @override
  Future<Result<UserDto>> updateUserData({
    String token = "",
    required UpdateUserDataRequest updateUserDataRequest,
  }) => executeApi(() async {
    var bearerToken = token.isNotEmpty ? "Bearer $token" : null;
    var result = await _apiClient.updateUserData(
      token: bearerToken,
      updateUserDataRequest: updateUserDataRequest,
    );
    return result.user ?? UserDto();
  });
}
