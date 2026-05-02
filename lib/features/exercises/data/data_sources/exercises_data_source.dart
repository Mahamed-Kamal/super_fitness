import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/exercises/data/models/difficulty_levels_response.dart';
import 'package:super_fitness/features/exercises/data/models/exercises_response.dart';

abstract interface class ExercisesDataSource {
  Future<Result<ExercisesResponse>> getExercises({
    required String primeMoverMuscleId,
    required String difficultyLevelId,
    required int page,
  });

  Future<Result<DifficultyLevelsResponse>> getDifficultyLevels({
    required String primeMoverMuscleId,
  });
}
