import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/data/models/requests/update_user_data_request.dart';
import 'package:super_fitness/features/auth/domain/entities/user_entity.dart';
import 'package:super_fitness/features/profile/domain/repo/profile_repo.dart';

@injectable
class EditProfileUseCase {
  final ProfileRepo _profileRepo;
  EditProfileUseCase(this._profileRepo);

  Future<Result<UserEntity>> call({
    required UpdateUserDataRequest updateUserDataRequest,
  }) {
    return _profileRepo.editProfile(
      updateUserDataRequest: updateUserDataRequest,
    );
  }
}
