import 'package:super_fitness/core/api/models/user_dto.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/data/models/requests/register_request_model.dart';
import 'package:super_fitness/features/auth/data/models/request/forgot_password_request.dart';
import 'package:super_fitness/features/auth/data/models/request/reset_password_request.dart';
import 'package:super_fitness/features/auth/data/models/request/verify_reset_code_request.dart';
import 'package:super_fitness/features/auth/data/models/response/forgot_password_response.dart';
import 'package:super_fitness/features/auth/data/models/response/reset_password_response.dart';
import 'package:super_fitness/features/auth/data/models/response/verify_reset_code_response.dart';
import 'package:super_fitness/features/auth/data/models/requests/update_user_data_request.dart';

abstract interface class AuthDataSource {
  Future<Result<String>> register(RegisterRequestModel registerRequestModel);
  Future<Result<LoginResponseDto>> login({
    required String email,
    required String password,
  });
  Future<Result<ForgotPasswordResponse>> forgotPassword({
    required ForgotPasswordRequest forgotPassword,
  });
  Future<Result<VerifyResetCodeResponse>> verifyOtp({
    required VerifyResetCodeRequest verifyResetCodeRequest,
  });
  Future<Result<ResetPasswordResponse>> resetPassword({
    required ResetPasswordRequest resetPassword,
  });
  Future<Result<UserDto>> updateUserData({
    String token = "",
    required UpdateUserDataRequest updateUserDataRequest,
  });
}
