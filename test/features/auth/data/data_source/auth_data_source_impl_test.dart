import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/api/api_client.dart';
import 'package:super_fitness/core/api/models/user/user_dto.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/data/data_source/auth_data_source.dart';
import 'package:super_fitness/features/auth/data/data_source/auth_data_source_impl.dart';
import 'package:super_fitness/features/auth/data/models/request/forgot_password_request.dart';
import 'package:super_fitness/features/auth/data/models/request/reset_password_request.dart';
import 'package:super_fitness/features/auth/data/models/request/verify_reset_code_request.dart';
import 'package:super_fitness/features/auth/data/models/response/forgot_password_response.dart';
import 'package:super_fitness/features/auth/data/models/response/reset_password_response.dart';
import 'package:super_fitness/features/auth/data/models/response/verify_reset_code_response.dart';
import 'package:super_fitness/features/auth/data/models/login/login_response_dto.dart';
import 'package:super_fitness/features/auth/data/models/requests/register_request_model.dart';
import 'package:super_fitness/features/auth/data/models/requests/update_user_data_request.dart';
import 'package:super_fitness/features/auth/data/models/responses/register_response_dto.dart';
import 'package:super_fitness/core/api/models/user_dto.dart';
import 'package:super_fitness/features/auth/data/models/responses/update_user_data_response_dto.dart';

import 'auth_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late MockApiClient mockApiClient;
  late AuthDataSourceImpl authDataSourceImpl;

  // Forgot Password
  late ForgotPasswordRequest forgotPasswordRequest;
  late ForgotPasswordResponse forgotPasswordResponse;
  late VerifyResetCodeResponse verifyResetCodeResponse;
  late VerifyResetCodeRequest verifyResetCodeRequest;
  late ResetPasswordResponse resetPasswordResponse;
  late ResetPasswordRequest resetPasswordRequest;

  // Login
  late LoginResponseDto responseLoginDto;
  late DioException dioException;

  late String errorMessage;
  late AuthDataSource authDataSource;

  setUpAll(() {
  const testEmail = 'mohamedkamal@gmail.com';
  const testPassword = 'Mohamed@123';

  setUp(() {
    mockApiClient = MockApiClient();
    authDataSource = AuthDataSourceImpl(mockApiClient);
    authDataSourceImpl = AuthDataSourceImpl(mockApiClient);

    forgotPasswordRequest = ForgotPasswordRequest(email: "email");
    forgotPasswordResponse = ForgotPasswordResponse();
    verifyResetCodeResponse = VerifyResetCodeResponse(message: 'message');
    verifyResetCodeRequest = VerifyResetCodeRequest(resetCode: "resetCode");
    resetPasswordResponse = ResetPasswordResponse();
    resetPasswordRequest = ResetPasswordRequest(
      email: "email",
      newPassword: "newPassword",
    );

    responseLoginDto = LoginResponseDto(
      user: UserDto(),
      message: "",
      token: "abc123",
    );

    dioException = DioException(
      requestOptions: RequestOptions(),
      type: DioExceptionType.connectionError,
    );

    errorMessage = "error";
  });

  group("Register test", () {
    final firstName = "Mohamed";
    final lastName = "Ehab";
    final successMsg = "success";
    final token = "token";
  // ══════════════════════════════════════════════════════════
  //  Login
  // ══════════════════════════════════════════════════════════
  group("Login Function Test Cases", () {
    test("when call Login it should return Success", () async {
      when(
        mockApiClient.login(email: testEmail, password: testPassword),
      ).thenAnswer((_) async => responseLoginDto);

    final registerRequestModel = RegisterRequestModel(
      firstName: firstName,
      lastName: lastName,
    );
      final result = await authDataSourceImpl.login(
        email: testEmail,
        password: testPassword,
      );

    final registerResponse = RegisterResponseDto(
      message: successMsg,
      user: UserDto(firstName: firstName, lastName: lastName),
      token: token,
    );
      expect(
        (result as SuccessResponse<LoginResponseDto>).data.token,
        equals(responseLoginDto.token),
      );
      verify(
        mockApiClient.login(email: testEmail, password: testPassword),
      ).called(1);
      verifyNoMoreInteractions(mockApiClient);
    });

    test(
      "when i call register from data source,"
      "it's calls api client with correct request and return token successfully",
      "when login throws exception it should return ErrorResponse",
      () async {
        // Arrange
        when(mockApiClient.register(any)).thenAnswer((_) async {
          return registerResponse;
        });
        when(
          mockApiClient.login(email: testEmail, password: testPassword),
        ).thenThrow(dioException);

        // Act
        final result =
            await authDataSource.register(registerRequestModel)
                as SuccessResponse<String>;
        final verification = verify(mockApiClient.register(captureAny));
        final captured = verification.captured.single as RegisterRequestModel;
        final result = await authDataSourceImpl.login(
          email: testEmail,
          password: testPassword,
        );

        // Assert
        expect(result.data, token);
        expect(captured.firstName, firstName);
        expect(captured.lastName, lastName);
        verification.called(1);
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

    test(
      "when i call register from data source, it's return empty string if token is null",
      () async {
        // Arrange
        final responseWithNullToken = RegisterResponseDto(
          message: successMsg,
          user: UserDto(firstName: firstName, lastName: lastName),
          token: null,
        );
        when(mockApiClient.register(any)).thenAnswer((_) async {
          return responseWithNullToken;
        });
  // ══════════════════════════════════════════════════════════
  //  Forgot Password
  // ══════════════════════════════════════════════════════════
  group("test forgotPassword", () {
    test('when call forgotPassword it should return success', () async {
      when(
        mockApiClient.forgotPassword(forgotPassword: forgotPasswordRequest),
      ).thenAnswer((_) async => forgotPasswordResponse);

      final result = await authDataSourceImpl.forgotPassword(
        forgotPassword: forgotPasswordRequest,
      );

        // Act
        final result =
            await authDataSource.register(registerRequestModel)
                as SuccessResponse<String>;

        // Assert
        expect(result.data, "");
        verify(mockApiClient.register(any)).called(1);
        verifyNoMoreInteractions(mockApiClient);
      },
    );
      expect(
        result,
        SuccessResponse<ForgotPasswordResponse>(data: forgotPasswordResponse),
      );
      verify(
        mockApiClient.forgotPassword(forgotPassword: forgotPasswordRequest),
      ).called(1);
      verifyNoMoreInteractions(mockApiClient);
    });

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

  // ══════════════════════════════════════════════════════════
  //  Verify OTP
  // ══════════════════════════════════════════════════════════
  group("test verifyOtp", () {
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
        mockApiClient.verifyOtp(verifyResetCodeRequest: verifyResetCodeRequest),
      ).thenThrow(Exception(errorMessage));

      final result = await authDataSourceImpl.verifyOtp(
        verifyResetCodeRequest: verifyResetCodeRequest,
      );

      expect(
        result as FailureResponse<VerifyResetCodeResponse>,
        isA<FailureResponse<VerifyResetCodeResponse>>(),
      );
      expect(result.errorMessage, contains(errorMessage));
      verify(
        mockApiClient.verifyOtp(verifyResetCodeRequest: verifyResetCodeRequest),
      ).called(1);
      verifyNoMoreInteractions(mockApiClient);
    });
  });

  // ══════════════════════════════════════════════════════════
  //  Reset Password
  // ══════════════════════════════════════════════════════════
  group("test resetPassword", () {
    test("when call resetPassword it should return success", () async {
      when(
        mockApiClient.resetPassword(resetPassword: resetPasswordRequest),
      ).thenAnswer((_) async => resetPasswordResponse);

    test("when i call register from data source,"
        "it's return error message if there is an exception", () async {
      // Arrange
      final errorMessage = "errors.unexpected";
      when(mockApiClient.register(any)).thenThrow(Exception());
      final result = await authDataSourceImpl.resetPassword(
        resetPassword: resetPasswordRequest,
      );

      // Act
      final result =
          await authDataSource.register(registerRequestModel)
              as FailureResponse<String>;
      expect(
        result,
        SuccessResponse<ResetPasswordResponse>(data: resetPasswordResponse),
      );
      verify(
        mockApiClient.resetPassword(resetPassword: resetPasswordRequest),
      ).called(1);
      verifyNoMoreInteractions(mockApiClient);
    });

      // Assert
      expect(result.errorMessage, errorMessage);
      verify(mockApiClient.register(any)).called(1);
    test('when call resetPassword it should return failure', () async {
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
  });

  group("Update user data test", () {
    final firstName = "Mohamed";
    final lastName = "Ehab";

    final updateUserDataRequest = UpdateUserDataRequest(
      firstName: firstName,
      lastName: lastName,
    );

    final userDto = UserDto(firstName: firstName, lastName: lastName);
    final updateUserDataResponse = UpdateUserDataResponseDto(user: userDto);
    final token = "Bearer token";

    test(
      "when i call updateUserData from data source,"
      "it's calls api client with correct request and return UserDto successfully",
      () async {
        // Arrange
        when(
          mockApiClient.updateUserData(
            token: anyNamed('token'),
            updateUserDataRequest: anyNamed('updateUserDataRequest'),
          ),
        ).thenAnswer((_) async => updateUserDataResponse);

        // Act
        final result =
            await authDataSource.updateUserData(
                  token: token,
                  updateUserDataRequest: updateUserDataRequest,
                )
                as SuccessResponse<UserDto>;

        final verification = verify(
          mockApiClient.updateUserData(
            token: anyNamed('token'),
            updateUserDataRequest: captureAnyNamed('updateUserDataRequest'),
          ),
        );
        final captured = verification.captured.single as UpdateUserDataRequest;

        // Assert
        expect(result.data.firstName, firstName);
        expect(result.data.lastName, lastName);
        expect(captured.firstName, firstName);
        expect(captured.lastName, lastName);
        verification.called(1);
        verifyNoMoreInteractions(mockApiClient);
      },
    );

    test("when i call updateUserData from data source,"
        "it's return empty UserDto if user in response is null", () async {
      // Arrange
      final responseWithNullUser = UpdateUserDataResponseDto(user: null);

      when(
        mockApiClient.updateUserData(
          token: anyNamed('token'),
          updateUserDataRequest: anyNamed('updateUserDataRequest'),
        ),
      ).thenAnswer((_) async => responseWithNullUser);

      // Act
      final result =
          await authDataSource.updateUserData(
                token: token,
                updateUserDataRequest: updateUserDataRequest,
              )
              as SuccessResponse<UserDto>;

      // Assert
      expect(result.data, UserDto());
      verify(
        mockApiClient.updateUserData(
          token: captureAnyNamed('token'),
          updateUserDataRequest: anyNamed('updateUserDataRequest'),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockApiClient);
    });

    test("when i call updateUserData from data source,"
        "it's return error message if there is an exception", () async {
      // Arrange
      final errorMessage = "errors.unexpected";

      when(
        mockApiClient.updateUserData(
          token: anyNamed('token'),
          updateUserDataRequest: anyNamed('updateUserDataRequest'),
        ),
      ).thenThrow(Exception());

      // Act
      final result =
          await authDataSource.updateUserData(
                token: token,
                updateUserDataRequest: updateUserDataRequest,
              )
              as FailureResponse<UserDto>;

      // Assert
      expect(result.errorMessage, errorMessage);
      verify(
        mockApiClient.updateUserData(
          token: captureAnyNamed('token'),
          updateUserDataRequest: anyNamed('updateUserDataRequest'),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockApiClient);
    });
  });
}
