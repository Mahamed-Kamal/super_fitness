import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/explore/domain/entities/exercises_response_entity.dart';
import 'package:super_fitness/features/explore/domain/entities/muscles_entity.dart';
import 'package:super_fitness/features/explore/domain/entities/trainer_levels_entity.dart';
import 'package:super_fitness/features/explore/domain/repo/explore_repo.dart';
import 'package:super_fitness/features/explore/domain/usecase/get_muscles_random_usecase.dart';
import 'package:super_fitness/features/explore/domain/usecase/get_random_level_use_case.dart';

@injectable
class GetPopularTrainingUseCase {
  final GetRandomLevelUseCase _getRandomLevelUseCase;
  final GetMusclesRandomUseCase _getMusclesRandomUseCase;
  final ExploreRepo _exploreRepo;
  GetPopularTrainingUseCase(
    this._getRandomLevelUseCase,
    this._getMusclesRandomUseCase,
    this._exploreRepo,
  );

  Future<Result<ExercisesResponseEntity>> call() async {
    final getRandomLevelId = await _getRandomLevelUseCase.call().then((result) {
      switch (result) {
        case SuccessResponse<LevelEntity>():
          return result.data.id;
        case FailureResponse<LevelEntity>():
          return result.errorMessage;
      }
    });
    final difficultyLevelId = await _getMusclesRandomUseCase
        .getMusclesRandom()
        .then((result) {
          switch (result) {
            case SuccessResponse<List<MusclesEntity>>():
              return result.data[0].id;
            case FailureResponse<List<MusclesEntity>>():
              return result.errorMessage;
          }
        });
    if (difficultyLevelId == null || getRandomLevelId == null) {
      return FailureResponse(errorMessage: "can't load Popular Ex");
    }
    final result = await _exploreRepo.getExerciseByPrimeMoverMuscleAndDiffLevel(
      primeMoverMuscle: difficultyLevelId,
      difficultyLevel: getRandomLevelId,
    );
    switch (result) {
      case SuccessResponse<ExercisesResponseEntity>():
        return SuccessResponse(data: result.data);
      case FailureResponse<ExercisesResponseEntity>():
        return FailureResponse(errorMessage: result.errorMessage);
    }
  }
}
