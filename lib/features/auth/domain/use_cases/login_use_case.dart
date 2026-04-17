import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/data/models/login/login_response_dto.dart';
import 'package:super_fitness/features/auth/domain/repo/auth_repo.dart';

@injectable
class LoginUseCase {
  final AuthRepo _authRepo;
  const LoginUseCase(this._authRepo);

  Future<Result<LoginResponseDto>> call({
    required String email,
    required String password,
  }) {
    return _authRepo.login(email: email, password: password);
  }
}
