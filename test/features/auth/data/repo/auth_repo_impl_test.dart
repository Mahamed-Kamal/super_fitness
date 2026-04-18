import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/api/models/users_dto.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/data/data_source/auth_data_source.dart';
import 'package:super_fitness/features/auth/data/models/login/login_response_dto.dart';
import 'package:super_fitness/features/auth/data/models/request/forgot_password_request.dart';
import 'package:super_fitness/features/auth/data/models/request/reset_password_request.dart';
import 'package:super_fitness/features/auth/data/models/request/verify_reset_code_request.dart';
import 'package:super_fitness/features/auth/data/models/requests/register_request_model.dart';
import 'package:super_fitness/features/auth/data/models/requests/update_user_data_request.dart';
import 'package:super_fitness/features/auth/data/models/response/forgot_password_response.dart';
import 'package:super_fitness/features/auth/data/models/response/reset_password_response.dart';
import 'package:super_fitness/features/auth/data/models/response/verify_reset_code_response.dart';

import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([AuthDataSource])
void main() {
  late MockAuthDataSource mockAuthDataSource;
  const String testEmail = 'test@example.com';
  const String testPassword = 'Password123';

  setUp(() {
    mockAuthDataSource = MockAuthDataSource();
  });

  // 1. Register Test Case
  group('Register Tests', () {
    test('should return success token when register is called', () async {
      final request = RegisterRequestModel(
        firstName: 'Abdelrahman',
        lastName: 'Ayman',
      );
      provideDummy<Result<String>>(
          SuccessResponse<String>(data: 'success_token')
      );

      when(
        mockAuthDataSource.register(any),
      ).thenAnswer((_) async => SuccessResponse<String>(data: 'success_token'));

      final result = await mockAuthDataSource.register(request);

      expect(result is SuccessResponse<String>, true);
      expect((result as SuccessResponse<String>).data, 'success_token');
    });
  });

  // 2. Login Test Case
  group('Login Tests', () {
    test(
      'should return LoginResponseDto when credentials are correct',
      () async {
        final responseDto = LoginResponseDto(token: 'abc_123');
        provideDummy<Result<LoginResponseDto>>(
            SuccessResponse<LoginResponseDto>(data: responseDto)
        );
        when(
          mockAuthDataSource.login(
            email: anyNamed('email'),
            password: anyNamed('password'),
          ),
        ).thenAnswer(
          (_) async => SuccessResponse<LoginResponseDto>(data: responseDto),
        );

        final result = await mockAuthDataSource.login(
          email: testEmail,
          password: testPassword,
        );

        expect(result is SuccessResponse<LoginResponseDto>, true);
        expect(
          (result as SuccessResponse<LoginResponseDto>).data.token,
          'abc_123',
        );
      },
    );
  });

  // 3. Forgot Password Test Case
  group('Forgot Password Tests', () {
    test('should return ForgotPasswordResponse successfully', () async {
      final request = ForgotPasswordRequest(email: testEmail);
      final response = ForgotPasswordResponse();
      provideDummy<Result<ForgotPasswordResponse>>(
          SuccessResponse<ForgotPasswordResponse>(data: response)
      );

      when(
        mockAuthDataSource.forgotPassword(
          forgotPassword: anyNamed('forgotPassword'),
        ),
      ).thenAnswer(
        (_) async => SuccessResponse<ForgotPasswordResponse>(data: response),
      );

      final result = await mockAuthDataSource.forgotPassword(
        forgotPassword: request,
      );

      expect(result is SuccessResponse<ForgotPasswordResponse>, true);
    });
  });

  // 4. Verify OTP Test Case
  group('Verify OTP Tests', () {
    test('should return VerifyResetCodeResponse when code is valid', () async {
      final request = VerifyResetCodeRequest(resetCode: '123456');
      final response = VerifyResetCodeResponse(message: 'verified');
      provideDummy<Result<VerifyResetCodeResponse>>(
          SuccessResponse<VerifyResetCodeResponse>(data: response)
      );
      when(
        mockAuthDataSource.verifyOtp(
          verifyResetCodeRequest: anyNamed('verifyResetCodeRequest'),
        ),
      ).thenAnswer(
        (_) async => SuccessResponse<VerifyResetCodeResponse>(data: response),
      );

      final result = await mockAuthDataSource.verifyOtp(
        verifyResetCodeRequest: request,
      );

      expect(result is SuccessResponse<VerifyResetCodeResponse>, true);
    });
  });

  // 5. Reset Password Test Case
  group('Reset Password Tests', () {
    test('should return ResetPasswordResponse successfully', () async {
      final request = ResetPasswordRequest(
        email: testEmail,
        newPassword: 'NewPassword123',
      );
      final response = ResetPasswordResponse();
      provideDummy<Result<ResetPasswordResponse>>(
          SuccessResponse<ResetPasswordResponse>(data: response)
      );
      when(
        mockAuthDataSource.resetPassword(
          resetPassword: anyNamed('resetPassword'),
        ),
      ).thenAnswer(
        (_) async => SuccessResponse<ResetPasswordResponse>(data: response),
      );

      final result = await mockAuthDataSource.resetPassword(
        resetPassword: request,
      );

      expect(result is SuccessResponse<ResetPasswordResponse>, true);
    });
  });

  // 6. Update User Data Test Case
  group('Update User Data Tests', () {
    test('should return dynamic data when update is successful', () async {
      final request = UpdateUserDataRequest(firstName: 'Updated Name');
      provideDummy<Result<UsersDto>>(
        SuccessResponse<UsersDto>(data: UsersDto(
          firstName: 'Updated Name',
        )),
      );
      when(
        mockAuthDataSource.updateUserData(
          token: anyNamed('token'),
          updateUserDataRequest: anyNamed('updateUserDataRequest'),
        ),
      ).thenAnswer(
            (_) async =>
            SuccessResponse<UsersDto>(data: UsersDto(
              firstName: 'Updated Name',
            )),
      );

      final result = await mockAuthDataSource.updateUserData(
        token: 'valid_token',
        updateUserDataRequest: request,
      );

      expect(result, isA<SuccessResponse<UsersDto>>());
    });
  });
}
