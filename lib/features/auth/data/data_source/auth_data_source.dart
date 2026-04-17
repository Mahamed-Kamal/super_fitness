import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/data/models/login/login_response_dto.dart';

abstract interface class AuthDataSource {
  Future<Result<LoginResponseDto>> login({
    required String email,
    required String password,
  });
}
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/data/models/request/forgot_password_request.dart';
import 'package:super_fitness/features/auth/data/models/request/reset_password_request.dart';
import 'package:super_fitness/features/auth/data/models/request/verify_reset_code_request.dart';
import 'package:super_fitness/features/auth/data/models/response/forgot_password_response.dart';
import 'package:super_fitness/features/auth/data/models/response/reset_password_response.dart';
import 'package:super_fitness/features/auth/data/models/response/verify_reset_code_response.dart';

abstract interface class AuthDataSource {
  Future<Result<ForgotPasswordResponse>> forgotPassword({
    required ForgotPasswordRequest forgotPassword,
  });
  Future<Result<VerifyResetCodeResponse>> verifyOtp({
    required VerifyResetCodeRequest verifyResetCodeRequest,
  });
  Future<Result<ResetPasswordResponse>> resetPassword({
    required ResetPasswordRequest resetPassword,
  });
}
