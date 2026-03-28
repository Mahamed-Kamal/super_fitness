import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/features/auth/domain/entities/activity_level.dart';

void main() {
  group("ActivityLevel enum test", () {
    test("should contain exactly 5 values", () {
      expect(ActivityLevel.values.length, 5);
    });

    test("should contain all expected enum values in correct order", () {
      expect(ActivityLevel.values[0], ActivityLevel.level1);
      expect(ActivityLevel.values[1], ActivityLevel.level2);
      expect(ActivityLevel.values[2], ActivityLevel.level3);
      expect(ActivityLevel.values[3], ActivityLevel.level4);
      expect(ActivityLevel.values[4], ActivityLevel.level5);
    });

    test("should return correct names", () {
      expect(ActivityLevel.level1.name, "level1");
      expect(ActivityLevel.level2.name, "level2");
      expect(ActivityLevel.level3.name, "level3");
      expect(ActivityLevel.level4.name, "level4");
      expect(ActivityLevel.level5.name, "level5");
    });

    test("should access enum using index correctly", () {
      final level = ActivityLevel.values[2];
      expect(level, ActivityLevel.level3);
    });

    test("toString should return correct value", () {
      expect(ActivityLevel.level1.toString(), "ActivityLevel.level1");
      expect(ActivityLevel.level5.toString(), "ActivityLevel.level5");
    });
  });
}
