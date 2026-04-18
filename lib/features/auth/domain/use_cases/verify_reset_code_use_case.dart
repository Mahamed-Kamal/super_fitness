import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/domain/entity/verify_reset_code_entity.dart';
import 'package:super_fitness/features/auth/domain/repo/auth_repo.dart';

@injectable
class VerifyResetCodeUseCase {
  final AuthRepo _authRepo;

  VerifyResetCodeUseCase(this._authRepo);
  Future<Result<VerifyResetCodeEntity>> call({required String resetCode}) =>
      _authRepo.verifyOtp(resetCode: resetCode);
}
