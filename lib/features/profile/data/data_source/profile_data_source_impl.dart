import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/api/api_client.dart';
import 'package:super_fitness/core/api/execute_api.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/profile/data/data_source/profile_data_source.dart';
import 'package:super_fitness/features/profile/data/models/response/profile_response.dart';

@Injectable(as: ProfileDataSource)
class ProfileDataSourceImpl implements ProfileDataSource {
  final ApiClient _apiClient;
  ProfileDataSourceImpl(this._apiClient);
  @override
  Future<Result<ProfileResponse>> getProfileData() {
    return executeApi(() => _apiClient.getUserData());
  }
}
