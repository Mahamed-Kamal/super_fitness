import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/domain/entities/user_entity.dart';
import 'package:super_fitness/features/profile/domain/repo/profile_repo.dart';

@injectable
class GetLoggedUserDataUseCase {
  final ProfileRepo _profileRepo;

  GetLoggedUserDataUseCase(this._profileRepo);

  Future<Result<UserEntity>> call() => _profileRepo.getLoggedUserData();
}
