import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/explore/domain/entities/categories_entity.dart';
import 'package:super_fitness/features/explore/domain/repo/explore_repo.dart';

@injectable
class GetFoodCategoriesUscCase {
  final ExploreRepo _exploreRepo;

  GetFoodCategoriesUscCase(this._exploreRepo);

  Future<Result<List<CategoriesEntity>>> getFoodCategories() async {
    final response = await _exploreRepo.getCategories();
    switch (response) {
      case SuccessResponse<CategoriesResponseEntity>():
        return SuccessResponse(data: response.data.categories ?? []);
      case FailureResponse<CategoriesResponseEntity>():
        return FailureResponse(errorMessage: response.errorMessage);
    }
  }
}
