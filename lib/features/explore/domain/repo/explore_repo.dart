import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/explore/domain/entities/categories_entity.dart';
import 'package:super_fitness/features/explore/domain/entities/exercises_response_entity.dart';
import 'package:super_fitness/features/explore/domain/entities/muscles_entity.dart';
import 'package:super_fitness/features/explore/domain/entities/special_muscles_response_entity.dart';
import 'package:super_fitness/features/explore/domain/entities/trainer_levels_entity.dart';

abstract interface class ExploreRepo {
  Future<Result<MusclesResponseEntity>> getMusclesRandom();
  Future<Result<MusclesGroupResponseEntity>> getMusclesGroup();
  Future<Result<SpecialMusclesResponseEntity>> getSpecificMusclesGroup({
    required String id,
  });
  Future<Result<CategoriesResponseEntity>> getCategories();
  Future<Result<TrainerLevelsEntity>> getTrainerLevels();
  Future<Result<ExercisesResponseEntity>>
  getExerciseByPrimeMoverMuscleAndDiffLevel({
    required String primeMoverMuscle,
    required String difficultyLevel,
  });
}
