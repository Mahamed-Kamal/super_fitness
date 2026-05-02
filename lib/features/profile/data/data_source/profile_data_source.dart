import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/profile/data/models/response/profile_response.dart';

abstract interface class ProfileDataSource {
  Future<Result<ProfileResponse>> getProfileData();
}
