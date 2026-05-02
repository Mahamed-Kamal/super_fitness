import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/api/api_client.dart';
import 'package:super_fitness/core/api/execute_api.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/exercises/data/data_sources/exercises_data_source.dart';
import 'package:super_fitness/features/exercises/data/models/difficulty_levels_response.dart';
import 'package:super_fitness/features/exercises/data/models/exercises_response.dart';

@Injectable(as: ExercisesDataSource)
class ExercisesDataSourceImpl implements ExercisesDataSource {
  final ApiClient _apiClient;

  ExercisesDataSourceImpl(this._apiClient);
  @override
  Future<Result<DifficultyLevelsResponse>> getDifficultyLevels({
    required String primeMoverMuscleId,
  }) {
    return executeApi(
      () => _apiClient.getDifficultyLevels(
        primeMoverMuscleId: primeMoverMuscleId,
      ),
    );
  }

  @override
  Future<Result<ExercisesResponse>> getExercises({
    required String primeMoverMuscleId,
    required String difficultyLevelId,
    required int page,
  }) {
    return executeApi(
      () => _apiClient.getExercises(
        primeMoverMuscleId: primeMoverMuscleId,
        difficultyLevelId: difficultyLevelId,
        page: page,
      ),
    );
  }
}
