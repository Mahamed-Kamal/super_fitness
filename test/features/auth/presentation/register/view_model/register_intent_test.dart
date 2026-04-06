import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/features/auth/domain/entities/activity_level.dart';
import 'package:super_fitness/features/auth/domain/entities/user_gender.dart';
import 'package:super_fitness/features/auth/domain/entities/user_goal.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_intent.dart';

void main() {
  group('RegisterButtonClickedIntent', () {
    test('stores all fields correctly', () {
      final intent = RegisterButtonClickedIntent(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        password: 'pass123',
      );

      expect(intent.firstName, 'John');
      expect(intent.lastName, 'Doe');
      expect(intent.email, 'john@example.com');
      expect(intent.password, 'pass123');
    });

    test('props contains all four fields', () {
      final intent = RegisterButtonClickedIntent(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        password: 'pass123',
      );

      expect(intent.props, ['John', 'Doe', 'john@example.com', 'pass123']);
    });

    test('two instances with same values are equal', () {
      final a = RegisterButtonClickedIntent(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        password: 'pass123',
      );
      final b = RegisterButtonClickedIntent(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        password: 'pass123',
      );

      expect(a, equals(b));
    });

    test('two instances with different values are not equal', () {
      final a = RegisterButtonClickedIntent(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        password: 'pass123',
      );
      final b = RegisterButtonClickedIntent(
        firstName: 'Jane',
        lastName: 'Doe',
        email: 'jane@example.com',
        password: 'pass456',
      );

      expect(a, isNot(equals(b)));
    });

    test('is a RegisterIntent', () {
      final intent = RegisterButtonClickedIntent(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        password: 'pass123',
      );

      expect(intent, isA<RegisterIntent>());
    });
  });

  group('LoginNavigationButtonClickedIntent', () {
    test('props is empty', () {
      expect(LoginNavigationButtonClickedIntent().props, isEmpty);
    });

    test('two instances are equal', () {
      expect(
        LoginNavigationButtonClickedIntent(),
        equals(LoginNavigationButtonClickedIntent()),
      );
    });

    test('is a RegisterIntent', () {
      expect(LoginNavigationButtonClickedIntent(), isA<RegisterIntent>());
    });
  });

  group('SwitchViewToSelectWeight', () {
    test('stores userGender correctly', () {
      final intent = SwitchViewToSelectWeight(userGender: UserGender.male);
      expect(intent.userGender, UserGender.male);
    });

    test('props contains userGender', () {
      final intent = SwitchViewToSelectWeight(userGender: UserGender.female);
      expect(intent.props, [UserGender.female]);
    });

    test('two instances with same gender are equal', () {
      expect(
        SwitchViewToSelectWeight(userGender: UserGender.male),
        equals(SwitchViewToSelectWeight(userGender: UserGender.male)),
      );
    });

    test('two instances with different gender are not equal', () {
      expect(
        SwitchViewToSelectWeight(userGender: UserGender.male),
        isNot(equals(SwitchViewToSelectWeight(userGender: UserGender.female))),
      );
    });

    test('is a RegisterIntent', () {
      expect(
        SwitchViewToSelectWeight(userGender: UserGender.male),
        isA<RegisterIntent>(),
      );
    });
  });

  group('SwitchViewToSelectHeight', () {
    test('stores weight correctly', () {
      final intent = SwitchViewToSelectHeight(weight: 75);
      expect(intent.weight, 75);
    });

    test('props contains weight', () {
      final intent = SwitchViewToSelectHeight(weight: 75);
      expect(intent.props, [75]);
    });

    test('two instances with same weight are equal', () {
      expect(
        SwitchViewToSelectHeight(weight: 75),
        equals(SwitchViewToSelectHeight(weight: 75)),
      );
    });

    test('two instances with different weight are not equal', () {
      expect(
        SwitchViewToSelectHeight(weight: 75),
        isNot(equals(SwitchViewToSelectHeight(weight: 80))),
      );
    });

    test('is a RegisterIntent', () {
      expect(SwitchViewToSelectHeight(weight: 75), isA<RegisterIntent>());
    });
  });

  group('SwitchViewToSelectGoal', () {
    test('stores height correctly', () {
      final intent = SwitchViewToSelectGoal(height: 180);
      expect(intent.height, 180);
    });

    test('props contains height', () {
      final intent = SwitchViewToSelectGoal(height: 180);
      expect(intent.props, [180]);
    });

    test('two instances with same height are equal', () {
      expect(
        SwitchViewToSelectGoal(height: 180),
        equals(SwitchViewToSelectGoal(height: 180)),
      );
    });

    test('two instances with different height are not equal', () {
      expect(
        SwitchViewToSelectGoal(height: 180),
        isNot(equals(SwitchViewToSelectGoal(height: 175))),
      );
    });

    test('is a RegisterIntent', () {
      expect(SwitchViewToSelectGoal(height: 180), isA<RegisterIntent>());
    });
  });

  group('SwitchViewToSelectActivityLevel', () {
    test('stores goal correctly', () {
      final intent = SwitchViewToSelectActivityLevel(goal: UserGoal.loseWeight);
      expect(intent.goal, UserGoal.loseWeight);
    });

    test('props contains goal', () {
      final intent = SwitchViewToSelectActivityLevel(goal: UserGoal.loseWeight);
      expect(intent.props, [UserGoal.loseWeight]);
    });

    test('two instances with same goal are equal', () {
      expect(
        SwitchViewToSelectActivityLevel(goal: UserGoal.loseWeight),
        equals(SwitchViewToSelectActivityLevel(goal: UserGoal.loseWeight)),
      );
    });

    test('two instances with different goal are not equal', () {
      expect(
        SwitchViewToSelectActivityLevel(goal: UserGoal.loseWeight),
        isNot(
          equals(SwitchViewToSelectActivityLevel(goal: UserGoal.gainWeight)),
        ),
      );
    });

    test('is a RegisterIntent', () {
      expect(
        SwitchViewToSelectActivityLevel(goal: UserGoal.loseWeight),
        isA<RegisterIntent>(),
      );
    });
  });

  group('FinishRegisterIntent', () {
    test('stores activityLevel correctly', () {
      final intent = FinishRegisterIntent(activityLevel: ActivityLevel.rookie);
      expect(intent.activityLevel, ActivityLevel.rookie);
    });

    test('props contains activityLevel', () {
      final intent = FinishRegisterIntent(activityLevel: ActivityLevel.rookie);
      expect(intent.props, [ActivityLevel.rookie]);
    });

    test('two instances with same activityLevel are equal', () {
      expect(
        FinishRegisterIntent(activityLevel: ActivityLevel.rookie),
        equals(FinishRegisterIntent(activityLevel: ActivityLevel.rookie)),
      );
    });

    test('two instances with different activityLevel are not equal', () {
      expect(
        FinishRegisterIntent(activityLevel: ActivityLevel.rookie),
        isNot(
          equals(FinishRegisterIntent(activityLevel: ActivityLevel.beginner)),
        ),
      );
    });

    test('is a RegisterIntent', () {
      expect(
        FinishRegisterIntent(activityLevel: ActivityLevel.rookie),
        isA<RegisterIntent>(),
      );
    });
  });

  group('RegisterStepNavBackIntent', () {
    test('props is empty', () {
      expect(RegisterStepNavBackIntent().props, isEmpty);
    });

    test('two instances are equal', () {
      expect(RegisterStepNavBackIntent(), equals(RegisterStepNavBackIntent()));
    });

    test('is a RegisterIntent', () {
      expect(RegisterStepNavBackIntent(), isA<RegisterIntent>());
    });
  });

  group('SwitchViewToSelectAge', () {
    test('two instances with same age are equal', () {
      final intent1 = SwitchViewToSelectAge(age: 25);
      final intent2 = SwitchViewToSelectAge(age: 25);
      expect(intent1, equals(intent2));
    });

    test('two instances with different age are not equal', () {
      final intent1 = SwitchViewToSelectAge(age: 25);
      final intent2 = SwitchViewToSelectAge(age: 30);
      expect(intent1, isNot(equals(intent2)));
    });

    test('props contains age', () {
      final intent = SwitchViewToSelectAge(age: 25);
      expect(intent.props, [25]);
    });

    test('is a RegisterIntent', () {
      final intent = SwitchViewToSelectAge(age: 25);
      expect(intent, isA<RegisterIntent>());
    });
  });
}
