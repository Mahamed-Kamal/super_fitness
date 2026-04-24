import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/api/execute_api.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/meals/api/client/meals_api_client.dart';
import 'package:super_fitness/features/meals/api/models/responses/meal_dto.dart';
import 'package:super_fitness/features/meals/data/data_source/meals_remote_data_source.dart';

@Injectable(as: MealsRemoteDataSource)
class MealsRemoteDataSourceImpl implements MealsRemoteDataSource {
  final MealsApiClient _mealsApiClient;

  MealsRemoteDataSourceImpl(this._mealsApiClient);

  @override
  Future<Result<List<MealDto>>> getMealDetails({required String id}) async {
    return executeApi(() async {
      var response = await _mealsApiClient.getMealDetails(id: id);
      if (response.meals != null) {
        return response.meals!;
      } else {
        return [];
      }
    });
  }
}
