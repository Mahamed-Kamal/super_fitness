import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/meals/domain/entities/meal_category_entity.dart';
import 'package:super_fitness/features/meals/domain/entities/meal_entity.dart';

abstract interface class MealsRepo {
  Future<Result<List<MealCategoryEntity>>> getMealCategories();

  Future<Result<List<MealEntity>>> getMealsByCategory({
    required String category,
  });
}
