import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/data/models/requests/register_request_model.dart';

abstract interface class AuthDataSource {
  Future<Result<String>> register(RegisterRequestModel registerRequestModel);
}
