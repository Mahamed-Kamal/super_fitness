import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/domain/entities/user_entity.dart';

abstract interface class AuthRepo {
  Future<Result<String>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String gender,
    required int height,
    required int weight,
    required int age,
    required String goal,
    required String activityLevel,
  });

  Future<Result<UserEntity>> updateUserData({
    String token = "",
    String? firstName,
    String? lastName,
    String? email,
    String? gender,
    int? height,
    int? weight,
    int? age,
    String? goal,
    String? activityLevel,
  });
}
