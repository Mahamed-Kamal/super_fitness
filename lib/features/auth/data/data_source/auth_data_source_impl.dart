import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/api/api_client.dart';
import 'package:super_fitness/core/api/execute_api.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/data/data_source/auth_data_source.dart';
import 'package:super_fitness/features/auth/data/models/login/login_response_dto.dart';

@Injectable(as: AuthDataSource)
class AuthDataSourceImpl implements AuthDataSource {
  final ApiClient _apiClient;
  const AuthDataSourceImpl(this._apiClient);

  @override
  Future<Result<LoginResponseDto>> login({
    required String email,
    required String password,
  }) {
    return executeApi(() => _apiClient.login(email: email, password: password));
  }
}
