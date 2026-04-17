import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/api/api_client.dart';
import 'package:super_fitness/core/api/execute_api.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/data/data_source/auth_data_source.dart';
import 'package:super_fitness/features/auth/data/models/login/login_response_dto.dart';
import 'package:super_fitness/features/auth/data/models/request/forgot_password_request.dart';
import 'package:super_fitness/features/auth/data/models/request/reset_password_request.dart';
import 'package:super_fitness/features/auth/data/models/request/verify_reset_code_request.dart';
import 'package:super_fitness/features/auth/data/models/response/forgot_password_response.dart';
import 'package:super_fitness/features/auth/data/models/response/reset_password_response.dart';
import 'package:super_fitness/features/auth/data/models/response/verify_reset_code_response.dart';

@Injectable(as: AuthDataSource)
class AuthDataSourceImpl implements AuthDataSource {
  final ApiClient _apiClient;
  const AuthDataSourceImpl(this._apiClient);

  @override
  Future<Result<LoginResponseDto>> login({
    required String email,
    required String password,
  }) {
    return executeApi(() => _apiClient.login(email: email, password: password));
  }
}
class AuthDataSourceImpl implements AuthDataSource {
  final ApiClient _apiClient;

  AuthDataSourceImpl(this._apiClient);

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
}
