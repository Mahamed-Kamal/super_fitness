import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/api/models/user/user_dto.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/data/data_source/auth_data_source.dart';
import 'package:super_fitness/features/auth/data/models/request/forgot_password_request.dart';
import 'package:super_fitness/features/auth/data/models/request/reset_password_request.dart';
import 'package:super_fitness/features/auth/data/models/request/verify_reset_code_request.dart';
import 'package:super_fitness/features/auth/data/models/response/forgot_password_response.dart';
import 'package:super_fitness/features/auth/data/models/response/reset_password_response.dart';
import 'package:super_fitness/features/auth/data/models/response/verify_reset_code_response.dart';
import 'package:super_fitness/features/auth/data/models/login/login_response_dto.dart';
import 'package:super_fitness/features/auth/data/repo/auth_repo_impl.dart';

import 'package:super_fitness/features/auth/domain/entity/forget_password_entity.dart';
import 'package:super_fitness/features/auth/domain/entity/reset_password_entity.dart';
import 'package:super_fitness/features/auth/domain/entity/verify_reset_code_entity.dart';
import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([AuthDataSource])
void main() {
  late MockAuthDataSource mockAuthDataSource;
  late AuthRepoImpl authRepoImpl;

  const testEmail = 'mohamedkamal@gmail.com';
  const testPassword = 'Mohamed@123';
  const testErrorMessage = 'errors.connectionError';

  late AuthDataSource authDataSource;
  late AuthRepoImpl authRepo;
  late ForgotPasswordRequest forgotPasswordRequest;
  late ForgotPasswordResponse forgotPasswordResponse;
  late VerifyResetCodeResponse verifyResetCodeResponse;
  late VerifyResetCodeRequest verifyResetCodeRequest;
  late ResetPasswordResponse resetPasswordResponse;
  late ResetPasswordRequest resetPasswordRequest;
  late ResetPasswordEntity resetPasswordEntity;
  late VerifyResetCodeEntity verifyResetCodeEntity;
  late ForgotPasswordEntity forgotPasswordEntity;
  late String errorMessage;
  setUp(() {
    mockAuthDataSource = MockAuthDataSource();
    authRepoImpl = AuthRepoImpl(mockAuthDataSource);
    authDataSource = MockAuthDataSource();
    authRepo = AuthRepoImpl(authDataSource);
    forgotPasswordRequest = ForgotPasswordRequest(email: "email");
    forgotPasswordResponse = ForgotPasswordResponse();
    verifyResetCodeResponse = VerifyResetCodeResponse(message: 'message');
    verifyResetCodeRequest = VerifyResetCodeRequest(resetCode: "resetCode");
    resetPasswordResponse = ResetPasswordResponse();
    resetPasswordRequest = ResetPasswordRequest(
      email: "email",
      newPassword: "newPassword",
    );
    forgotPasswordEntity = ForgotPasswordEntity();
    verifyResetCodeEntity = VerifyResetCodeEntity(message: 'message');
    resetPasswordEntity = ResetPasswordEntity();
    errorMessage = "error";
  });
  setUpAll(() {
    provideDummy<Result<ForgotPasswordResponse>>(
      FailureResponse<ForgotPasswordResponse>(errorMessage: ""),
    );
    provideDummy<Result<VerifyResetCodeResponse>>(
      FailureResponse<VerifyResetCodeResponse>(errorMessage: ""),
    );
    provideDummy<Result<ResetPasswordResponse>>(
      FailureResponse<ResetPasswordResponse>(errorMessage: ""),
    );
  });
  group("test forgotPassword ", () {
    test(
      'when call forgotPassword it should return success with the correct data',
      () async {
        when(
          authDataSource.forgotPassword(forgotPassword: forgotPasswordRequest),
        ).thenAnswer(
          (_) async => SuccessResponse<ForgotPasswordResponse>(
            data: forgotPasswordResponse,
          ),
        );
        final result = await authRepo.forgotPassword(
          email: forgotPasswordRequest.email ?? "",
        );

  group("Login Function Test Cases", () {
    late LoginResponseDto loginResponseDto;
    late SuccessResponse<LoginResponseDto> successResponse;
    late FailureResponse<LoginResponseDto> errorResponse;
        expect(
          result,
          SuccessResponse<ForgotPasswordEntity>(data: forgotPasswordEntity),
        );

    setUp(() {
      loginResponseDto = LoginResponseDto(
        message: "mohamed",
        token: "abc123",
        user: UserDto(id: "1"),
        verify(
          authDataSource.forgotPassword(forgotPassword: forgotPasswordRequest),
        ).called(1);
        verifyNoMoreInteractions(authDataSource);
      },
    );
    test('when call forgotPassword it should return failure', () async {
      when(
        authDataSource.forgotPassword(forgotPassword: forgotPasswordRequest),
      ).thenAnswer(
        (_) async =>
            FailureResponse<ForgotPasswordResponse>(errorMessage: errorMessage),
      );
      successResponse = SuccessResponse<LoginResponseDto>(
        data: loginResponseDto,
      final result = await authRepo.forgotPassword(
        email: forgotPasswordRequest.email ?? "",
      );
      errorResponse = FailureResponse<LoginResponseDto>(
        errorMessage: testErrorMessage,
      expect(
        result as FailureResponse<ForgotPasswordEntity>,
        isA<FailureResponse<ForgotPasswordEntity>>(),
      );
      expect(result.errorMessage, contains(errorMessage));
      verify(
        authDataSource.forgotPassword(forgotPassword: forgotPasswordRequest),
      ).called(1);
      verifyNoMoreInteractions(authDataSource);
    });
    test("when call Login it should return Success", () async {
      // Arrange
      provideDummy<Result<LoginResponseDto>>(successResponse);
  });
  group("test verifyOtp ", () {
    test("when call verifyOtp it should return success", () async {
      when(
        authDataSource.verifyOtp(
          verifyResetCodeRequest: verifyResetCodeRequest,
        ),
      ).thenAnswer(
        (_) async => SuccessResponse<VerifyResetCodeResponse>(
          data: verifyResetCodeResponse,
        ),
      );
      final result = await authRepo.verifyOtp(
        resetCode: verifyResetCodeRequest.resetCode,
      );
      expect(
        result,
        SuccessResponse<VerifyResetCodeEntity>(data: verifyResetCodeEntity),
      );
      verify(
        authDataSource.verifyOtp(
          verifyResetCodeRequest: verifyResetCodeRequest,
        ),
      ).called(1);
      verifyNoMoreInteractions(authDataSource);
    });
    test("when call verifyOtp it should return failure", () async {
      when(
        authDataSource.verifyOtp(
          verifyResetCodeRequest: verifyResetCodeRequest,
        ),
      ).thenAnswer(
        (_) async => FailureResponse<VerifyResetCodeResponse>(
          errorMessage: errorMessage,
        ),
      );
      final result = await authRepo.verifyOtp(
        resetCode: verifyResetCodeRequest.resetCode,
      );
      expect(
        result as FailureResponse<VerifyResetCodeEntity>,
        isA<FailureResponse<VerifyResetCodeEntity>>(),
      );
      expect(result.errorMessage, contains(errorMessage));
      verify(
        authDataSource.verifyOtp(
          verifyResetCodeRequest: verifyResetCodeRequest,
        ),
      ).called(1);
      verifyNoMoreInteractions(authDataSource);
    });
  });
  group("test resetPassword ", () {
    test("when call resetPassword it should return success", () async {
      when(
        mockAuthDataSource.login(email: testEmail, password: testPassword),
      ).thenAnswer((_) async => successResponse);

      // Act
      final result = await authRepoImpl.login(
        email: testEmail,
        password: testPassword,
        authDataSource.resetPassword(resetPassword: resetPasswordRequest),
      ).thenAnswer(
        (_) async =>
            SuccessResponse<ResetPasswordResponse>(data: resetPasswordResponse),
      );
      final result = await authRepo.resetPassword(
        email: resetPasswordRequest.email ?? "",
        newPassword: resetPasswordRequest.newPassword ?? "",
      );

      // Assert & Verify
      expect(
        result,
        SuccessResponse<ResetPasswordEntity>(data: resetPasswordEntity),
        (result as SuccessResponse<LoginResponseDto>).data.token,
        equals(loginResponseDto.token),
      );
      verify(
        mockAuthDataSource.login(email: testEmail, password: testPassword),
        authDataSource.resetPassword(resetPassword: resetPasswordRequest),
      ).called(1);
      verifyNoMoreInteractions(mockAuthDataSource);
      verifyNoMoreInteractions(authDataSource);
    });

    test("when call resetPassword it should return failure", () async {
    test("when login fails it should return FailureResponse", () async {
      // Arrange
      provideDummy<Result<LoginResponseDto>>(errorResponse);
      when(
        authDataSource.resetPassword(resetPassword: resetPasswordRequest),
      ).thenAnswer(
        (_) async =>
            FailureResponse<ResetPasswordResponse>(errorMessage: errorMessage),
      );
      final result = await authRepo.resetPassword(
        email: resetPasswordRequest.email ?? "",
        newPassword: resetPasswordRequest.newPassword ?? "",
        mockAuthDataSource.login(email: testEmail, password: testPassword),
      ).thenAnswer((_) async => errorResponse);

      // Act
      final result = await authRepoImpl.login(
        email: testEmail,
        password: testPassword,
      );

      // Assert & Verify
      expect(
        result as FailureResponse<ResetPasswordEntity>,
        isA<FailureResponse<ResetPasswordEntity>>(),
        (result as FailureResponse<LoginResponseDto>).errorMessage,
        equals(testErrorMessage),
      );
      expect(result.errorMessage, contains(errorMessage));
      verify(
        authDataSource.resetPassword(resetPassword: resetPasswordRequest),
        mockAuthDataSource.login(email: testEmail, password: testPassword),
      ).called(1);
      verifyNoMoreInteractions(authDataSource);
      verifyNoMoreInteractions(mockAuthDataSource);
    });
  });
}
