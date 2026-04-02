import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/api/models/user/user_dto.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/data/data_source/auth_data_source.dart';
import 'package:super_fitness/features/auth/data/models/login/login_response_dto.dart';
import 'package:super_fitness/features/auth/data/repo/auth_repo_impl.dart';

import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([AuthDataSource])
void main() {
  late MockAuthDataSource mockAuthDataSource;
  late AuthRepoImpl authRepoImpl;

  const testEmail = 'mohamedkamal@gmail.com';
  const testPassword = 'Mohamed@123';
  const testErrorMessage = 'errors.connectionError';

  setUp(() {
    mockAuthDataSource = MockAuthDataSource();
    authRepoImpl = AuthRepoImpl(mockAuthDataSource);
  });

  group("Login Function Test Cases", () {
    late LoginResponseDto loginResponseDto;
    late SuccessResponse<LoginResponseDto> successResponse;
    late FailureResponse<LoginResponseDto> errorResponse;

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
      // Arrange
      provideDummy<Result<LoginResponseDto>>(successResponse);
      when(
        mockAuthDataSource.login(email: testEmail, password: testPassword),
      ).thenAnswer((_) async => successResponse);

      // Act
      final result = await authRepoImpl.login(
        email: testEmail,
        password: testPassword,
      );

      // Assert & Verify
      expect(
        (result as SuccessResponse<LoginResponseDto>).data.token,
        equals(loginResponseDto.token),
      );
      verify(
        mockAuthDataSource.login(email: testEmail, password: testPassword),
      ).called(1);
      verifyNoMoreInteractions(mockAuthDataSource);
    });

    test("when login fails it should return FailureResponse", () async {
      // Arrange
      provideDummy<Result<LoginResponseDto>>(errorResponse);
      when(
        mockAuthDataSource.login(email: testEmail, password: testPassword),
      ).thenAnswer((_) async => errorResponse);

      // Act
      final result = await authRepoImpl.login(
        email: testEmail,
        password: testPassword,
      );

      // Assert & Verify
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
}
