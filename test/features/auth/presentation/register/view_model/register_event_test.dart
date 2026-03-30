import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_event.dart';

void main() {
  group('NavigateFromRegisterToLoginEvent', () {
    test('props is empty', () {
      expect(NavigateFromRegisterToLoginEvent().props, isEmpty);
    });

    test('two instances are equal', () {
      expect(
        NavigateFromRegisterToLoginEvent(),
        equals(NavigateFromRegisterToLoginEvent()),
      );
    });

    test('is a RegisterEvent', () {
      expect(NavigateFromRegisterToLoginEvent(), isA<RegisterEvent>());
    });
  });

  group('UserRegisterSuccessfulEvent', () {
    test('stores message correctly', () {
      final event = UserRegisterSuccessfulEvent(message: 'Welcome!');
      expect(event.message, 'Welcome!');
    });

    test('props contains message', () {
      final event = UserRegisterSuccessfulEvent(message: 'Welcome!');
      expect(event.props, ['Welcome!']);
    });

    test('two instances with same message are equal', () {
      expect(
        UserRegisterSuccessfulEvent(message: 'Welcome!'),
        equals(UserRegisterSuccessfulEvent(message: 'Welcome!')),
      );
    });

    test('two instances with different message are not equal', () {
      expect(
        UserRegisterSuccessfulEvent(message: 'Welcome!'),
        isNot(equals(UserRegisterSuccessfulEvent(message: 'Hello!'))),
      );
    });

    test('is a RegisterEvent', () {
      expect(
        UserRegisterSuccessfulEvent(message: 'Welcome!'),
        isA<RegisterEvent>(),
      );
    });
  });

  group('UserRegisterFailedEvent', () {
    test('stores message correctly', () {
      final event = UserRegisterFailedEvent(message: 'Email already exists');
      expect(event.message, 'Email already exists');
    });

    test('props contains message', () {
      final event = UserRegisterFailedEvent(message: 'Email already exists');
      expect(event.props, ['Email already exists']);
    });

    test('two instances with same message are equal', () {
      expect(
        UserRegisterFailedEvent(message: 'Email already exists'),
        equals(UserRegisterFailedEvent(message: 'Email already exists')),
      );
    });

    test('two instances with different message are not equal', () {
      expect(
        UserRegisterFailedEvent(message: 'Email already exists'),
        isNot(equals(UserRegisterFailedEvent(message: 'Network error'))),
      );
    });

    test('is a RegisterEvent', () {
      expect(
        UserRegisterFailedEvent(message: 'Email already exists'),
        isA<RegisterEvent>(),
      );
    });
  });

  group('RegisterCompletedEvent', () {
    test('props is empty', () {
      expect(RegisterCompletedEvent().props, isEmpty);
    });

    test('two instances are equal', () {
      expect(RegisterCompletedEvent(), equals(RegisterCompletedEvent()));
    });

    test('is a RegisterEvent', () {
      expect(RegisterCompletedEvent(), isA<RegisterEvent>());
    });
  });

  group('UpdateUserDataFailedEvent', () {
    test('stores message correctly', () {
      final event = UpdateUserDataFailedEvent(message: 'Update failed');
      expect(event.message, 'Update failed');
    });

    test('props contains message', () {
      final event = UpdateUserDataFailedEvent(message: 'Update failed');
      expect(event.props, ['Update failed']);
    });

    test('two instances with same message are equal', () {
      expect(
        UpdateUserDataFailedEvent(message: 'Update failed'),
        equals(UpdateUserDataFailedEvent(message: 'Update failed')),
      );
    });

    test('two instances with different message are not equal', () {
      expect(
        UpdateUserDataFailedEvent(message: 'Update failed'),
        isNot(equals(UpdateUserDataFailedEvent(message: 'Server error'))),
      );
    });

    test('is a RegisterEvent', () {
      expect(
        UpdateUserDataFailedEvent(message: 'Update failed'),
        isA<RegisterEvent>(),
      );
    });
  });
}
