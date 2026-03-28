import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/api/models/user_dto.dart';
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
import 'package:super_fitness/features/auth/data/models/requests/register_request_model.dart';
import 'package:super_fitness/features/auth/data/models/requests/update_user_data_request.dart';
import 'package:super_fitness/features/auth/data/repo/auth_repo_impl.dart';
import 'package:super_fitness/features/auth/domain/entities/activity_level.dart';
import 'package:super_fitness/features/auth/domain/entities/user_entity.dart';
import 'package:super_fitness/features/auth/domain/entities/user_gender.dart';
import 'package:super_fitness/features/auth/domain/entities/user_goal.dart';
import 'package:super_fitness/features/auth/domain/repo/auth_repo.dart';
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
  late AuthRepo authRepo;

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

  setUp(() {
    mockAuthDataSource = MockAuthDataSource();
    authRepo = AuthRepoImpl(mockAuthDataSource);
    authRepoImpl = AuthRepoImpl(mockAuthDataSource);

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

  group("Register test", () {
    final firstName = "Mohamed";
    final lastName = "Ehab";
    final email = "test@test.com";
    final password = "123456";
    final rePassword = "123456";
    final gender = "male";
    final height = 180;
    final weight = 75;
    final age = 25;
    final goal = "fitness";
    final activityLevel = "high";
    final token = "token";
  // ══════════════════════════════════════════════════════════
  //  Login
  // ══════════════════════════════════════════════════════════
  group("Login Function Test Cases", () {
    late LoginResponseDto loginResponseDto;
    late SuccessResponse<LoginResponseDto> successResponse;
    late FailureResponse<LoginResponseDto> errorResponse;

    test(
      "when i call register from repo,"
      "it's calls data source with correct model and return token successfully",
      () async {
        // Arrange
        final successResponse = SuccessResponse<String>(data: token);
        provideDummy<Result<String>>(successResponse);
        when(
          mockAuthDataSource.register(any),
        ).thenAnswer((_) async => successResponse);
    setUp(() {
      loginResponseDto = LoginResponseDto(
        message: "mohamed",
        token: "abc123",
        user: UserDto(id: "1"),
      );
      successResponse = SuccessResponse<LoginResponseDto>(
        data: loginResponseDto,
      );
      errorResponse = FailureResponse<LoginResponseDto>(
        errorMessage: testErrorMessage,
      );
    });

    test("when call Login it should return Success", () async {
      provideDummy<Result<LoginResponseDto>>(successResponse);
      when(
        mockAuthDataSource.login(email: testEmail, password: testPassword),
      ).thenAnswer((_) async => successResponse);

        // Act
        final result =
            await authRepo.register(
                  firstName: firstName,
                  lastName: lastName,
                  email: email,
                  password: password,
                  rePassword: rePassword,
                  gender: gender,
                  height: height,
                  weight: weight,
                  age: age,
                  goal: goal,
                  activityLevel: activityLevel,
                )
                as SuccessResponse<String>;
      final result = await authRepoImpl.login(
        email: testEmail,
        password: testPassword,
      );

        final captured =
            verify(mockAuthDataSource.register(captureAny)).captured.single
                as RegisterRequestModel;
      expect(
        (result as SuccessResponse<LoginResponseDto>).data.token,
        equals(loginResponseDto.token),
      );
      verify(
        mockAuthDataSource.login(email: testEmail, password: testPassword),
      ).called(1);
      verifyNoMoreInteractions(mockAuthDataSource);
    });

        // Assert
        expect(result.data, token);
        expect(captured.firstName, firstName);
        expect(captured.lastName, lastName);
        expect(captured.email, email);
        expect(captured.password, password);
        expect(captured.rePassword, rePassword);
        expect(captured.gender, gender);
        expect(captured.height, height);
        expect(captured.weight, weight);
        expect(captured.age, age);
        expect(captured.goal, goal);
        expect(captured.activityLevel, activityLevel);
      },
    );
    test("when login fails it should return FailureResponse", () async {
      provideDummy<Result<LoginResponseDto>>(errorResponse);
      when(
        mockAuthDataSource.login(email: testEmail, password: testPassword),
      ).thenAnswer((_) async => errorResponse);

      final result = await authRepoImpl.login(
        email: testEmail,
        password: testPassword,
      );

      expect(
        (result as FailureResponse<LoginResponseDto>).errorMessage,
        equals(testErrorMessage),
      );
      verify(
        mockAuthDataSource.login(email: testEmail, password: testPassword),
      ).called(1);
      verifyNoMoreInteractions(mockAuthDataSource);
    });
  });

  // ══════════════════════════════════════════════════════════
  //  Forgot Password
  // ══════════════════════════════════════════════════════════
  group("test forgotPassword", () {
    test(
      "when i call register from repo, it's returns failure and verify call",
      'when call forgotPassword it should return success with the correct data',
      () async {
        // Arrange
        const errorMessage = "error";
        when(mockAuthDataSource.register(any)).thenAnswer((_) async {
          return FailureResponse<String>(errorMessage: errorMessage);
        });
        when(
          mockAuthDataSource.forgotPassword(
            forgotPassword: forgotPasswordRequest,
          ),
        ).thenAnswer(
          (_) async => SuccessResponse<ForgotPasswordResponse>(
            data: forgotPasswordResponse,
          ),
        );

        final result = await authRepoImpl.forgotPassword(
          email: forgotPasswordRequest.email ?? "",
        );

        expect(
          result,
          SuccessResponse<ForgotPasswordEntity>(data: forgotPasswordEntity),
        );
        verify(
          mockAuthDataSource.forgotPassword(
            forgotPassword: forgotPasswordRequest,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockAuthDataSource);
      },
    );

    test('when call forgotPassword it should return failure', () async {
      when(
        mockAuthDataSource.forgotPassword(
          forgotPassword: forgotPasswordRequest,
        ),
      ).thenAnswer(
        (_) async =>
            FailureResponse<ForgotPasswordResponse>(errorMessage: errorMessage),
      );

      final result = await authRepoImpl.forgotPassword(
        email: forgotPasswordRequest.email ?? "",
      );

      expect(
        result as FailureResponse<ForgotPasswordEntity>,
        isA<FailureResponse<ForgotPasswordEntity>>(),
      );
      expect(result.errorMessage, contains(errorMessage));
      verify(
        mockAuthDataSource.forgotPassword(
          forgotPassword: forgotPasswordRequest,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockAuthDataSource);
    });
  });

  // ══════════════════════════════════════════════════════════
  //  Verify OTP
  // ══════════════════════════════════════════════════════════
  group("test verifyOtp", () {
    test("when call verifyOtp it should return success", () async {
      when(
        mockAuthDataSource.verifyOtp(
          verifyResetCodeRequest: verifyResetCodeRequest,
        ),
      ).thenAnswer(
        (_) async => SuccessResponse<VerifyResetCodeResponse>(
          data: verifyResetCodeResponse,
        ),
      );

      final result = await authRepoImpl.verifyOtp(
        resetCode: verifyResetCodeRequest.resetCode,
      );

      expect(
        result,
        SuccessResponse<VerifyResetCodeEntity>(data: verifyResetCodeEntity),
      );
      verify(
        mockAuthDataSource.verifyOtp(
          verifyResetCodeRequest: verifyResetCodeRequest,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockAuthDataSource);
    });

    test("when call verifyOtp it should return failure", () async {
      when(
        mockAuthDataSource.verifyOtp(
          verifyResetCodeRequest: verifyResetCodeRequest,
        ),
      ).thenAnswer(
        (_) async => FailureResponse<VerifyResetCodeResponse>(
          errorMessage: errorMessage,
        ),
      );

      final result = await authRepoImpl.verifyOtp(
        resetCode: verifyResetCodeRequest.resetCode,
      );

      expect(
        result as FailureResponse<VerifyResetCodeEntity>,
        isA<FailureResponse<VerifyResetCodeEntity>>(),
      );
      expect(result.errorMessage, contains(errorMessage));
      verify(
        mockAuthDataSource.verifyOtp(
          verifyResetCodeRequest: verifyResetCodeRequest,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockAuthDataSource);
    });
  });

        // Act
        final result =
            await authRepo.register(
                  firstName: firstName,
                  lastName: lastName,
                  email: email,
                  password: password,
                  rePassword: rePassword,
                  gender: gender,
                  height: height,
                  weight: weight,
                  age: age,
                  goal: goal,
                  activityLevel: activityLevel,
                )
                as FailureResponse<String>;
  // ══════════════════════════════════════════════════════════
  //  Reset Password
  // ══════════════════════════════════════════════════════════
  group("test resetPassword", () {
    test("when call resetPassword it should return success", () async {
      when(
        mockAuthDataSource.resetPassword(resetPassword: resetPasswordRequest),
      ).thenAnswer(
        (_) async =>
            SuccessResponse<ResetPasswordResponse>(data: resetPasswordResponse),
      );

      final result = await authRepoImpl.resetPassword(
        email: resetPasswordRequest.email ?? "",
        newPassword: resetPasswordRequest.newPassword ?? "",
      );

        // Assert
        expect(result.errorMessage, errorMessage);
        verify(mockAuthDataSource.register(any)).called(1);
        verifyNoMoreInteractions(mockAuthDataSource);
      },
    );
      expect(
        result,
        SuccessResponse<ResetPasswordEntity>(data: resetPasswordEntity),
      );
      verify(
        mockAuthDataSource.resetPassword(resetPassword: resetPasswordRequest),
      ).called(1);
      verifyNoMoreInteractions(mockAuthDataSource);
    });

    test("when call resetPassword it should return failure", () async {
      when(
        mockAuthDataSource.resetPassword(resetPassword: resetPasswordRequest),
      ).thenAnswer(
        (_) async =>
            FailureResponse<ResetPasswordResponse>(errorMessage: errorMessage),
      );

      final result = await authRepoImpl.resetPassword(
        email: resetPasswordRequest.email ?? "",
        newPassword: resetPasswordRequest.newPassword ?? "",
      );

      expect(
        result as FailureResponse<ResetPasswordEntity>,
        isA<FailureResponse<ResetPasswordEntity>>(),
      );
      expect(result.errorMessage, contains(errorMessage));
      verify(
        mockAuthDataSource.resetPassword(resetPassword: resetPasswordRequest),
      ).called(1);
      verifyNoMoreInteractions(mockAuthDataSource);
    });
  });

  group("Update user data test", () {
    final token = "token";
    final firstName = "Mohamed";
    final lastName = "Ehab";
    final email = "test@test.com";
    final gender = "male";
    final height = 180;
    final weight = 75;
    final age = 25;
    final goal = "getFitter";
    final activityLevel = "level1";

    final userDto = UserDto(
      firstName: firstName,
      lastName: lastName,
      email: email,
      gender: gender,
      height: height,
      weight: weight,
      age: age,
      goal: goal,
      activityLevel: activityLevel,
    );

    final userEntity = UserEntity(
      firstName: firstName,
      lastName: lastName,
      email: email,
      gender: UserGender.male,
      height: height,
      weight: weight,
      age: age,
      goal: UserGoal.getFitter,
      activityLevel: ActivityLevel.rookie,
    );

    test(
      "when i call updateUserData from repo,"
      "it's calls data source with correct model and return UserEntity successfully",
      () async {
        // Arrange
        final successResponse = SuccessResponse<UserDto>(data: userDto);
        provideDummy<Result<UserDto>>(successResponse);
        when(
          mockAuthDataSource.updateUserData(
            token: anyNamed('token'),
            updateUserDataRequest: anyNamed('updateUserDataRequest'),
          ),
        ).thenAnswer((_) async => successResponse);

        // Act
        final result =
            await authRepo.updateUserData(
                  token: token,
                  firstName: firstName,
                  lastName: lastName,
                  email: email,
                  gender: gender,
                  height: height,
                  weight: weight,
                  age: age,
                  goal: goal,
                  activityLevel: activityLevel,
                )
                as SuccessResponse<UserEntity>;

        final verification = verify(
          mockAuthDataSource.updateUserData(
            token: captureAnyNamed('token'),
            updateUserDataRequest: captureAnyNamed('updateUserDataRequest'),
          ),
        );
        final capturedToken = verification.captured[0] as String;
        final captured = verification.captured[1] as UpdateUserDataRequest;

        // Assert
        expect(result.data.firstName, userEntity.firstName);
        expect(result.data.lastName, userEntity.lastName);
        expect(result.data.email, userEntity.email);
        expect(result.data.gender, userEntity.gender);
        expect(result.data.height, userEntity.height);
        expect(result.data.weight, userEntity.weight);
        expect(result.data.age, userEntity.age);
        expect(result.data.goal, userEntity.goal);
        expect(result.data.activityLevel, userEntity.activityLevel);
        expect(capturedToken, token);
        expect(captured.firstName, firstName);
        expect(captured.lastName, lastName);
        expect(captured.email, email);
        expect(captured.gender, gender);
        expect(captured.height, height);
        expect(captured.weight, weight);
        expect(captured.age, age);
        expect(captured.goal, goal);
        expect(captured.activityLevel, activityLevel);
        verification.called(1);
        verifyNoMoreInteractions(mockAuthDataSource);
      },
    );

    test(
      "when i call updateUserData from repo, it's returns failure and verify call",
      () async {
        // Arrange
        const errorMessage = "error";
        when(
          mockAuthDataSource.updateUserData(
            token: anyNamed('token'),
            updateUserDataRequest: anyNamed('updateUserDataRequest'),
          ),
        ).thenAnswer(
          (_) async => FailureResponse<UserDto>(errorMessage: errorMessage),
        );

        // Act
        final result =
            await authRepo.updateUserData(
                  token: token,
                  firstName: firstName,
                  lastName: lastName,
                  email: email,
                  gender: gender,
                  height: height,
                  weight: weight,
                  age: age,
                  goal: goal,
                  activityLevel: activityLevel,
                )
                as FailureResponse<UserEntity>;

        // Assert
        expect(result.errorMessage, errorMessage);
        verify(
          mockAuthDataSource.updateUserData(
            token: anyNamed('token'),
            updateUserDataRequest: anyNamed('updateUserDataRequest'),
          ),
        ).called(1);
        verifyNoMoreInteractions(mockAuthDataSource);
      },
    );
  });
}
