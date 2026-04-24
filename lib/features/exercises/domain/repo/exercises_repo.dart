import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/exercises/domain/entity/difficulty_levels_entity.dart';
import 'package:super_fitness/features/exercises/domain/entity/exercises_entity.dart';

abstract interface class ExercisesRepo {
  Future<Result<List<ExerciseEntity>>> getExercises({
    required String primeMoverMuscleId,
    required String difficultyLevelId,
    required int page,
  });
  Future<Result<List<DifficultyLevelsEntity>>> getDifficultyLevels({
    required String primeMoverMuscleId,
  });
}
