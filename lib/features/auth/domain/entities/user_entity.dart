import 'package:super_fitness/features/auth/domain/entities/activity_level.dart';
import 'package:super_fitness/features/auth/domain/entities/user_gender.dart';
import 'package:super_fitness/features/auth/domain/entities/user_goal.dart';

class UserEntity {
  final String firstName;
  final String lastName;
  final String email;
  final UserGender gender;
  final int age;
  final int weight;
  final int height;
  final ActivityLevel activityLevel;
  final UserGoal goal;
  final String profilePicture;

  UserEntity({
    this.firstName = "",
    this.lastName = "",
    this.email = "",
    this.gender = UserGender.male,
    this.age = 1,
    this.weight = 1,
    this.height = 1,
    this.activityLevel = ActivityLevel.rookie,
    this.goal = UserGoal.loseWeight,
    this.profilePicture = "",
  });

  UserEntity copyWith({
    String? firstName,
    String? lastName,
    String? email,
    UserGender? gender,
    int? age,
    int? weight,
    int? height,
    ActivityLevel? activityLevel,
    UserGoal? goal,
    String? profilePicture,
  }) {
    return UserEntity(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      activityLevel: activityLevel ?? this.activityLevel,
      goal: goal ?? this.goal,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }
}
