import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/domain/repo/auth_repo.dart';

@injectable
class RegisterUseCase {
  final AuthRepo _authRepo;

  RegisterUseCase(this._authRepo);

  Future<Result<String>> call({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String gender,
    required int height,
    required int weight,
    required int age,
    required String goal,
    required String activityLevel,
  }) => _authRepo.register(
    firstName: firstName,
    lastName: lastName,
    email: email,
    password: password,
    rePassword: rePassword,
    gender: gender,
    height: height,
    weight: weight,
    age: age,
    goal: goal,
    activityLevel: activityLevel,
  );
}
