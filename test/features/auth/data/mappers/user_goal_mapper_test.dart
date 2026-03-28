import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/features/auth/domain/entities/user_goal.dart';
import 'package:super_fitness/features/auth/data/mappers/user_goal_mapper.dart';

void main() {
  group("UserGoalMapper test", () {
    test("should map loseWeight correctly", () {
      final result = "loseWeight".toUserGoal();
      expect(result, UserGoal.loseWeight);
    });

    test("should map gainWeight correctly", () {
      final result = "gainWeight".toUserGoal();
      expect(result, UserGoal.gainWeight);
    });

    test("should map getFitter correctly", () {
      final result = "getFitter".toUserGoal();
      expect(result, UserGoal.getFitter);
    });

    test("should map gainMoreFlexible correctly", () {
      final result = "gainMoreFlexible".toUserGoal();
      expect(result, UserGoal.gainMoreFlexible);
    });

    test("should map learnTheBasics correctly", () {
      final result = "learnTheBasics".toUserGoal();
      expect(result, UserGoal.learnTheBasics);
    });

    test("should return loseWeight when string is null", () {
      String? value;
      final result = value.toUserGoal();
      expect(result, UserGoal.loseWeight);
    });

    test("should return loseWeight when string is invalid", () {
      final result = "invalidValue".toUserGoal();
      expect(result, UserGoal.loseWeight);
    });

    test("should return loseWeight when string is empty", () {
      final result = "".toUserGoal();
      expect(result, UserGoal.loseWeight);
    });
  });
}
