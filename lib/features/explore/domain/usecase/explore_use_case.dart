import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/explore/domain/entities/categories_entity.dart';
import 'package:super_fitness/features/explore/domain/entities/explore_section.dart';
import 'package:super_fitness/features/explore/domain/entities/muscles_entity.dart';
import 'package:super_fitness/features/explore/domain/usecase/get_food_categories_usscase.dart';
import 'package:super_fitness/features/explore/domain/usecase/get_muscles_random_usecase.dart';
import 'package:super_fitness/features/explore/domain/usecase/get_muscles_use_case.dart';

@injectable
class ExploreUseCase {
  final GetMusclesRandomUseCase _getMusclesRandomUseCase;
  final GetMusclesGroupUseCase _getMusclesGroupUseCase;
  final GetFoodCategoriesUscCase _getFoodCategoriesUscCase;

  ExploreUseCase(
    this._getMusclesRandomUseCase,
    this._getMusclesGroupUseCase,
    this._getFoodCategoriesUscCase,
  );
  Future<List<Result<ExploreSection>>> getExploreData() async {
    List<Result<ExploreSection>> results = [];
    var result = await Future.wait([
      _getMusclesGroupUseCase.getMusclesGroup(),
      _getMusclesRandomUseCase.getMusclesRandom(),
      _getFoodCategoriesUscCase.getFoodCategories(),
    ]);

    for (var process in result) {
      switch (process) {
        case SuccessResponse<List<Equatable>>():
          if (result.indexOf(process) == 0) {
            final musclesData = process.data as List<MusclesGroupEntity>;

            results.add(
              SuccessResponse(data: MusclesGroupSection(musclesData, 0)),
            );
          } else {
            final musclesData = process.data as List<MusclesEntity>;
            results.add(
              SuccessResponse(data: MusclesRandomSection(musclesData, 1)),
            );
          }
        case FailureResponse<List<Equatable>>():
          results.add(FailureResponse(errorMessage: process.errorMessage));

        case SuccessResponse<List<Object>>():
          if (result.indexOf(process) == 0) {
            final categories = process.data as List<CategoriesEntity>;

            results.add(
              SuccessResponse(data: CategoriesSection(categories, 0)),
            );
          } else {
            final categories = process.data as List<CategoriesEntity>;
            results.add(
              SuccessResponse(data: CategoriesSection(categories, 1)),
            );
          }
        case FailureResponse<List<Object>>():
          results.add(FailureResponse(errorMessage: process.errorMessage));
      }
    }

    return results;
  }
}
