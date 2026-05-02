import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/explore/domain/entities/muscles_entity.dart';
import 'package:super_fitness/features/explore/domain/repo/explore_repo.dart';

@injectable
class GetMusclesGroupUseCase {
  final ExploreRepo _exploreRepo;

  GetMusclesGroupUseCase(this._exploreRepo);
  Future<Result<List<MusclesGroupEntity>>> getMusclesGroup() async {
    final response = await _exploreRepo.getMusclesGroup();
    switch (response) {
      case SuccessResponse<MusclesGroupResponseEntity>():
        return SuccessResponse(data: response.data.musclesGroup ?? []);
      case FailureResponse<MusclesGroupResponseEntity>():
        return FailureResponse(errorMessage: response.errorMessage);
    }
  }
}
