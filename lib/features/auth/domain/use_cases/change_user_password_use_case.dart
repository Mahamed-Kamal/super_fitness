import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/domain/repo/auth_repo.dart';

@injectable
class ChangeUserPasswordUseCase {
  final AuthRepo _authRepo;

  ChangeUserPasswordUseCase(this._authRepo);

  Future<Result<String>> call({
    required String currentPassword,
    required String newPassword,
  }) async => _authRepo.changeUserPassword(
    currentPassword: currentPassword,
    newPassword: newPassword,
  );
}
