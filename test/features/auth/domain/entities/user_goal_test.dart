import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/features/auth/domain/entities/user_goal.dart';

void main() {
  group("UserGoal enum test", () {
    test("should contain exactly 5 values", () {
      expect(UserGoal.values.length, 5);
    });

    test("should contain all expected enum values in correct order", () {
      expect(UserGoal.values[0], UserGoal.loseWeight);
      expect(UserGoal.values[1], UserGoal.gainWeight);
      expect(UserGoal.values[2], UserGoal.getFitter);
      expect(UserGoal.values[3], UserGoal.gainMoreFlexible);
      expect(UserGoal.values[4], UserGoal.learnTheBasics);
    });

    test("should return correct names", () {
      expect(UserGoal.loseWeight.name, "loseWeight");
      expect(UserGoal.gainWeight.name, "gainWeight");
      expect(UserGoal.getFitter.name, "getFitter");
      expect(UserGoal.gainMoreFlexible.name, "gainMoreFlexible");
      expect(UserGoal.learnTheBasics.name, "learnTheBasics");
    });

    test("should access enum using index correctly", () {
      final goal = UserGoal.values[2];
      expect(goal, UserGoal.getFitter);
    });

    test("toString should return correct value", () {
      expect(UserGoal.loseWeight.toString(), "UserGoal.loseWeight");
      expect(UserGoal.learnTheBasics.toString(), "UserGoal.learnTheBasics");
    });
  });
}
