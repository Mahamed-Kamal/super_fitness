import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/features/auth/domain/entities/register_form_data.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_view_model.dart';

void main() {
  group('factory constructors', () {
    test('RegisterState.init() produces correct defaults', () {
      final state = RegisterState.init();
      expect(state.requestState, RequestState.init);
      expect(state.formData, const RegisterFormData());
      expect(state.currentStep, 0);
      expect(state.hasCompletedForm, isFalse);
      expect(state.data, isNull);
      expect(state.errorMessage, isNull);
    });

    test('RegisterState.loading() with no args uses defaults', () {
      final state = RegisterState.loading();
      expect(state.requestState, RequestState.loading);
      expect(state.formData, const RegisterFormData());
      expect(state.currentStep, 0);
      expect(state.hasCompletedForm, isFalse);
    });

    test('RegisterState.loading() with all args overrides defaults', () {
      final formData = RegisterFormData();
      final state = RegisterState.loading(
        formData: formData,
        currentStep: 2,
        hasCompletedForm: true,
      );
      expect(state.requestState, RequestState.loading);
      expect(state.formData, formData);
      expect(state.currentStep, 2);
      expect(state.hasCompletedForm, isTrue);
    });

    test('RegisterState.loaded(data) stores data', () {
      final state = RegisterState.loaded('token_abc');
      expect(state.requestState, RequestState.loaded);
      expect(state.data, 'token_abc');
    });

    test('RegisterState.error(message) stores message', () {
      final state = RegisterState.error('Email already taken');
      expect(state.requestState, RequestState.error);
      expect(state.errorMessage, 'Email already taken');
    });
  });

  group('default constructor', () {
    test('with only required field uses defaults for the rest', () {
      const state = RegisterState(requestState: RequestState.init);
      expect(state.requestState, RequestState.init);
      expect(state.formData, const RegisterFormData());
      expect(state.currentStep, 0);
      expect(state.hasCompletedForm, isFalse);
      expect(state.data, isNull);
      expect(state.errorMessage, isNull);
    });

    test('with all fields set stores every value correctly', () {
      const state = RegisterState(
        requestState: RequestState.loading,
        errorMessage: 'err',
        data: 'tok',
        formData: RegisterFormData(),
        currentStep: 3,
        hasCompletedForm: true,
      );
      expect(state.requestState, RequestState.loading);
      expect(state.errorMessage, 'err');
      expect(state.data, 'tok');
      expect(state.currentStep, 3);
      expect(state.hasCompletedForm, isTrue);
    });
  });

  group('copyWith', () {
    late RegisterState base;

    setUp(() => base = RegisterState.init());

    test('no args returns equivalent state', () {
      expect(base.copyWith(), equals(base));
    });

    test('updates requestState only', () {
      final copy = base.copyWith(requestState: RequestState.loading);
      expect(copy.requestState, RequestState.loading);
      expect(copy.currentStep, base.currentStep);
      expect(copy.hasCompletedForm, base.hasCompletedForm);
      expect(copy.formData, base.formData);
    });

    test('updates errorMessage only', () {
      final copy = base.copyWith(errorMessage: 'new error');
      expect(copy.errorMessage, 'new error');
      expect(copy.requestState, base.requestState);
    });

    test('updates data only', () {
      final copy = base.copyWith(data: 'some_token');
      expect(copy.data, 'some_token');
      expect(copy.requestState, base.requestState);
    });

    test('updates currentStep only', () {
      final copy = base.copyWith(currentStep: 5);
      expect(copy.currentStep, 5);
      expect(copy.requestState, base.requestState);
    });

    test('updates hasCompletedForm only', () {
      final copy = base.copyWith(hasCompletedForm: true);
      expect(copy.hasCompletedForm, isTrue);
      expect(copy.currentStep, base.currentStep);
    });

    test('updates formData only', () {
      final newForm = RegisterFormData();
      final copy = base.copyWith(formData: newForm);
      expect(copy.formData, newForm);
      expect(copy.requestState, base.requestState);
    });

    test('preserves existing errorMessage when not overridden', () {
      final withError = RegisterState.error('original error');
      final copy = withError.copyWith(currentStep: 1);
      expect(copy.errorMessage, 'original error');
    });

    test('preserves existing data when not overridden', () {
      final withData = RegisterState.loaded('my_token');
      final copy = withData.copyWith(currentStep: 1);
      expect(copy.data, 'my_token');
    });
  });

  group('equality', () {
    test('two init states are equal', () {
      expect(RegisterState.init(), equals(RegisterState.init()));
    });

    test('states with different currentStep are not equal', () {
      expect(
        RegisterState.init().copyWith(currentStep: 0),
        isNot(equals(RegisterState.init().copyWith(currentStep: 1))),
      );
    });

    test('states with different hasCompletedForm are not equal', () {
      expect(
        RegisterState.init().copyWith(hasCompletedForm: false),
        isNot(equals(RegisterState.init().copyWith(hasCompletedForm: true))),
      );
    });

    test('states with different requestState are not equal', () {
      expect(RegisterState.init(), isNot(equals(RegisterState.loading())));
    });

    test('loaded states with same data are equal', () {
      expect(RegisterState.loaded('tok'), equals(RegisterState.loaded('tok')));
    });

    test('error states with same message are equal', () {
      expect(RegisterState.error('e'), equals(RegisterState.error('e')));
    });
  });
}
