import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/api/api_client.dart';
import 'package:super_fitness/core/api/models/user/user_dto.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/data/data_source/auth_data_source_impl.dart';
import 'package:super_fitness/features/auth/data/models/request/forgot_password_request.dart';
import 'package:super_fitness/features/auth/data/models/request/reset_password_request.dart';
import 'package:super_fitness/features/auth/data/models/request/verify_reset_code_request.dart';
import 'package:super_fitness/features/auth/data/models/response/forgot_password_response.dart';
import 'package:super_fitness/features/auth/data/models/response/reset_password_response.dart';
import 'package:super_fitness/features/auth/data/models/response/verify_reset_code_response.dart';
import 'package:super_fitness/features/auth/data/models/login/login_response_dto.dart';

import 'auth_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late MockApiClient mockApiClient;
  late ApiClient mockApiClient;
  late AuthDataSourceImpl authDataSourceImpl;
  //ForgotPasswor---------
  late ForgotPasswordRequest forgotPasswordRequest;
  late ForgotPasswordResponse forgotPasswordResponse;
  late VerifyResetCodeResponse verifyResetCodeResponse;
  late VerifyResetCodeRequest verifyResetCodeRequest;
  late ResetPasswordResponse resetPasswordResponse;
  late ResetPasswordRequest resetPasswordRequest;
  //ForgotPasswor---------
  late String errorMessage;
  late DioException dioException;
  const testEmail = 'mohamedkamal@gmail.com';
  const testPassword = 'Mohamed@123';

  setUp(() {
    mockApiClient = MockApiClient();
    authDataSourceImpl = AuthDataSourceImpl(mockApiClient);
    //ForgotPasswor---------
    forgotPasswordRequest = ForgotPasswordRequest(email: "email");
    forgotPasswordResponse = ForgotPasswordResponse();
    verifyResetCodeResponse = VerifyResetCodeResponse(message: 'message');
    verifyResetCodeRequest = VerifyResetCodeRequest(resetCode: "resetCode");
    resetPasswordResponse = ResetPasswordResponse();
    resetPasswordRequest = ResetPasswordRequest(
      email: "email",
      newPassword: "newPassword",
    dioException = DioException(
      requestOptions: RequestOptions(),
      type: DioExceptionType.connectionError,
    );
    //ForgotPasswor---------
    errorMessage = "error";
  });

  group("test forgotPassword ", () {
    test('when call forgotPassword it should return success', () async {
      when(
        mockApiClient.forgotPassword(forgotPassword: forgotPasswordRequest),
      ).thenAnswer((_) async => forgotPasswordResponse);
      final result = await authDataSourceImpl.forgotPassword(
        forgotPassword: forgotPasswordRequest,
      );
      expect(
        result,
        SuccessResponse<ForgotPasswordResponse>(data: forgotPasswordResponse),
  group("Login Function Test Cases", () {
    late LoginResponseDto responseLoginDto;
    setUp(() {
      responseLoginDto = LoginResponseDto(
        user: UserDto(),
        message: "",
        token: "abc123",
      );
      verify(
        mockApiClient.forgotPassword(forgotPassword: forgotPasswordRequest),
      ).called(1);
      verifyNoMoreInteractions(mockApiClient);
    });
    test("when call Login it should return Success", () async {
      // Arrange
    test('when call forgotPassword it should return failure', () async {
      when(
        mockApiClient.forgotPassword(forgotPassword: forgotPasswordRequest),
      ).thenThrow(Exception(errorMessage));
      final result = await authDataSourceImpl.forgotPassword(
        forgotPassword: forgotPasswordRequest,
      );
      expect(
        result as FailureResponse<ForgotPasswordResponse>,
        isA<FailureResponse<ForgotPasswordResponse>>(),
      );
      expect(result.errorMessage, contains(errorMessage));
      verify(
        mockApiClient.forgotPassword(forgotPassword: forgotPasswordRequest),
      ).called(1);
      verifyNoMoreInteractions(mockApiClient);
    });
  });

  group("test verifyOtp ", () {
    test("when call verifyOtp it should return success", () async {
      when(
        mockApiClient.verifyOtp(verifyResetCodeRequest: verifyResetCodeRequest),
      ).thenAnswer((_) async => verifyResetCodeResponse);
      final result = await authDataSourceImpl.verifyOtp(
        verifyResetCodeRequest: verifyResetCodeRequest,
      );
      expect(
        result,
        SuccessResponse<VerifyResetCodeResponse>(data: verifyResetCodeResponse),
      );
      verify(
        mockApiClient.verifyOtp(verifyResetCodeRequest: verifyResetCodeRequest),
      ).called(1);
      verifyNoMoreInteractions(mockApiClient);
    });
    test('when call verifyOtp it should return failure', () async {
      when(
        mockApiClient.login(email: testEmail, password: testPassword),
      ).thenAnswer((_) async => responseLoginDto);
      // Act
      final result = await authDataSourceImpl.login(
        email: testEmail,
        password: testPassword,
        mockApiClient.verifyOtp(verifyResetCodeRequest: verifyResetCodeRequest),
      ).thenThrow(Exception(errorMessage));
      final result = await authDataSourceImpl.verifyOtp(
        verifyResetCodeRequest: verifyResetCodeRequest,
      );
      // Assert & Verify
      expect(
        (result as SuccessResponse<LoginResponseDto>).data.token,
        equals(responseLoginDto.token),
        result as FailureResponse<VerifyResetCodeResponse>,
        isA<FailureResponse<VerifyResetCodeResponse>>(),
      );
      expect(result.errorMessage, contains(errorMessage));
      verify(
        mockApiClient.login(email: testEmail, password: testPassword),
        mockApiClient.verifyOtp(verifyResetCodeRequest: verifyResetCodeRequest),
      ).called(1);
      verifyNoMoreInteractions(mockApiClient);
    });
  });

  group("test verifyOtp ", () {
    test("when call verifyOtp it should return success", () async {
      when(
        mockApiClient.resetPassword(resetPassword: resetPasswordRequest),
      ).thenAnswer((_) async => resetPasswordResponse);
      final result = await authDataSourceImpl.resetPassword(
        resetPassword: resetPasswordRequest,
      );
      expect(
        result,
        SuccessResponse<ResetPasswordResponse>(data: resetPasswordResponse),
      );
      verify(
        mockApiClient.resetPassword(resetPassword: resetPasswordRequest),
      ).called(1);
      verifyNoMoreInteractions(mockApiClient);
    });
    test('when call verifyOtp it should return failure', () async {
      when(
        mockApiClient.resetPassword(resetPassword: resetPasswordRequest),
      ).thenThrow(Exception(errorMessage));
      final result = await authDataSourceImpl.resetPassword(
        resetPassword: resetPasswordRequest,
      );
      expect(
        result as FailureResponse<ResetPasswordResponse>,
        isA<FailureResponse<ResetPasswordResponse>>(),
      );
      expect(result.errorMessage, contains(errorMessage));
      verify(
        mockApiClient.resetPassword(resetPassword: resetPasswordRequest),
      ).called(1);
      verifyNoMoreInteractions(mockApiClient);
    });
    test(
      "when login throws exception it should return ErrorResponse",
      () async {
        // Arrange
        when(
          mockApiClient.login(email: testEmail, password: testPassword),
        ).thenThrow(dioException);
        // Act
        final result = await authDataSourceImpl.login(
          email: testEmail,
          password: testPassword,
        );
        // Assert & Verify
        expect(
          (result as FailureResponse).errorMessage,
          equals('errors.connectionError'),
        );
        verify(
          mockApiClient.login(email: testEmail, password: testPassword),
        ).called(1);
        verifyNoMoreInteractions(mockApiClient);
      },
    );
  });
}
