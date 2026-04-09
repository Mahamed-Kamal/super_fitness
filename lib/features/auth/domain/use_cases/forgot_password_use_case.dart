import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/domain/repo/auth_repo.dart';

import '../entity/forget_password_entity.dart';

@injectable
class ForgetPasswordUseCase {
  final AuthRepo _authRepo;

  ForgetPasswordUseCase(this._authRepo);
  Future<Result<ForgotPasswordEntity>> call ({required String email})=>
      _authRepo.forgotPassword(email: email);
}




