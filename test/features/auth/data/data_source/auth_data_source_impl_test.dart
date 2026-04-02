import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/api/api_client.dart';
import 'package:super_fitness/core/api/models/user/user_dto.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/data/data_source/auth_data_source_impl.dart';
import 'package:super_fitness/features/auth/data/models/login/login_response_dto.dart';

import 'auth_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late MockApiClient mockApiClient;
  late AuthDataSourceImpl authDataSourceImpl;
  late DioException dioException;
  const testEmail = 'mohamedkamal@gmail.com';
  const testPassword = 'Mohamed@123';

  setUp(() {
    mockApiClient = MockApiClient();
    authDataSourceImpl = AuthDataSourceImpl(mockApiClient);
    dioException = DioException(
      requestOptions: RequestOptions(),
      type: DioExceptionType.connectionError,
    );
  });

  group("Login Function Test Cases", () {
    late LoginResponseDto responseLoginDto;
    setUp(() {
      responseLoginDto = LoginResponseDto(
        user: UserDto(),
        message: "",
        token: "abc123",
      );
    });
    test("when call Login it should return Success", () async {
      // Arrange
      when(mockApiClient.login(email: testEmail, password: testPassword),
      ).thenAnswer((_) async => responseLoginDto);
      // Act
      final result = await authDataSourceImpl.login(email: testEmail, password: testPassword);
      // Assert & Verify
      expect((result as SuccessResponse<LoginResponseDto>).data.token, equals(responseLoginDto.token));
      verify(mockApiClient.login(email: testEmail, password: testPassword),).called(1);
      verifyNoMoreInteractions(mockApiClient);
    });

    test("when login throws exception it should return ErrorResponse",() async {
        // Arrange
        when(mockApiClient.login(email: testEmail, password: testPassword)).thenThrow(dioException);
        // Act
        final result = await authDataSourceImpl.login(email: testEmail,password: testPassword);
        // Assert & Verify
        expect((result as FailureResponse).errorMessage,
            equals('errors.connectionError')
        );
        verify(mockApiClient.login(email: testEmail, password: testPassword)).called(1);
        verifyNoMoreInteractions(mockApiClient);
      },
    );
  });
}
