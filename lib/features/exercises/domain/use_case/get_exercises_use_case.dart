import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/exercises/domain/entity/exercises_entity.dart';
import 'package:super_fitness/features/exercises/domain/repo/exercises_repo.dart';

@injectable
class GetExercisesUseCase {
  final ExercisesRepo _exercisesRepo;

  GetExercisesUseCase(this._exercisesRepo);

  Future<Result<List<ExerciseEntity>>> invoke({
    required String primeMoverMuscleId,
    required String difficultyLevelId,
    required int page,
  }) => _exercisesRepo.getExercises(
    primeMoverMuscleId: primeMoverMuscleId,
    difficultyLevelId: difficultyLevelId,
    page: page,
  );
}
