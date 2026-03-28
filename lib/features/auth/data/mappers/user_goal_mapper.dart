import 'package:super_fitness/features/auth/domain/entities/user_goal.dart';

extension UserGoalMapper on String? {
  UserGoal toUserGoal() {
    switch (this) {
      case "loseWeight":
        return UserGoal.loseWeight;
      case "gainWeight":
        return UserGoal.gainWeight;
      case "getFitter":
        return UserGoal.getFitter;
      case "gainMoreFlexible":
        return UserGoal.gainMoreFlexible;
      case "learnTheBasics":
        return UserGoal.learnTheBasics;
      default:
        return UserGoal.loseWeight;
    }
  }
}
