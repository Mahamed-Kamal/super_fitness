import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/meals/domain/entities/meal_entity.dart';
import 'package:super_fitness/features/meals/domain/repo/meals_repo.dart';

@injectable
class GetMealsByCategoryUseCase {
  final MealsRepo _mealsRepo;
  const GetMealsByCategoryUseCase(this._mealsRepo);

  Future<Result<List<MealEntity>>> call({required String category}) {
    return _mealsRepo.getMealsByCategory(category: category);
  }
}
