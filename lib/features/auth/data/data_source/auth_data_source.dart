import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/data/models/login/login_response_dto.dart';

abstract interface class AuthDataSource {
  Future<Result<LoginResponseDto>> login({required String email, required String password});
}
