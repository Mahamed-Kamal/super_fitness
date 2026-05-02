import 'package:super_fitness/features/auth/domain/entities/activity_level.dart';

/// Backend expects `level1`…`level5` (see [ActivityLevelMapper]).
extension ActivityLevelApiEncoding on ActivityLevel {
  String toApiString() => switch (this) {
    ActivityLevel.rookie => 'level1',
    ActivityLevel.beginner => 'level2',
    ActivityLevel.intermediate => 'level3',
    ActivityLevel.advanced => 'level4',
    ActivityLevel.expert => 'level5',
  };
}

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
