import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/domain/entities/user_entity.dart';
import 'package:super_fitness/features/auth/domain/repo/auth_repo.dart';

class UpdateUserDataUseCase {
  final AuthRepo _authRepo;

  UpdateUserDataUseCase(this._authRepo);

  Future<Result<UserEntity>> call({
    String token = "",
    String? firstName,
    String? lastName,
    String? email,
    String? gender,
    int? height,
    int? weight,
    int? age,
    String? goal,
    String? activityLevel,
  }) async => _authRepo.updateUserData(
    token: token,
    firstName: firstName,
    lastName: lastName,
    email: email,
    gender: gender,
    height: height,
    weight: weight,
    age: age,
    goal: goal,
    activityLevel: activityLevel,
  );
}
