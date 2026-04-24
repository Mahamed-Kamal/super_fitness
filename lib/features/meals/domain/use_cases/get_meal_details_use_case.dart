import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/meals/domain/entities/meal_entity.dart';
import 'package:super_fitness/features/meals/domain/repo/meals_repo.dart';

@injectable
class GetMealDetailsUseCase {
  final MealsRepo _mealsRepo;

  GetMealDetailsUseCase(this._mealsRepo);

  Future<Result<List<MealEntity>>> getMealDetails({required String id}) =>
      _mealsRepo.getMealDetails(id: id);
}
