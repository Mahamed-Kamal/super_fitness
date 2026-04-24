import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/exercises/data/data_sources/exercises_data_source.dart';
import 'package:super_fitness/features/exercises/data/mapper/get_difficulty_level_mapper.dart';
import 'package:super_fitness/features/exercises/data/mapper/get_exercises_mapper.dart';
import 'package:super_fitness/features/exercises/data/models/difficulty_levels_response.dart';
import 'package:super_fitness/features/exercises/data/models/exercises_response.dart';
import 'package:super_fitness/features/exercises/domain/entity/difficulty_levels_entity.dart';
import 'package:super_fitness/features/exercises/domain/entity/exercises_entity.dart';
import 'package:super_fitness/features/exercises/domain/repo/exercises_repo.dart';

@Injectable(as: ExercisesRepo)
class ExercisesRepoImpl implements ExercisesRepo {
  final ExercisesDataSource _exercisesDataSource;

  ExercisesRepoImpl(this._exercisesDataSource);
  @override
  Future<Result<List<DifficultyLevelsEntity>>> getDifficultyLevels({
    required String primeMoverMuscleId,
  }) async {
    var result = await _exercisesDataSource.getDifficultyLevels(
      primeMoverMuscleId: primeMoverMuscleId,
    );
    switch (result) {
      case SuccessResponse<DifficultyLevelsResponse>():
        var response = result.data.difficultyLevels!
            .map((e) => e.toEntity())
            .toList();
        return SuccessResponse(data: response);
      case FailureResponse<DifficultyLevelsResponse>():
        return FailureResponse(errorMessage: result.errorMessage);
    }
  }

  @override
  Future<Result<List<ExerciseEntity>>> getExercises({
    required String primeMoverMuscleId,
    required String difficultyLevelId,
    required int page,
  }) async {
    var result = await _exercisesDataSource.getExercises(
      primeMoverMuscleId: primeMoverMuscleId,
      difficultyLevelId: difficultyLevelId,
      page: page,
    );
    switch (result) {
      case SuccessResponse<ExercisesResponse>():
        var response = result.data.exercises!.map((e) => e.toEntity()).toList();
        return SuccessResponse(data: response);
      case FailureResponse<ExercisesResponse>():
        return FailureResponse(errorMessage: result.errorMessage);
    }
  }
}
