import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/api/models/user_dto.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/data/data_source/auth_data_source.dart';
import 'package:super_fitness/features/auth/data/models/requests/register_request_model.dart';
import 'package:super_fitness/features/auth/data/models/requests/update_user_data_request.dart';
import 'package:super_fitness/features/auth/data/repo/auth_repo_impl.dart';
import 'package:super_fitness/features/auth/domain/entities/activity_level.dart';
import 'package:super_fitness/features/auth/domain/entities/user_entity.dart';
import 'package:super_fitness/features/auth/domain/entities/user_gender.dart';
import 'package:super_fitness/features/auth/domain/entities/user_goal.dart';
import 'package:super_fitness/features/auth/domain/repo/auth_repo.dart';

import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([AuthDataSource])
void main() {
  late MockAuthDataSource mockAuthDataSource;
  late AuthRepo authRepo;

  setUpAll(() {
    mockAuthDataSource = MockAuthDataSource();
    authRepo = AuthRepoImpl(mockAuthDataSource);
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

        final captured =
            verify(mockAuthDataSource.register(captureAny)).captured.single
                as RegisterRequestModel;

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

    test(
      "when i call register from repo, it's returns failure and verify call",
      () async {
        // Arrange
        const errorMessage = "error";
        when(mockAuthDataSource.register(any)).thenAnswer((_) async {
          return FailureResponse<String>(errorMessage: errorMessage);
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

        // Assert
        expect(result.errorMessage, errorMessage);
        verify(mockAuthDataSource.register(any)).called(1);
        verifyNoMoreInteractions(mockAuthDataSource);
      },
    );
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
