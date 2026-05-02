import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/api/execute_api.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/meals/api/client/meals_api_client.dart';
import 'package:super_fitness/features/meals/api/models/responses/categories_response_dto.dart';
import 'package:super_fitness/features/meals/api/models/responses/meals_filter_response_dto.dart';
import 'package:super_fitness/features/meals/data/data_source/meals_remote_data_source.dart';

@Injectable(as: MealsRemoteDataSource)
class MealsRemoteDataSourceImpl implements MealsRemoteDataSource {
  final MealsApiClient _mealsApiClient;

  MealsRemoteDataSourceImpl(this._mealsApiClient);

  @override
  Future<Result<CategoriesResponseDto>> fetchMealCategories() {
    return executeApi(() => _mealsApiClient.getMealCategories());
  }

  @override
  Future<Result<MealsFilterResponseDto>> fetchMealsByCategory({
    required String category,
  }) {
    return executeApi(() => _mealsApiClient.getMealsByCategory(category));
  }
}
