import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/api/api_client.dart';
import 'package:super_fitness/core/api/models/user/user_dto.dart';
import 'package:super_fitness/core/api/models/users_dto.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/data/data_source/auth_data_source_impl.dart';
import 'package:super_fitness/features/auth/data/models/login/login_response_dto.dart';
import 'package:super_fitness/features/auth/data/models/request/forgot_password_request.dart';
import 'package:super_fitness/features/auth/data/models/request/reset_password_request.dart';
import 'package:super_fitness/features/auth/data/models/request/verify_reset_code_request.dart';
import 'package:super_fitness/features/auth/data/models/requests/register_request_model.dart';
import 'package:super_fitness/features/auth/data/models/requests/update_user_data_request.dart';
import 'package:super_fitness/features/auth/data/models/response/forgot_password_response.dart';
import 'package:super_fitness/features/auth/data/models/response/logout_response_dto.dart';
import 'package:super_fitness/features/auth/data/models/response/reset_password_response.dart';
import 'package:super_fitness/features/auth/data/models/response/verify_reset_code_response.dart';
import 'package:super_fitness/features/auth/data/models/responses/register_response_dto.dart';
import 'package:super_fitness/features/auth/data/models/responses/update_user_data_response_dto.dart';

import 'auth_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late MockApiClient mockApiClient;
  late AuthDataSourceImpl authDataSourceImpl;

  const testEmail = 'mohamedkamal@gmail.com';
  const testPassword = 'Mohamed@123';
  const token = "token_123";

  // Data Models
  late ForgotPasswordRequest forgotPasswordRequest;
  late ForgotPasswordResponse forgotPasswordResponse;
  late VerifyResetCodeResponse verifyResetCodeResponse;
  late VerifyResetCodeRequest verifyResetCodeRequest;
  late ResetPasswordResponse resetPasswordResponse;
  late ResetPasswordRequest resetPasswordRequest;
  late LoginResponseDto responseLoginDto;
  late RegisterRequestModel registerRequestModel;
  late RegisterResponseDto registerResponseDto;
  late UpdateUserDataRequest updateUserDataRequest;
  late UpdateUserDataResponseDto updateUserDataResponseDto;
  late DioException dioException;
  late LogoutResponseDto logoutResponseDto;

  setUp(() {
    mockApiClient = MockApiClient();
    authDataSourceImpl = AuthDataSourceImpl(mockApiClient);

    // Initialization
    forgotPasswordRequest = ForgotPasswordRequest(email: testEmail);
    forgotPasswordResponse = ForgotPasswordResponse();
    verifyResetCodeResponse = VerifyResetCodeResponse(message: 'success');
    verifyResetCodeRequest = VerifyResetCodeRequest(resetCode: "123456");
    resetPasswordResponse = ResetPasswordResponse();
    resetPasswordRequest = ResetPasswordRequest(
      email: testEmail,
      newPassword: testPassword,
    );

    responseLoginDto = LoginResponseDto(
      user: UserDto(),
      message: "success",
      token: token,
    );
    registerRequestModel = RegisterRequestModel(
      firstName: "Mohamed",
      lastName: "Ehab",
    );
    registerResponseDto = RegisterResponseDto(
      message: "success",
      token: token,
      user: UsersDto(firstName: "Mohamed"),
    );

    updateUserDataRequest = UpdateUserDataRequest(
      firstName: "Mohamed",
      lastName: "Ehab",
    );
    updateUserDataResponseDto = UpdateUserDataResponseDto(
      user: UsersDto(firstName: "Mohamed", lastName: "Ehab"),
    );

    dioException = DioException(
      requestOptions: RequestOptions(),
      type: DioExceptionType.connectionError,
    );

    logoutResponseDto = LogoutResponseDto(message: "success");
  });

  // 1. LOGIN TESTS
  group("Login Tests", () {
    test("should return SuccessResponse when login is successful", () async {
      when(
        mockApiClient.login(email: testEmail, password: testPassword),
      ).thenAnswer((_) async => responseLoginDto);

      final result = await authDataSourceImpl.login(
        email: testEmail,
        password: testPassword,
      );

      expect(
        (result as SuccessResponse<LoginResponseDto>).data.token,
        equals(token),
      );
      verify(
        mockApiClient.login(email: testEmail, password: testPassword),
      ).called(1);
    });

    test("should return FailureResponse on connection error", () async {
      when(
        mockApiClient.login(email: testEmail, password: testPassword),
      ).thenThrow(dioException);

      final result = await authDataSourceImpl.login(
        email: testEmail,
        password: testPassword,
      );

      expect(
        (result as FailureResponse).errorMessage,
        equals('errors.connectionError'),
      );
    });
  });

  // 2. REGISTER TESTS
  group("Register Tests", () {
    test("should return token successfully when register is called", () async {
      when(
        mockApiClient.register(any),
      ).thenAnswer((_) async => registerResponseDto);

      final result = await authDataSourceImpl.register(registerRequestModel);

      expect((result as SuccessResponse<String>).data, equals(token));
      verify(mockApiClient.register(any)).called(1);
    });

    test("should return empty string if token is null in response", () async {
      final nullTokenResponse = RegisterResponseDto(
        message: "success",
        token: null,
      );
      when(
        mockApiClient.register(any),
      ).thenAnswer((_) async => nullTokenResponse);

      final result = await authDataSourceImpl.register(registerRequestModel);

      expect((result as SuccessResponse<String>).data, "");
    });

    test(
      "should return FailureResponse when register throws exception",
      () async {
        when(
          mockApiClient.register(any),
        ).thenThrow(Exception("Unexpected error"));

        final result = await authDataSourceImpl.register(registerRequestModel);

        expect(result is FailureResponse<String>, true);
      },
    );
  });

  // 3. FORGOT PASSWORD TESTS
  group("Forgot Password Tests", () {
    test('forgotPassword should return SuccessResponse', () async {
      when(
        mockApiClient.forgotPassword(
          forgotPassword: anyNamed('forgotPassword'),
        ),
      ).thenAnswer((_) async => forgotPasswordResponse);

      final result = await authDataSourceImpl.forgotPassword(
        forgotPassword: forgotPasswordRequest,
      );

      expect(result is SuccessResponse<ForgotPasswordResponse>, true);
    });

    test('forgotPassword should return FailureResponse on Exception', () async {
      when(
        mockApiClient.forgotPassword(
          forgotPassword: anyNamed('forgotPassword'),
        ),
      ).thenThrow(Exception("Error"));

      final result = await authDataSourceImpl.forgotPassword(
        forgotPassword: forgotPasswordRequest,
      );

      expect(result is FailureResponse, true);
    });
  });

  // 4. VERIFY OTP TESTS
  group("Verify OTP Tests", () {
    test("verifyOtp should return SuccessResponse", () async {
      when(
        mockApiClient.verifyOtp(
          verifyResetCodeRequest: anyNamed('verifyResetCodeRequest'),
        ),
      ).thenAnswer((_) async => verifyResetCodeResponse);

      final result = await authDataSourceImpl.verifyOtp(
        verifyResetCodeRequest: verifyResetCodeRequest,
      );

      expect(result is SuccessResponse<VerifyResetCodeResponse>, true);
    });
  });

  // 5. RESET PASSWORD TESTS
  group("Reset Password Tests", () {
    test("resetPassword should return SuccessResponse", () async {
      when(
        mockApiClient.resetPassword(resetPassword: anyNamed('resetPassword')),
      ).thenAnswer((_) async => resetPasswordResponse);

      final result = await authDataSourceImpl.resetPassword(
        resetPassword: resetPasswordRequest,
      );

      expect(result is SuccessResponse<ResetPasswordResponse>, true);
    });
  });

  // 6. UPDATE USER DATA TESTS
  group("Update User Data Tests", () {
    test("should return UserDto successfully on update", () async {
      when(
        mockApiClient.updateUserData(
          token: anyNamed('token'),
          updateUserDataRequest: anyNamed('updateUserDataRequest'),
        ),
      ).thenAnswer((_) async => updateUserDataResponseDto);

      final result = await authDataSourceImpl.updateUserData(
        token: "Bearer $token",
        updateUserDataRequest: updateUserDataRequest,
      );

      expect(
        (result as SuccessResponse<UsersDto>).data.firstName,
        equals("Mohamed"),
      );
      verify(
        mockApiClient.updateUserData(
          token: anyNamed('token'),
          updateUserDataRequest: anyNamed('updateUserDataRequest'),
        ),
      ).called(1);
    });

    test(
      "should return UserDto() with default values if response user is null",
      () async {
        final nullUserResponse = UpdateUserDataResponseDto(user: null);
        when(
          mockApiClient.updateUserData(
            token: anyNamed('token'),
            updateUserDataRequest: anyNamed('updateUserDataRequest'),
          ),
        ).thenAnswer((_) async => nullUserResponse);

        final result = await authDataSourceImpl.updateUserData(
          token: "Bearer $token",
          updateUserDataRequest: updateUserDataRequest,
        );

        expect((result as SuccessResponse<UsersDto>).data, isA<UsersDto>());
      },
    );

    test("should return FailureResponse on update exception", () async {
      when(
        mockApiClient.updateUserData(
          token: anyNamed('token'),
          updateUserDataRequest: anyNamed('updateUserDataRequest'),
        ),
      ).thenThrow(Exception());

      final result = await authDataSourceImpl.updateUserData(
        token: "Bearer $token",
        updateUserDataRequest: updateUserDataRequest,
      );

      expect((result as FailureResponse).errorMessage, isA<String>());
    });
  });
  group("Logout Tests", () {
    test("should return SuccessResponse on logout", () async {
      when(mockApiClient.logout()).thenAnswer((_) async => logoutResponseDto);
      final result = await authDataSourceImpl.logout();
      expect(result is SuccessResponse, true);
      expect((result as SuccessResponse).data, isA<LogoutResponseDto>());
      verify(mockApiClient.logout()).called(1);
    });

    test("should return FailureResponse on logout exception", () async {
      when(mockApiClient.logout()).thenThrow(Exception());
      final result = await authDataSourceImpl.logout();
      expect(result is FailureResponse, true);
      expect((result as FailureResponse).errorMessage, isA<String>());
      verify(mockApiClient.logout()).called(1);
    });
  });
}
