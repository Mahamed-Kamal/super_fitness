import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/meals/domain/entities/meal_category_entity.dart';
import 'package:super_fitness/features/meals/domain/repo/meals_repo.dart';

@injectable
class GetMealsCategoriesUseCase {
  final MealsRepo _mealsRepo;
  const GetMealsCategoriesUseCase(this._mealsRepo);

  Future<Result<List<MealCategoryEntity>>> call() {
    return _mealsRepo.getMealCategories();
  }
}
