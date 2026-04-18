import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/core/api/models/users_dto.dart';
import 'package:super_fitness/features/auth/data/mappers/user_mapper.dart';
import 'package:super_fitness/features/auth/domain/entities/user_gender.dart';
import 'package:super_fitness/features/auth/domain/entities/activity_level.dart';
import 'package:super_fitness/features/auth/domain/entities/user_goal.dart';

void main() {
  group("UserMapper test", () {
    test(
      "should map UserDto to UserEntity correctly when all fields are valid",
      () {
        // Arrange
        final dto = UsersDto(
          firstName: "Mohamed",
          lastName: "Ehab",
          email: "test@test.com",
          gender: "male",
          age: 25,
          weight: 75,
          height: 180,
          activityLevel: "level3",
          goal: "gainWeight",
          profilePicture: "image.png",
        );

        // Act
        final result = dto.toUserEntity();

        // Assert
        expect(result.firstName, "Mohamed");
        expect(result.lastName, "Ehab");
        expect(result.email, "test@test.com");
        expect(result.gender, UserGender.male);
        expect(result.age, 25);
        expect(result.weight, 75);
        expect(result.height, 180);
        expect(result.activityLevel, ActivityLevel.intermediate);
        expect(result.goal, UserGoal.gainWeight);
        expect(result.profilePicture, "image.png");
      },
    );

    test("should map gender to female when value is not male", () {
      // Arrange
      final dto = UsersDto(gender: "female");

      // Act
      final result = dto.toUserEntity();

      // Assert
      expect(result.gender, UserGender.female);
    });

    test("should return default values when dto fields are null", () {
      // Arrange
      final dto = UsersDto();

      // Act
      final result = dto.toUserEntity();

      // Assert
      expect(result.firstName, "");
      expect(result.lastName, "");
      expect(result.email, "");
      expect(result.gender, UserGender.female);
      expect(result.age, 1);
      expect(result.weight, 1);
      expect(result.height, 1);
      expect(result.activityLevel, ActivityLevel.rookie);
      expect(result.goal, UserGoal.loseWeight);
      expect(result.profilePicture, "");
    });

    test("should map activity level and goal using mappers", () {
      // Arrange
      final dto = UsersDto(activityLevel: "level5", goal: "learnTheBasics");

      // Act
      final result = dto.toUserEntity();

      // Assert
      expect(result.activityLevel, ActivityLevel.expert);
      expect(result.goal, UserGoal.learnTheBasics);
    });
  });
}
