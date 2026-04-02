import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/api/models/user/user_dto.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/data/models/login/login_response_dto.dart';
import 'package:super_fitness/features/auth/domain/uses_cases/login_use_case.dart';
import 'package:super_fitness/features/auth/presentation/login/view_model/login_intent.dart';
import 'package:super_fitness/features/auth/presentation/login/view_model/login_view_model.dart';

import 'login_view_model_test.mocks.dart';

@GenerateMocks([LoginUseCase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Mock Method Channel للـ Secure Storage (مهم جداً)
  const MethodChannel secureStorageChannel = MethodChannel(
    'plugins.it_nomads.com/flutter_secure_storage',
  );

  late MockLoginUseCase mockLoginUseCase;
  late LoginViewModel loginViewModel;

  const testEmail = 'mohamedkamal@gmail.com';
  const testPassword = 'Mohamed@123';
  const testErrorMessage = 'errors.connectionError';

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    loginViewModel = LoginViewModel(mockLoginUseCase);

    // Mock كل مكالمات الـ Secure Storage عشان ما يرميش MissingPluginException
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(secureStorageChannel, (
          MethodCall methodCall,
        ) async {
          switch (methodCall.method) {
            case 'write': // setSecuredString
              return null; // أو true
            case 'read':
              return null;
            case 'delete':
              return null;
            case 'deleteAll':
              return null;
            default:
              return null;
          }
        });
  });

  tearDown(() async {
    // إزالة الـ mock بعد كل test
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(secureStorageChannel, null);
    await loginViewModel.close();
  });

  group("Login ViewModel Test Cases", () {
    final loginResponseDto = LoginResponseDto(
      message: "Login successful",
      token: "abc123",
      user: UserDto(id: "1"),
    );

    final successResponse = SuccessResponse<LoginResponseDto>(
      data: loginResponseDto,
    );
    final errorResponse = FailureResponse<LoginResponseDto>(
      errorMessage: testErrorMessage,
    );

    // ─── States Tests ───────────────────────────────────────────────

    blocTest<LoginViewModel, LoginState>(
      "should emit [loading, loaded] when LoginIntent succeeds",
      build: () => loginViewModel,
      setUp: () {
        provideDummy<Result<LoginResponseDto>>(successResponse);
        when(
          mockLoginUseCase.call(email: testEmail, password: testPassword),
        ).thenAnswer((_) async => successResponse);
      },
      act: (vm) =>
          vm.doIntent(LoginIntent(email: testEmail, password: testPassword)),
      expect: () => [
        LoginState(loginState: BaseState<LoginResponseDto>.loading()),
        LoginState(
          loginState: BaseState<LoginResponseDto>.loaded(loginResponseDto),
        ),
      ],
    );

    blocTest<LoginViewModel, LoginState>(
      "should emit [loading, error] when LoginIntent fails",
      build: () => loginViewModel,
      setUp: () {
        provideDummy<Result<LoginResponseDto>>(errorResponse);
        when(
          mockLoginUseCase.call(email: testEmail, password: testPassword),
        ).thenAnswer((_) async => errorResponse);
      },
      act: (vm) =>
          vm.doIntent(LoginIntent(email: testEmail, password: testPassword)),
      expect: () => [
        LoginState(loginState: BaseState<LoginResponseDto>.loading()),
        LoginState(
          loginState: BaseState<LoginResponseDto>.error(testErrorMessage),
        ),
      ],
    );

    // ─── UI Events Tests ────────────────────────────────────────────

    blocTest<LoginViewModel, LoginState>(
      "should emit LoginViewShowToast (success) when login succeeds",
      build: () => loginViewModel,
      setUp: () {
        provideDummy<Result<LoginResponseDto>>(successResponse);
        when(
          mockLoginUseCase.call(email: testEmail, password: testPassword),
        ).thenAnswer((_) async => successResponse);
      },
      act: (vm) {
        expectLater(
          vm.uiEventsStream,
          emits(predicate<LoginViewShowToast>((e) => !e.isError)),
        );
        vm.doIntent(LoginIntent(email: testEmail, password: testPassword));
      },
      expect: () => [
        LoginState(loginState: BaseState<LoginResponseDto>.loading()),
        LoginState(
          loginState: BaseState<LoginResponseDto>.loaded(loginResponseDto),
        ),
      ],
    );

    blocTest<LoginViewModel, LoginState>(
      "should emit LoginViewShowToast (error) when login fails",
      build: () => loginViewModel,
      setUp: () {
        provideDummy<Result<LoginResponseDto>>(errorResponse);
        when(
          mockLoginUseCase.call(email: testEmail, password: testPassword),
        ).thenAnswer((_) async => errorResponse);
      },
      act: (vm) {
        expectLater(
          vm.uiEventsStream,
          emits(
            predicate<LoginViewShowToast>(
              (e) => e.isError && e.message == testErrorMessage,
            ),
          ),
        );
        vm.doIntent(LoginIntent(email: testEmail, password: testPassword));
      },
      expect: () => [
        LoginState(loginState: BaseState<LoginResponseDto>.loading()),
        LoginState(
          loginState: BaseState<LoginResponseDto>.error(testErrorMessage),
        ),
      ],
    );

    // Navigation tests
    blocTest<LoginViewModel, LoginState>(
      "should emit NavigateToRegister when RegisterIntent is called",
      build: () => loginViewModel,
      act: (vm) {
        expectLater(vm.uiEventsStream, emits(isA<NavigateToRegister>()));
        vm.doIntent(RegisterIntent());
      },
      expect: () => [],
    );

    blocTest<LoginViewModel, LoginState>(
      "should emit NavigateToForgetPassword when ForgetPasswordIntent is called",
      build: () => loginViewModel,
      act: (vm) {
        expectLater(vm.uiEventsStream, emits(isA<NavigateToForgetPassword>()));
        vm.doIntent(ForgetPasswordIntent());
      },
      expect: () => [],
    );
  });
}
