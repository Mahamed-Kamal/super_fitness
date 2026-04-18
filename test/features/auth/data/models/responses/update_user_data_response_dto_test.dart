import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/core/api/models/users_dto.dart';
import 'package:super_fitness/features/auth/data/models/responses/update_user_data_response_dto.dart';

void main() {
  group('UpdateUserDataResponseDto Tests', () {
    // Mock user for testing nested objects
    const mockUser = UsersDto(
      id: "123",
      email: "test@test.com",
      firstName: "Mohamed",
    );

    test('should initialize with null values by default', () {
      const model = UpdateUserDataResponseDto();

      expect(model.message, null);
      expect(model.user, null);
    });

    test('should initialize with given values', () {
      const model = UpdateUserDataResponseDto(
        message: "Success",
        user: mockUser,
      );

      expect(model.message, "Success");
      expect(model.user, mockUser);
    });

    test('should convert from JSON correctly', () {
      final json = {
        "message": "Update Successful",
        "user": {
          "_id": "123",
          "email": "test@test.com",
          "firstName": "Mohamed",
        },
      };

      final model = UpdateUserDataResponseDto.fromJson(json);

      expect(model.message, json["message"]);
      expect(model.user?.id, "123");
      expect(model.user?.email, "test@test.com");
    });

    test('should convert to JSON correctly', () {
      const model = UpdateUserDataResponseDto(
        message: "Update Successful",
        user: mockUser,
      );

      final json = model.toJson();

      expect(json["message"], "Update Successful");
      expect(json["user"]["_id"], "123");
      expect(json["user"]["email"], "test@test.com");
    });

    test('should serialize and deserialize consistently', () {
      const original = UpdateUserDataResponseDto(
        message: "Update Successful",
        user: mockUser,
      );

      final json = original.toJson();
      final recreated = UpdateUserDataResponseDto.fromJson(json);

      expect(recreated.message, original.message);
      expect(recreated.user, original.user);
      // Equatable check
      expect(recreated, original);
    });

    test('should support value equality via Equatable', () {
      const model1 = UpdateUserDataResponseDto(
        message: "Success",
        user: mockUser,
      );
      const model2 = UpdateUserDataResponseDto(
        message: "Success",
        user: mockUser,
      );

      expect(model1, model2);
    });
  });
}
