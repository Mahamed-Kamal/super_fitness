import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/data/data_source/auth_data_source.dart';
import 'package:super_fitness/features/auth/data/models/requests/register_request_model.dart';
import 'package:super_fitness/features/auth/data/repo/auth_repo_impl.dart';

import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([AuthDataSource])
void main() {
  late MockAuthDataSource mockAuthDataSource;
  late AuthRepoImpl authRepo;

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
}
