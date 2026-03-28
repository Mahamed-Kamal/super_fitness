import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/features/auth/domain/entities/user_gender.dart';

void main() {
  group("UserGender enum test", () {
    test("should contain exactly 2 values", () {
      expect(UserGender.values.length, 2);
    });

    test("should contain all expected enum values in correct order", () {
      expect(UserGender.values[0], UserGender.male);
      expect(UserGender.values[1], UserGender.female);
    });

    test("should return correct names", () {
      expect(UserGender.male.name, "male");
      expect(UserGender.female.name, "female");
    });

    test("should access enum using index correctly", () {
      final gender = UserGender.values[1];
      expect(gender, UserGender.female);
    });

    test("toString should return correct value", () {
      expect(UserGender.male.toString(), "UserGender.male");
      expect(UserGender.female.toString(), "UserGender.female");
    });
  });
}
