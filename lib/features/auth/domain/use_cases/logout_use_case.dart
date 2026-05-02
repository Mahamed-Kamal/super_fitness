import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/domain/entity/logout_entity.dart';
import 'package:super_fitness/features/auth/domain/repo/auth_repo.dart';

@lazySingleton
class LogoutUseCase {
  final AuthRepo _authRepo;

  const LogoutUseCase(this._authRepo);

  Future<Result<LogoutEntity>> invoke() => _authRepo.logout();
}
