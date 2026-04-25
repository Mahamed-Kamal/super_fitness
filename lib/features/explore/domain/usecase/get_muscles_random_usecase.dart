import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/explore/domain/entities/muscles_entity.dart';
import 'package:super_fitness/features/explore/domain/repo/explore_repo.dart';

@injectable
class GetMusclesRandomUseCase {
  final ExploreRepo _exploreRepo;

  GetMusclesRandomUseCase(this._exploreRepo);
  Future<Result<List<MusclesEntity>>> getMusclesRandom() async {
    final response = await _exploreRepo.getMusclesRandom();
    switch (response) {
      case SuccessResponse<MusclesResponseEntity>():
        return SuccessResponse(data: response.data.muscles ?? []);
      case FailureResponse<MusclesResponseEntity>():
        return FailureResponse(errorMessage: response.errorMessage);
    }
  }
}
