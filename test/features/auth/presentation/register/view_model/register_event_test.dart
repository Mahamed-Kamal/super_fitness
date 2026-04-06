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
}
