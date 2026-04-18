import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/features/auth/data/models/requests/update_user_data_request.dart';

void main() {
  group('UpdateUserDataRequest Tests', () {
    test('should initialize with null values by default', () {
      final model = UpdateUserDataRequest();

      expect(model.firstName, null);
      expect(model.lastName, null);
      expect(model.email, null);
      expect(model.gender, null);
      expect(model.height, null);
      expect(model.weight, null);
      expect(model.age, null);
      expect(model.goal, null);
      expect(model.activityLevel, null);
    });

    test('should initialize with given values', () {
      final model = UpdateUserDataRequest(
        firstName: "Mohamed",
        lastName: "Ehab",
        email: "test@test.com",
        gender: "male",
        height: 180,
        weight: 75,
        age: 25,
        goal: "fitness",
        activityLevel: "high",
      );

      expect(model.firstName, "Mohamed");
      expect(model.lastName, "Ehab");
      expect(model.email, "test@test.com");
      expect(model.gender, "male");
      expect(model.height, 180);
      expect(model.weight, 75);
      expect(model.age, 25);
      expect(model.goal, "fitness");
      expect(model.activityLevel, "high");
    });

    test('should convert from JSON correctly', () {
      final json = {
        "firstName": "Mohamed",
        "lastName": "Ehab",
        "email": "test@test.com",
        "gender": "male",
        "height": 180,
        "weight": 75,
        "age": 25,
        "goal": "fitness",
        "activityLevel": "high",
      };

      final model = UpdateUserDataRequest.fromJson(json);

      expect(model.firstName, json["firstName"]);
      expect(model.lastName, json["lastName"]);
      expect(model.email, json["email"]);
      expect(model.gender, json["gender"]);
      expect(model.height, json["height"]);
      expect(model.weight, json["weight"]);
      expect(model.age, json["age"]);
      expect(model.goal, json["goal"]);
      expect(model.activityLevel, json["activityLevel"]);
    });

    test('should convert to JSON correctly', () {
      final model = UpdateUserDataRequest(
        firstName: "Mohamed",
        lastName: "Ehab",
        email: "test@test.com",
        gender: "male",
        height: 180,
        weight: 75,
        age: 25,
        goal: "fitness",
        activityLevel: "high",
      );

      final json = model.toJson();

      expect(json["firstName"], "Mohamed");
      expect(json["lastName"], "Ehab");
      expect(json["email"], "test@test.com");
      expect(json["gender"], "male");
      expect(json["height"], 180);
      expect(json["weight"], 75);
      expect(json["age"], 25);
      expect(json["goal"], "fitness");
      expect(json["activityLevel"], "high");
    });

    test('should serialize and deserialize consistently', () {
      final original = UpdateUserDataRequest(
        firstName: "Mohamed",
        lastName: "Ehab",
        email: "test@test.com",
        gender: "male",
        height: 180,
        weight: 75,
        age: 25,
        goal: "fitness",
        activityLevel: "high",
      );

      final json = original.toJson();
      final recreated = UpdateUserDataRequest.fromJson(json);

      expect(recreated.firstName, original.firstName);
      expect(recreated.lastName, original.lastName);
      expect(recreated.email, original.email);
      expect(recreated.gender, original.gender);
      expect(recreated.height, original.height);
      expect(recreated.weight, original.weight);
      expect(recreated.age, original.age);
      expect(recreated.goal, original.goal);
      expect(recreated.activityLevel, original.activityLevel);
    });
  });
}
