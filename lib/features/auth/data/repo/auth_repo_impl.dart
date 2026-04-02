import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/data/data_source/auth_data_source.dart';
import 'package:super_fitness/features/auth/data/models/login/login_response_dto.dart';
import 'package:super_fitness/features/auth/domain/repo/auth_repo.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthDataSource _authDataSource;
  const AuthRepoImpl(this._authDataSource);

  @override
  Future<Result<LoginResponseDto>> login({
    required String email,
    required String password,
  }) async {
    final response = await _authDataSource.login(
      email: email,
      password: password,
    );
    switch (response) {
      case SuccessResponse<LoginResponseDto>():
        return SuccessResponse(data: response.data);
      case FailureResponse<LoginResponseDto>():
        return FailureResponse(errorMessage: response.errorMessage);
    }
  }
}
