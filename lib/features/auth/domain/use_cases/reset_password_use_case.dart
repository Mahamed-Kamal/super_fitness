import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/domain/entity/reset_password_entity.dart';
import 'package:super_fitness/features/auth/domain/repo/auth_repo.dart';

@injectable
class ResetPasswordUseCase {
  final AuthRepo _authRepo;

  ResetPasswordUseCase(this._authRepo);
  Future<Result<ResetPasswordEntity>> call({
    required String email,
    required String newPassword,
  }) => _authRepo.resetPassword(email: email, newPassword: newPassword);
}
