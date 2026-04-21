import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/api/api_client.dart';
import 'package:super_fitness/core/api/execute_api.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/explore/data/data_source/explore_data_source.dart';
import 'package:super_fitness/features/explore/data/models/categories_response.dart';
import 'package:super_fitness/features/explore/data/models/muscles_group_response.dart';
import 'package:super_fitness/features/explore/data/models/muscles_random_response.dart';

@LazySingleton(as: ExploreDataSource)
class ExploreDataSourceImpl implements ExploreDataSource {
  final ApiClient _apiClient;
  ExploreDataSourceImpl(this._apiClient);
  @override
  Future<Result<MusclesRandomDto>> getMusclesRandom() =>
      executeApi(() => _apiClient.getMusclesRandom());

  @override
  Future<Result<MusclesResponseDto>> getMusclesGroup() =>
      executeApi(() => _apiClient.getMusclesGroup());

  @override
  Future<Result<MusclesResponseDto>> getSpecificMusclesGroup({
    required String id,
  }) => executeApi(() => _apiClient.getSpecificMusclesGroup(id: id));

  @override
  Future<Result<CategoriesResponse>> getCategories() =>
      executeApi(() => _apiClient.getCategories());
}
