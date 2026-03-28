import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/core/api/models/user_dto.dart';

void main() {
  group('UserDto Tests', () {
    const id = "1";
    const createdAt = "2024-01-01";
    const firstName = "Mohamed";
    const lastName = "Ehab";
    const email = "test@test.com";
    const gender = "male";
    const age = 25;
    const weight = 75;
    const height = 180;
    const activityLevel = "high";
    const goal = "fitness";
    const profilePicture = "image.png";

    final user = UserDto(
      id: id,
      createdAt: createdAt,
      firstName: firstName,
      lastName: lastName,
      email: email,
      gender: gender,
      age: age,
      weight: weight,
      height: height,
      activityLevel: activityLevel,
      goal: goal,
      profilePicture: profilePicture,
    );

    test('should create instance with correct values', () {
      expect(user.id, id);
      expect(user.createdAt, createdAt);
      expect(user.firstName, firstName);
      expect(user.lastName, lastName);
      expect(user.email, email);
      expect(user.gender, gender);
      expect(user.age, age);
      expect(user.weight, weight);
      expect(user.height, height);
      expect(user.activityLevel, activityLevel);
      expect(user.goal, goal);
      expect(user.profilePicture, profilePicture);
    });

    test('should support Equatable correctly', () {
      final user2 = UserDto(
        id: id,
        createdAt: createdAt,
        firstName: firstName,
        lastName: lastName,
        email: email,
        gender: gender,
        age: age,
        weight: weight,
        height: height,
        activityLevel: activityLevel,
        goal: goal,
        profilePicture: profilePicture,
      );

      expect(user, equals(user2));
      expect(user.props, [
        id,
        createdAt,
        firstName,
        lastName,
        email,
        gender,
        age,
        weight,
        height,
        activityLevel,
        goal,
        profilePicture,
      ]);
    });

    test('should not be equal when values differ', () {
      final differentUser = UserDto(id: "2");

      expect(user == differentUser, false);
    });

    test('should convert from JSON correctly', () {
      final json = {
        "_id": id,
        "createdAt": createdAt,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "gender": gender,
        "age": age,
        "weight": weight,
        "height": height,
        "activityLevel": activityLevel,
        "goal": goal,
        "photo": profilePicture,
      };

      final result = UserDto.fromJson(json);

      expect(result.id, id);
      expect(result.createdAt, createdAt);
      expect(result.firstName, firstName);
      expect(result.lastName, lastName);
      expect(result.email, email);
      expect(result.gender, gender);
      expect(result.age, age);
      expect(result.weight, weight);
      expect(result.height, height);
      expect(result.activityLevel, activityLevel);
      expect(result.goal, goal);
      expect(result.profilePicture, profilePicture);
    });

    test('should convert to JSON correctly', () {
      final json = user.toJson();

      expect(json["_id"], id);
      expect(json["createdAt"], createdAt);
      expect(json["firstName"], firstName);
      expect(json["lastName"], lastName);
      expect(json["email"], email);
      expect(json["gender"], gender);
      expect(json["age"], age);
      expect(json["weight"], weight);
      expect(json["height"], height);
      expect(json["activityLevel"], activityLevel);
      expect(json["goal"], goal);
      expect(json["photo"], profilePicture);
    });

    test('should handle null values correctly', () {
      final json = {
        "_id": null,
        "createdAt": null,
        "firstName": null,
        "lastName": null,
        "email": null,
        "gender": null,
        "age": null,
        "weight": null,
        "height": null,
        "activityLevel": null,
        "goal": null,
        "photo": null,
      };

      final result = UserDto.fromJson(json);

      expect(result.id, null);
      expect(result.createdAt, null);
      expect(result.firstName, null);
      expect(result.lastName, null);
      expect(result.email, null);
      expect(result.gender, null);
      expect(result.age, null);
      expect(result.weight, null);
      expect(result.height, null);
      expect(result.activityLevel, null);
      expect(result.goal, null);
      expect(result.profilePicture, null);
    });

    test('should serialize and deserialize consistently', () {
      final json = user.toJson();
      final recreated = UserDto.fromJson(json);

      expect(recreated, equals(user));
    });
  });
}
