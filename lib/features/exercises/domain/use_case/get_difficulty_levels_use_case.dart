import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/exercises/domain/entity/difficulty_levels_entity.dart';
import 'package:super_fitness/features/exercises/domain/repo/exercises_repo.dart';

@injectable
class GetDifficultyLevelsUseCase {
  final ExercisesRepo _exercisesRepo;

  GetDifficultyLevelsUseCase(this._exercisesRepo);

  Future<Result<List<DifficultyLevelsEntity>>> invoke({
    required String primeMoverMuscleId,
  }) => _exercisesRepo.getDifficultyLevels(
    primeMoverMuscleId: primeMoverMuscleId,
  );
}
