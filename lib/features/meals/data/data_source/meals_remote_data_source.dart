import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/meals/api/models/responses/meal_dto.dart';

abstract interface class MealsRemoteDataSource {
  Future<Result<List<MealDto>>> getMealDetails({required String id});
}
