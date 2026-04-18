import 'package:super_fitness/features/auth/domain/entities/activity_level.dart';

extension ActivityLevelMapper on String? {
  ActivityLevel toActivityLevel() {
    switch (this) {
      case "level1":
        return ActivityLevel.rookie;
      case "level2":
        return ActivityLevel.beginner;
      case "level3":
        return ActivityLevel.intermediate;
      case "level4":
        return ActivityLevel.advanced;
      case "level5":
        return ActivityLevel.expert;
      default:
        return ActivityLevel.rookie;
    }
  }
}
