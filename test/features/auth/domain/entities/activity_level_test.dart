import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/features/auth/domain/entities/activity_level.dart';

void main() {
  group("ActivityLevel enum test", () {
    test("should contain exactly 5 values", () {
      expect(ActivityLevel.values.length, 5);
    });

    test("should contain all expected enum values in correct order", () {
      expect(ActivityLevel.values[0], ActivityLevel.rookie);
      expect(ActivityLevel.values[1], ActivityLevel.beginner);
      expect(ActivityLevel.values[2], ActivityLevel.intermediate);
      expect(ActivityLevel.values[3], ActivityLevel.advanced);
      expect(ActivityLevel.values[4], ActivityLevel.expert);
    });

    test("should return correct names", () {
      expect(ActivityLevel.rookie.name, "rookie");
      expect(ActivityLevel.beginner.name, "beginner");
      expect(ActivityLevel.intermediate.name, "intermediate");
      expect(ActivityLevel.advanced.name, "advanced");
      expect(ActivityLevel.expert.name, "expert");
    });

    test("should access enum using index correctly", () {
      final level = ActivityLevel.values[2];
      expect(level, ActivityLevel.intermediate);
    });

    test("toString should return correct value", () {
      expect(ActivityLevel.rookie.toString(), "ActivityLevel.rookie");
      expect(ActivityLevel.expert.toString(), "ActivityLevel.expert");
    });
  });
}
