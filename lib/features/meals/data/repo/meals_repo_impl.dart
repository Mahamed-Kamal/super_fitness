import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/meals/api/models/responses/meal_dto.dart';
import 'package:super_fitness/features/meals/data/data_source/meals_remote_data_source.dart';
import 'package:super_fitness/features/meals/data/mappers/meal_details_mapper.dart';
import 'package:super_fitness/features/meals/domain/entities/meal_entity.dart';
import 'package:super_fitness/features/meals/domain/repo/meals_repo.dart';

@Injectable(as: MealsRepo)
class MealsRepoImpl implements MealsRepo {
  final MealsRemoteDataSource _mealsRemoteDataSource;

  MealsRepoImpl(this._mealsRemoteDataSource);

  @override
  Future<Result<MealEntity>> getMealDetails({required String id}) async {
    var result = await _mealsRemoteDataSource.getMealDetails(id: id);
    switch (result) {
      case SuccessResponse<MealDto>():
        return SuccessResponse(data: result.data.toMealEntity());
      case FailureResponse<MealDto>():
        return FailureResponse(errorMessage: result.errorMessage);
    }
  }
}
