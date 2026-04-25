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
  Future<Result<MealDto>> getMealDetails({required String id}) async {
    if (id.isNotEmpty) {
      return executeApi(() async {
        var response = await _mealsApiClient.getMealDetails(id: id);
        return response.meals!.first;
      });
    } else {
      return FailureResponse(errorMessage: "empty_id");
    }
  }
}
