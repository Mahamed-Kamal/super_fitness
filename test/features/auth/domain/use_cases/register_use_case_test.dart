import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/domain/repo/auth_repo.dart';
import 'package:super_fitness/features/auth/domain/use_cases/register_use_case.dart';

import 'register_use_case_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {
  late MockAuthRepo mockAuthRepo;
  late RegisterUseCase registerUseCase;

  setUpAll(() {
    mockAuthRepo = MockAuthRepo();
    registerUseCase = RegisterUseCase(mockAuthRepo);
  });

  group("Register UseCase test", () {
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

    test("when i call register use case,"
        "it calls repo with correct params and return success token", () async {
      // Arrange
      final successResponse = SuccessResponse<String>(data: token);
      provideDummy<Result<String>>(successResponse);

      when(
        mockAuthRepo.register(
          firstName: anyNamed('firstName'),
          lastName: anyNamed('lastName'),
          email: anyNamed('email'),
          password: anyNamed('password'),
          rePassword: anyNamed('rePassword'),
          gender: anyNamed('gender'),
          height: anyNamed('height'),
          weight: anyNamed('weight'),
          age: anyNamed('age'),
          goal: anyNamed('goal'),
          activityLevel: anyNamed('activityLevel'),
        ),
      ).thenAnswer((_) async => successResponse);

      // Act
      final result =
          await registerUseCase(
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

      // Assert
      expect(result.data, token);

      verify(
        mockAuthRepo.register(
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
        ),
      ).called(1);

      verifyNoMoreInteractions(mockAuthRepo);
    });

    test(
      "when i call register use case, it returns failure and verify repo call",
      () async {
        // Arrange
        const errorMessage = "error";

        when(
          mockAuthRepo.register(
            firstName: anyNamed('firstName'),
            lastName: anyNamed('lastName'),
            email: anyNamed('email'),
            password: anyNamed('password'),
            rePassword: anyNamed('rePassword'),
            gender: anyNamed('gender'),
            height: anyNamed('height'),
            weight: anyNamed('weight'),
            age: anyNamed('age'),
            goal: anyNamed('goal'),
            activityLevel: anyNamed('activityLevel'),
          ),
        ).thenAnswer(
          (_) async => FailureResponse<String>(errorMessage: errorMessage),
        );

        // Act
        final result =
            await registerUseCase(
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

        // Assert
        expect(result.errorMessage, errorMessage);

        verify(
          mockAuthRepo.register(
            firstName: anyNamed('firstName'),
            lastName: anyNamed('lastName'),
            email: anyNamed('email'),
            password: anyNamed('password'),
            rePassword: anyNamed('rePassword'),
            gender: anyNamed('gender'),
            height: anyNamed('height'),
            weight: anyNamed('weight'),
            age: anyNamed('age'),
            goal: anyNamed('goal'),
            activityLevel: anyNamed('activityLevel'),
          ),
        ).called(1);

        verifyNoMoreInteractions(mockAuthRepo);
      },
    );
  });
}
