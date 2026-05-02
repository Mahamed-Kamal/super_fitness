import 'package:super_fitness/core/error_handling/result.dart';

import '../entity/user_entity.dart';
abstract interface class ProfileRepo {
  Future<Result<UserEntity>> getProfileData();

}
