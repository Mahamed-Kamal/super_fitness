import 'package:super_fitness/core/error_handling/result.dart';

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
}
