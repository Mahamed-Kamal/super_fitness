import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/features/auth/data/models/requests/register_request_model.dart';

void main() {
  group('RegisterRequestModel Tests', () {
    test('should initialize with default values', () {
      final model = RegisterRequestModel();

      expect(model.firstName, "");
      expect(model.lastName, "");
      expect(model.email, "");
      expect(model.password, "");
      expect(model.rePassword, "");
      expect(model.gender, "");
      expect(model.height, 0);
      expect(model.weight, 0);
      expect(model.age, 0);
      expect(model.goal, "");
      expect(model.activityLevel, "");
    });

    test('should initialize with given values', () {
      final model = RegisterRequestModel(
        firstName: "Mohamed",
        lastName: "Ehab",
        email: "test@test.com",
        password: "123456",
        rePassword: "123456",
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
      expect(model.password, "123456");
      expect(model.rePassword, "123456");
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
        "password": "123456",
        "rePassword": "123456",
        "gender": "male",
        "height": 180,
        "weight": 75,
        "age": 25,
        "goal": "fitness",
        "activityLevel": "high",
      };

      final model = RegisterRequestModel.fromJson(json);

      expect(model.firstName, json["firstName"]);
      expect(model.lastName, json["lastName"]);
      expect(model.email, json["email"]);
      expect(model.password, json["password"]);
      expect(model.rePassword, json["rePassword"]);
      expect(model.gender, json["gender"]);
      expect(model.height, json["height"]);
      expect(model.weight, json["weight"]);
      expect(model.age, json["age"]);
      expect(model.goal, json["goal"]);
      expect(model.activityLevel, json["activityLevel"]);
    });

    test('should convert to JSON correctly', () {
      final model = RegisterRequestModel(
        firstName: "Mohamed",
        lastName: "Ehab",
        email: "test@test.com",
        password: "123456",
        rePassword: "123456",
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
      expect(json["password"], "123456");
      expect(json["rePassword"], "123456");
      expect(json["gender"], "male");
      expect(json["height"], 180);
      expect(json["weight"], 75);
      expect(json["age"], 25);
      expect(json["goal"], "fitness");
      expect(json["activityLevel"], "high");
    });

    test('should serialize and deserialize consistently', () {
      final original = RegisterRequestModel(
        firstName: "Mohamed",
        lastName: "Ehab",
        email: "test@test.com",
        password: "123456",
        rePassword: "123456",
        gender: "male",
        height: 180,
        weight: 75,
        age: 25,
        goal: "fitness",
        activityLevel: "high",
      );

      final json = original.toJson();
      final recreated = RegisterRequestModel.fromJson(json);

      expect(recreated.firstName, original.firstName);
      expect(recreated.lastName, original.lastName);
      expect(recreated.email, original.email);
      expect(recreated.password, original.password);
      expect(recreated.rePassword, original.rePassword);
      expect(recreated.gender, original.gender);
      expect(recreated.height, original.height);
      expect(recreated.weight, original.weight);
      expect(recreated.age, original.age);
      expect(recreated.goal, original.goal);
      expect(recreated.activityLevel, original.activityLevel);
    });
  });
}
