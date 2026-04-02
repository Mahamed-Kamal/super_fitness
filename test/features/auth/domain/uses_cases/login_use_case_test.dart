import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/api/models/user/user_dto.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/data/models/login/login_response_dto.dart';
import 'package:super_fitness/features/auth/domain/repo/auth_repo.dart';
import 'package:super_fitness/features/auth/domain/uses_cases/login_use_case.dart';

import 'login_use_case_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {
  late MockAuthRepo mockAuthRepo;
  late LoginUseCase loginUseCase;

  const testEmail = 'mohamedkamal@gmail.com';
  const testPassword = 'Mohamed@123';
  const testErrorMessage = 'errors.connectionError';

  setUp(() {
    mockAuthRepo = MockAuthRepo();
    loginUseCase = LoginUseCase(mockAuthRepo);
  });

  group("Login UseCase Test Cases", () {
    late LoginResponseDto loginResponseDto;
    late SuccessResponse<LoginResponseDto> successResponse;
    late FailureResponse<LoginResponseDto> errorResponse;

    setUp(() {
      loginResponseDto = LoginResponseDto(
        message: "mohamed",
        token: "abc123",
        user: UserDto(id: "1"),
      );
      successResponse = SuccessResponse<LoginResponseDto>(data: loginResponseDto);
      errorResponse = FailureResponse<LoginResponseDto>(errorMessage: testErrorMessage);
    });

    test("when call Login it should return Success", () async {
      // Arrange
      provideDummy<Result<LoginResponseDto>>(successResponse);
      when(mockAuthRepo.login(
        email: testEmail,
        password: testPassword,
      )).thenAnswer((_) async => successResponse);

      // Act
      final result = await loginUseCase(
        email: testEmail,
        password: testPassword,
      );

      // Assert & Verify
      expect(
        (result as SuccessResponse<LoginResponseDto>).data.token,
        equals(loginResponseDto.token),
      );
      verify(mockAuthRepo.login(
        email: testEmail,
        password: testPassword,
      )).called(1);
      verifyNoMoreInteractions(mockAuthRepo);
    });

    test("when login fails it should return FailureResponse", () async {
      // Arrange
      provideDummy<Result<LoginResponseDto>>(errorResponse);
      when(mockAuthRepo.login(
        email: testEmail,
        password: testPassword,
      )).thenAnswer((_) async => errorResponse);

      // Act
      final result = await loginUseCase(
        email: testEmail,
        password: testPassword,
      );

      // Assert & Verify
      expect(
        (result as FailureResponse<LoginResponseDto>).errorMessage,
        equals(testErrorMessage),
      );
      verify(mockAuthRepo.login(
        email: testEmail,
        password: testPassword,
      )).called(1);
      verifyNoMoreInteractions(mockAuthRepo);
    });
  });
}