import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/profile/domain/repo/profile_repo.dart';

import '../entity/user_entity.dart' show UserEntity;

@injectable
class GetProfileDataUseCase {
  final ProfileRepo _profileRepo;
  const GetProfileDataUseCase(this._profileRepo);
  Future<Result<UserEntity>> call() => _profileRepo.getProfileData();
}
