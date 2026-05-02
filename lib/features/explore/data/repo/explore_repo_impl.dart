import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/explore/data/data_source/explore_data_source.dart';
import 'package:super_fitness/features/explore/data/mapper/explore_mapper.dart';
import 'package:super_fitness/features/explore/data/models/categories_response.dart';
import 'package:super_fitness/features/explore/data/models/exercises_response.dart';
import 'package:super_fitness/features/explore/data/models/muscles_group_response.dart';
import 'package:super_fitness/features/explore/data/models/muscles_random_response.dart';
import 'package:super_fitness/features/explore/data/models/special_muscles.dart';
import 'package:super_fitness/features/explore/data/models/trainer_levels_response.dart';
import 'package:super_fitness/features/explore/domain/entities/categories_entity.dart';
import 'package:super_fitness/features/explore/domain/entities/exercises_response_entity.dart';
import 'package:super_fitness/features/explore/domain/entities/muscles_entity.dart';
import 'package:super_fitness/features/explore/domain/entities/special_muscles_response_entity.dart';
import 'package:super_fitness/features/explore/domain/entities/trainer_levels_entity.dart';
import 'package:super_fitness/features/explore/domain/repo/explore_repo.dart';

@LazySingleton(as: ExploreRepo)
class ExploreRepoImpl implements ExploreRepo {
  final ExploreDataSource _exploreDataSource;

  ExploreRepoImpl(this._exploreDataSource);
  @override
  Future<Result<MusclesResponseEntity>> getMusclesRandom() async {
    final result = await _exploreDataSource.getMusclesRandom();
    switch (result) {
      case SuccessResponse<MusclesRandomDto>():
        return SuccessResponse(data: result.data.toEntity());
      case FailureResponse<MusclesRandomDto>():
        return FailureResponse(errorMessage: result.errorMessage);
    }
  }

  @override
  Future<Result<MusclesGroupResponseEntity>> getMusclesGroup() async {
    final result = await _exploreDataSource.getMusclesGroup();
    switch (result) {
      case SuccessResponse<MusclesResponseDto>():
        return SuccessResponse(data: result.data.toEntity());
      case FailureResponse<MusclesResponseDto>():
        return FailureResponse(errorMessage: result.errorMessage);
    }
  }

  @override
  Future<Result<SpecialMusclesResponseEntity>> getSpecificMusclesGroup({
    required String id,
  }) async {
    final result = await _exploreDataSource.getSpecificMusclesGroup(id: id);
    switch (result) {
      case SuccessResponse<SpecialMusclesResponse>():
        return SuccessResponse(data: result.data.toEntity());
      case FailureResponse<SpecialMusclesResponse>():
        return FailureResponse(errorMessage: result.errorMessage);
    }
  }

  @override
  Future<Result<CategoriesResponseEntity>> getCategories() async {
    final result = await _exploreDataSource.getCategories();
    switch (result) {
      case SuccessResponse<CategoriesResponse>():
        return SuccessResponse(data: result.data.toEntity());
      case FailureResponse<CategoriesResponse>():
        return FailureResponse(errorMessage: result.errorMessage);
    }
  }

  @override
  Future<Result<TrainerLevelsEntity>> getTrainerLevels() async {
    final result = await _exploreDataSource.getTrainerLevels();
    switch (result) {
      case SuccessResponse<TrainerLevels>():
        return SuccessResponse(data: result.data.toEntity());
      case FailureResponse<TrainerLevels>():
        return FailureResponse(errorMessage: result.errorMessage);
    }
  }

  @override
  Future<Result<ExercisesResponseEntity>>
  getExerciseByPrimeMoverMuscleAndDiffLevel({
    required String primeMoverMuscle,
    required String difficultyLevel,
  }) async {
    final result = await _exploreDataSource
        .getExerciseByPrimeMoverMuscleAndDiffLevel(
          primeMoverMuscle: primeMoverMuscle,
          difficultyLevel: difficultyLevel,
        );
    switch (result) {
      case SuccessResponse<ExercisesByPrimeResponse>():
        return SuccessResponse(data: result.data.toEntity());
      case FailureResponse<ExercisesByPrimeResponse>():
        return FailureResponse(errorMessage: result.errorMessage);
    }
  }
}
