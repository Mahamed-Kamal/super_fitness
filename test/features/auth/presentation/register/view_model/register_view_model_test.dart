import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/domain/entities/activity_level.dart';
import 'package:super_fitness/features/auth/domain/entities/register_form_data.dart';
import 'package:super_fitness/features/auth/domain/entities/register_step.dart';
import 'package:super_fitness/features/auth/domain/entities/user_gender.dart';
import 'package:super_fitness/features/auth/domain/entities/user_goal.dart';
import 'package:super_fitness/features/auth/domain/use_cases/register_use_case.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_event.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_intent.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_view_model.dart';
import 'package:super_fitness/core/bloc/base_state.dart';

import 'register_view_model_test.mocks.dart';

@GenerateMocks([RegisterUseCase])
void main() {
  late MockRegisterUseCase mockRegisterUseCase;
  late RegisterViewModel sut;

  setUp(() {
    mockRegisterUseCase = MockRegisterUseCase();
    provideDummy<Result<String>>(SuccessResponse(data: ''));
    provideDummy<Result<String>>(FailureResponse(errorMessage: ''));
    sut = RegisterViewModel(mockRegisterUseCase);
  });

  tearDown(() => sut.close());

  Future<List<T>> collectEvents<T>(
    Stream<T> stream,
    Future<void> Function() action, {
    Duration timeout = const Duration(seconds: 2),
  }) async {
    final events = <T>[];
    final sub = stream.listen(events.add);
    await action();
    await Future<void>.delayed(timeout);
    await sub.cancel();
    return events;
  }

  group('initial state', () {
    test('is RegisterState.init()', () {
      expect(sut.state, RegisterState.init());
    });
  });

  group('LoginNavigationButtonClickedIntent', () {
    blocTest<RegisterViewModel, RegisterState>(
      'emits no state changes',
      build: () => RegisterViewModel(mockRegisterUseCase),
      act: (vm) => vm.doIntent(LoginNavigationButtonClickedIntent()),
      expect: () => [],
    );

    test('emits NavigateFromRegisterToLoginEvent on event stream', () async {
      final events = await collectEvents(
        sut.eventStream,
        () async => sut.doIntent(LoginNavigationButtonClickedIntent()),
      );
      expect(events, [isA<NavigateFromRegisterToLoginEvent>()]);
    });
  });

  group('RegisterButtonClickedIntent — form not completed', () {
    blocTest<RegisterViewModel, RegisterState>(
      'saves form fields and navigates to selectGender step',
      build: () => RegisterViewModel(mockRegisterUseCase),
      act: (vm) => vm.doIntent(
        RegisterButtonClickedIntent(
          firstName: 'John',
          lastName: 'Doe',
          email: 'john@example.com',
          password: 'pass123',
        ),
      ),
      expect: () => [
        isA<RegisterState>()
            .having((s) => s.formData.firstname, 'firstname', 'John')
            .having((s) => s.formData.lastname, 'lastname', 'Doe')
            .having((s) => s.formData.email, 'email', 'john@example.com')
            .having((s) => s.formData.password, 'password', 'pass123')
            .having((s) => s.formData.rePassword, 'rePassword', 'pass123')
            .having((s) => s.currentStep, 'currentStep', 0),
        isA<RegisterState>()
            .having((s) => s.formData.firstname, 'firstname', 'John')
            .having((s) => s.formData.lastname, 'lastname', 'Doe')
            .having((s) => s.formData.email, 'email', 'john@example.com')
            .having((s) => s.formData.password, 'password', 'pass123')
            .having((s) => s.formData.rePassword, 'rePassword', 'pass123')
            .having(
              (s) => s.currentStep,
              'currentStep',
              RegisterStep.selectGender.index,
            ),
      ],
    );
  });

  group('RegisterButtonClickedIntent — form already completed', () {
    const completedForm = RegisterFormData(
      firstname: 'John',
      lastname: 'Doe',
      email: 'john@example.com',
      password: 'pass123',
      rePassword: 'pass123',
      gender: 'male',
      weight: 75,
      height: 180,
      goal: 'loseWeight',
      activityLevel: 'moderate',
    );

    blocTest<RegisterViewModel, RegisterState>(
      'calls register API and emits loading then loaded on success',
      build: () {
        when(
          mockRegisterUseCase.call(
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
        ).thenAnswer((_) async => SuccessResponse(data: 'token_abc'));
        return RegisterViewModel(mockRegisterUseCase)..emit(
          RegisterState.init().copyWith(
            formData: completedForm,
            hasCompletedForm: true,
          ),
        );
      },
      act: (vm) => vm.doIntent(
        RegisterButtonClickedIntent(
          firstName: 'John',
          lastName: 'Doe',
          email: 'john@example.com',
          password: 'pass123',
        ),
      ),
      expect: () => [
        isA<RegisterState>()
            .having((s) => s.requestState, 'loading', RequestState.loading)
            .having((s) => s.hasCompletedForm, 'hasCompletedForm', true),
        isA<RegisterState>()
            .having((s) => s.requestState, 'loaded', RequestState.loaded)
            .having((s) => s.data, 'data', 'token_abc'),
      ],
    );

    blocTest<RegisterViewModel, RegisterState>(
      'calls register API and emits loading then error on failure',
      build: () {
        when(
          mockRegisterUseCase.call(
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
          (_) async => FailureResponse(errorMessage: 'Email already taken'),
        );
        return RegisterViewModel(mockRegisterUseCase)..emit(
          RegisterState.init().copyWith(
            formData: completedForm,
            hasCompletedForm: true,
          ),
        );
      },
      act: (vm) => vm.doIntent(
        RegisterButtonClickedIntent(
          firstName: 'John',
          lastName: 'Doe',
          email: 'john@example.com',
          password: 'pass123',
        ),
      ),
      expect: () => [
        isA<RegisterState>().having(
          (s) => s.requestState,
          'loading',
          RequestState.loading,
        ),
        isA<RegisterState>()
            .having((s) => s.requestState, 'error', RequestState.error)
            .having(
              (s) => s.errorMessage,
              'errorMessage',
              'Email already taken',
            )
            .having(
              (s) => s.currentStep,
              'currentStep',
              RegisterStep.registerForm.index,
            )
            .having((s) => s.hasCompletedForm, 'hasCompletedForm', true),
      ],
    );
  });

  group('SwitchViewToSelectWeight', () {
    blocTest<RegisterViewModel, RegisterState>(
      'saves gender and navigates to selectWeight step',
      build: () => RegisterViewModel(mockRegisterUseCase),
      act: (vm) =>
          vm.doIntent(SwitchViewToSelectWeight(userGender: UserGender.male)),
      expect: () => [
        isA<RegisterState>().having(
          (s) => s.formData.gender,
          'gender',
          UserGender.male.name,
        ),
        isA<RegisterState>()
            .having((s) => s.formData.gender, 'gender', UserGender.male.name)
            .having(
              (s) => s.currentStep,
              'currentStep',
              RegisterStep.selectWeight.index,
            ),
      ],
    );
  });

  group('SwitchViewToSelectHeight', () {
    blocTest<RegisterViewModel, RegisterState>(
      'saves weight and navigates to selectHeight step',
      build: () => RegisterViewModel(mockRegisterUseCase),
      act: (vm) => vm.doIntent(SwitchViewToSelectHeight(weight: 75)),
      expect: () => [
        isA<RegisterState>().having((s) => s.formData.weight, 'weight', 75),
        isA<RegisterState>()
            .having((s) => s.formData.weight, 'weight', 75)
            .having(
              (s) => s.currentStep,
              'currentStep',
              RegisterStep.selectHeight.index,
            ),
      ],
    );
  });

  group('SwitchViewToSelectGoal', () {
    blocTest<RegisterViewModel, RegisterState>(
      'saves height and navigates to selectGoal step',
      build: () => RegisterViewModel(mockRegisterUseCase),
      act: (vm) => vm.doIntent(SwitchViewToSelectGoal(height: 180)),
      expect: () => [
        isA<RegisterState>().having((s) => s.formData.height, 'height', 180),
        isA<RegisterState>()
            .having((s) => s.formData.height, 'height', 180)
            .having(
              (s) => s.currentStep,
              'currentStep',
              RegisterStep.selectGoal.index,
            ),
      ],
    );
  });

  group('SwitchViewToSelectActivityLevel', () {
    blocTest<RegisterViewModel, RegisterState>(
      'saves goal and navigates to selectActivityLevel step',
      build: () => RegisterViewModel(mockRegisterUseCase),
      act: (vm) => vm.doIntent(
        SwitchViewToSelectActivityLevel(goal: UserGoal.loseWeight),
      ),
      expect: () => [
        isA<RegisterState>().having(
          (s) => s.formData.goal,
          'goal',
          UserGoal.loseWeight.name,
        ),
        isA<RegisterState>()
            .having((s) => s.formData.goal, 'goal', UserGoal.loseWeight.name)
            .having(
              (s) => s.currentStep,
              'currentStep',
              RegisterStep.selectActivityLevel.index,
            ),
      ],
    );
  });

  group('FinishRegisterIntent', () {
    blocTest<RegisterViewModel, RegisterState>(
      'saves activityLevel then calls API and emits loading then loaded on success',
      build: () {
        when(
          mockRegisterUseCase.call(
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
        ).thenAnswer((_) async => SuccessResponse(data: 'token_xyz'));
        return RegisterViewModel(mockRegisterUseCase);
      },
      act: (vm) => vm.doIntent(
        FinishRegisterIntent(activityLevel: ActivityLevel.rookie),
      ),
      expect: () => [
        isA<RegisterState>().having(
          (s) => s.formData.activityLevel,
          'activityLevel',
          ActivityLevel.rookie.name,
        ),
        isA<RegisterState>()
            .having(
              (s) => s.formData.activityLevel,
              'activityLevel',
              ActivityLevel.rookie.name,
            )
            .having((s) => s.requestState, 'loading', RequestState.loading)
            .having((s) => s.hasCompletedForm, 'hasCompletedForm', true),
        isA<RegisterState>()
            .having((s) => s.requestState, 'loaded', RequestState.loaded)
            .having((s) => s.data, 'data', 'token_xyz'),
      ],
    );

    blocTest<RegisterViewModel, RegisterState>(
      'saves activityLevel then calls API and emits loading then error on failure',
      build: () {
        when(
          mockRegisterUseCase.call(
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
          (_) async => FailureResponse(errorMessage: 'Server error'),
        );
        return RegisterViewModel(mockRegisterUseCase);
      },
      act: (vm) => vm.doIntent(
        FinishRegisterIntent(activityLevel: ActivityLevel.rookie),
      ),
      expect: () => [
        isA<RegisterState>().having(
          (s) => s.formData.activityLevel,
          'activityLevel',
          ActivityLevel.rookie.name,
        ),
        isA<RegisterState>().having(
          (s) => s.requestState,
          'loading',
          RequestState.loading,
        ),
        isA<RegisterState>()
            .having((s) => s.requestState, 'error', RequestState.error)
            .having((s) => s.errorMessage, 'errorMessage', 'Server error'),
      ],
    );

    test('emits RegisterCompletedEvent on success', () async {
      when(
        mockRegisterUseCase.call(
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
      ).thenAnswer((_) async => SuccessResponse(data: 'token_xyz'));

      final events = await collectEvents(
        sut.eventStream,
        () async => sut.doIntent(
          FinishRegisterIntent(activityLevel: ActivityLevel.rookie),
        ),
      );
      expect(events, [isA<RegisterCompletedEvent>()]);
    });

    test('emits UserRegisterFailedEvent on failure', () async {
      when(
        mockRegisterUseCase.call(
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
      ).thenAnswer((_) async => FailureResponse(errorMessage: 'Server error'));

      final events = await collectEvents(
        sut.eventStream,
        () async => sut.doIntent(
          FinishRegisterIntent(activityLevel: ActivityLevel.rookie),
        ),
      );
      expect(events, [isA<UserRegisterFailedEvent>()]);
    });
  });

  group('RegisterStepNavBackIntent', () {
    blocTest<RegisterViewModel, RegisterState>(
      'decrements currentStep when step > 0',
      build: () =>
          RegisterViewModel(mockRegisterUseCase)
            ..emit(RegisterState.init().copyWith(currentStep: 2)),
      act: (vm) => vm.doIntent(RegisterStepNavBackIntent()),
      expect: () => [
        isA<RegisterState>().having((s) => s.currentStep, 'currentStep', 1),
      ],
    );

    blocTest<RegisterViewModel, RegisterState>(
      'emits no state change when currentStep is 0',
      build: () => RegisterViewModel(mockRegisterUseCase),
      act: (vm) => vm.doIntent(RegisterStepNavBackIntent()),
      expect: () => [],
    );

    test(
      'emits NavigateFromRegisterToLoginEvent when currentStep is 0',
      () async {
        final events = await collectEvents(
          sut.eventStream,
          () async => sut.doIntent(RegisterStepNavBackIntent()),
        );
        expect(events, [isA<NavigateFromRegisterToLoginEvent>()]);
      },
    );
  });
}
