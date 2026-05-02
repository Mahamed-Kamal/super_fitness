import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/meals/api/models/responses/meal_dto.dart';
import 'package:super_fitness/features/meals/api/models/responses/categories_response_dto.dart';
import 'package:super_fitness/features/meals/api/models/responses/meals_filter_response_dto.dart';

abstract interface class MealsRemoteDataSource {
  Future<Result<CategoriesResponseDto>> fetchMealCategories();

  Future<Result<MealsFilterResponseDto>> fetchMealsByCategory({
    required String category,
  });
  Future<Result<MealDto>> getMealDetails({required String id});
}
