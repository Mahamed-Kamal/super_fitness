import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/features/auth/data/models/responses/register_response_dto.dart';
import 'package:super_fitness/core/api/models/users_dto.dart';

void main() {
  group('RegisterResponseDto Tests', () {
    const message = "Success";
    const token = "token_123";

    final user = UsersDto(
      id: "1",
      firstName: "Mohamed",
      lastName: "Ehab",
      email: "test@test.com",
    );

    test('should create instance with given values', () {
      const dto = RegisterResponseDto(
        message: message,
        user: null,
        token: token,
      );

      expect(dto.message, message);
      expect(dto.user, null);
      expect(dto.token, token);
    });

    test('should support Equatable props correctly', () {
      final dto1 = RegisterResponseDto(
        message: message,
        user: user,
        token: token,
      );

      final dto2 = RegisterResponseDto(
        message: message,
        user: user,
        token: token,
      );

      expect(dto1, equals(dto2));
      expect(dto1.props, [message, user, token]);
    });

    test('should not be equal when values differ', () {
      final dto1 = RegisterResponseDto(
        message: message,
        user: user,
        token: token,
      );

      final dto2 = RegisterResponseDto(
        message: "Different",
        user: user,
        token: token,
      );

      expect(dto1 == dto2, false);
    });

    test('should convert from JSON correctly', () {
      final json = {"message": message, "user": user.toJson(), "token": token};

      final dto = RegisterResponseDto.fromJson(json);

      expect(dto.message, message);
      expect(dto.token, token);
      expect(dto.user, isNotNull);
      expect(dto.user!.id, user.id);
      expect(dto.user!.email, user.email);
    });

    test('should convert to JSON correctly', () {
      final dto = RegisterResponseDto(
        message: message,
        user: user,
        token: token,
      );

      final json = dto.toJson();

      expect(json["message"], message);
      expect(json["token"], token);
      expect(json["user"], isA<Map<String, dynamic>>());
    });

    test('should handle null values in JSON', () {
      final json = {"message": null, "user": null, "token": null};

      final dto = RegisterResponseDto.fromJson(json);

      expect(dto.message, null);
      expect(dto.user, null);
      expect(dto.token, null);
    });

    test('should serialize and deserialize consistently', () {
      final original = RegisterResponseDto(
        message: message,
        user: user,
        token: token,
      );

      final json = original.toJson();
      final recreated = RegisterResponseDto.fromJson(json);

      expect(recreated, equals(original));
    });
  });
}
