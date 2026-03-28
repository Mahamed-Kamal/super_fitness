import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/api/api_client.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/data/data_source/auth_data_source.dart';
import 'package:super_fitness/features/auth/data/data_source/auth_data_source_impl.dart';
import 'package:super_fitness/features/auth/data/models/requests/register_request_model.dart';
import 'package:super_fitness/features/auth/data/models/requests/update_user_data_request.dart';
import 'package:super_fitness/features/auth/data/models/responses/register_response_dto.dart';
import 'package:super_fitness/core/api/models/user_dto.dart';
import 'package:super_fitness/features/auth/data/models/responses/update_user_data_response_dto.dart';

import 'auth_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late MockApiClient mockApiClient;
  late AuthDataSource authDataSource;

  setUpAll(() {
    mockApiClient = MockApiClient();
    authDataSource = AuthDataSourceImpl(mockApiClient);
  });

  group("Register test", () {
    final firstName = "Mohamed";
    final lastName = "Ehab";
    final successMsg = "success";
    final token = "token";

    final registerRequestModel = RegisterRequestModel(
      firstName: firstName,
      lastName: lastName,
    );

    final registerResponse = RegisterResponseDto(
      message: successMsg,
      user: UserDto(firstName: firstName, lastName: lastName),
      token: token,
    );

    test(
      "when i call register from data source,"
      "it's calls api client with correct request and return token successfully",
      () async {
        // Arrange
        when(mockApiClient.register(any)).thenAnswer((_) async {
          return registerResponse;
        });

        // Act
        final result =
            await authDataSource.register(registerRequestModel)
                as SuccessResponse<String>;
        final verification = verify(mockApiClient.register(captureAny));
        final captured = verification.captured.single as RegisterRequestModel;

        // Assert
        expect(result.data, token);
        expect(captured.firstName, firstName);
        expect(captured.lastName, lastName);
        verification.called(1);
        verifyNoMoreInteractions(mockApiClient);
      },
    );

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

    test("when i call register from data source,"
        "it's return error message if there is an exception", () async {
      // Arrange
      final errorMessage = "errors.unexpected";
      when(mockApiClient.register(any)).thenThrow(Exception());

      // Act
      final result =
          await authDataSource.register(registerRequestModel)
              as FailureResponse<String>;

      // Assert
      expect(result.errorMessage, errorMessage);
      verify(mockApiClient.register(any)).called(1);
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
