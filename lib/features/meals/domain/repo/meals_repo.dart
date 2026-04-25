import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/meals/domain/entities/meal_entity.dart';

abstract interface class MealsRepo {
  Future<Result<MealEntity>> getMealDetails({required String id});
}
