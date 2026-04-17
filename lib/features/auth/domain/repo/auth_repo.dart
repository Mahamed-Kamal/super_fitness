import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/data/models/login/login_response_dto.dart';

abstract interface class AuthRepo {
  Future<Result<LoginResponseDto>> login({
    required String email,
    required String password,
  });
}
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/domain/entity/forget_password_entity.dart';
import 'package:super_fitness/features/auth/domain/entity/reset_password_entity.dart';
import 'package:super_fitness/features/auth/domain/entity/verify_reset_code_entity.dart';

abstract interface class AuthRepo {
  Future<Result<ForgotPasswordEntity>> forgotPassword({required String email});

  Future<Result<VerifyResetCodeEntity>> verifyOtp({required String resetCode});
  Future<Result<ResetPasswordEntity>> resetPassword({
    required String email,
    required String newPassword,
  });
}
