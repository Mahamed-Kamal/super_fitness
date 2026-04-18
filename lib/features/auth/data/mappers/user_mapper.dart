import 'package:super_fitness/core/api/models/users_dto.dart';
import 'package:super_fitness/features/auth/data/mappers/activity_level_mapper.dart';
import 'package:super_fitness/features/auth/data/mappers/user_goal_mapper.dart';
import 'package:super_fitness/features/auth/domain/entities/user_entity.dart';
import 'package:super_fitness/features/auth/domain/entities/user_gender.dart';

extension UserMapper on UsersDto {
  UserEntity toUserEntity() => UserEntity(
    firstName: firstName ?? "",
    lastName: lastName ?? "",
    email: email ?? "",
    gender: gender == "male" ? UserGender.male : UserGender.female,
    age: age ?? 1,
    weight: weight ?? 1,
    height: height ?? 1,
    activityLevel: activityLevel.toActivityLevel(),
    goal: goal.toUserGoal(),
    profilePicture: profilePicture ?? "",
  );
}
