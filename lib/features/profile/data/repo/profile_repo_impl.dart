import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/profile/data/data_source/profile_data_source.dart';
import 'package:super_fitness/features/profile/data/models/response/profile_response.dart';
import 'package:super_fitness/features/profile/domain/repo/profile_repo.dart';

import '../../domain/entity/user_entity.dart';
import '../models/response/user_dto.dart';

@Injectable(as: ProfileRepo)
class ProfileRepoImpl implements ProfileRepo {
  final ProfileDataSource _profileDataSource;

  const ProfileRepoImpl(this._profileDataSource);

  @override
  Future<Result<UserEntity>> getProfileData() async {
    var response = await _profileDataSource.getProfileData();
    switch (response) {
      case SuccessResponse<ProfileResponse>():
        {
          UserDto userDto = response.data.userDto ?? UserDto();
          UserEntity userEntity = userDto.toEntity();
          return SuccessResponse<UserEntity>(data: userEntity);
        }
      case FailureResponse<ProfileResponse>():
        {
          return FailureResponse<UserEntity>(
            errorMessage: response.errorMessage,
          );
        }
    }
  }
}
