import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/domain/entities/activity_level.dart';
import 'package:super_fitness/features/auth/domain/entities/user_entity.dart';
import 'package:super_fitness/features/auth/domain/entities/user_gender.dart';
import 'package:super_fitness/features/auth/domain/entities/user_goal.dart';
import 'package:super_fitness/features/auth/domain/use_cases/update_user_data_use_case.dart';

import 'register_use_case_test.mocks.dart';

void main() {
  late MockAuthRepo mockAuthRepo;
  late UpdateUserDataUseCase updateUserDataUseCase;

  setUpAll(() {
    mockAuthRepo = MockAuthRepo();
    updateUserDataUseCase = UpdateUserDataUseCase(mockAuthRepo);
  });

  group("Update User Data UseCase test", () {
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
      "when i call update user data use case,"
      "it calls repo with correct params and return success UserEntity",
      () async {
        // Arrange
        final successResponse = SuccessResponse<UserEntity>(data: userEntity);
        provideDummy<Result<UserEntity>>(successResponse);

        when(
          mockAuthRepo.updateUserData(
            token: anyNamed('token'),
            firstName: anyNamed('firstName'),
            lastName: anyNamed('lastName'),
            email: anyNamed('email'),
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
            await updateUserDataUseCase(
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

        // Assert
        expect(result.data, userEntity);

        verify(
          mockAuthRepo.updateUserData(
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
          ),
        ).called(1);

        verifyNoMoreInteractions(mockAuthRepo);
      },
    );

    test(
      "when i call update user data use case, it returns failure and verify repo call",
      () async {
        // Arrange
        const errorMessage = "error";

        when(
          mockAuthRepo.updateUserData(
            token: anyNamed('token'),
            firstName: anyNamed('firstName'),
            lastName: anyNamed('lastName'),
            email: anyNamed('email'),
            gender: anyNamed('gender'),
            height: anyNamed('height'),
            weight: anyNamed('weight'),
            age: anyNamed('age'),
            goal: anyNamed('goal'),
            activityLevel: anyNamed('activityLevel'),
          ),
        ).thenAnswer(
          (_) async => FailureResponse<UserEntity>(errorMessage: errorMessage),
        );

        // Act
        final result =
            await updateUserDataUseCase(
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
          mockAuthRepo.updateUserData(
            token: anyNamed('token'),
            firstName: anyNamed('firstName'),
            lastName: anyNamed('lastName'),
            email: anyNamed('email'),
            gender: anyNamed('gender'),
            height: anyNamed('height'),
            weight: anyNamed('weight'),
            age: anyNamed('age'),
            goal: anyNamed('goal'),
            activityLevel: activityLevel,
          ),
        ).called(1);

        verifyNoMoreInteractions(mockAuthRepo);
      },
    );
  });
}
