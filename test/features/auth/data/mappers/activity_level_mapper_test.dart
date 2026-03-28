import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/features/auth/domain/entities/activity_level.dart';
import 'package:super_fitness/features/auth/data/mappers/activity_level_mapper.dart';

void main() {
  group("ActivityLevelMapper test", () {

    test("should map level1 to rookie", () {
      final result = "level1".toActivityLevel();
      expect(result, ActivityLevel.rookie);
    });

    test("should map level2 to beginner", () {
      final result = "level2".toActivityLevel();
      expect(result, ActivityLevel.beginner);
    });

    test("should map level3 to intermediate", () {
      final result = "level3".toActivityLevel();
      expect(result, ActivityLevel.intermediate);
    });

    test("should map level4 to advanced", () {
      final result = "level4".toActivityLevel();
      expect(result, ActivityLevel.advanced);
    });

    test("should map level5 to expert", () {
      final result = "level5".toActivityLevel();
      expect(result, ActivityLevel.expert);
    });

    test("should return rookie when string is null", () {
      String? value;
      final result = value.toActivityLevel();
      expect(result, ActivityLevel.rookie);
    });

    test("should return rookie when string is invalid", () {
      final result = "unknown".toActivityLevel();
      expect(result, ActivityLevel.rookie);
    });

    test("should return rookie when string is empty", () {
      final result = "".toActivityLevel();
      expect(result, ActivityLevel.rookie);
    });
  });
}