import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/explore/data/models/categories_response.dart';
import 'package:super_fitness/features/explore/data/models/exercises_response.dart';
import 'package:super_fitness/features/explore/data/models/muscles_group_response.dart';
import 'package:super_fitness/features/explore/data/models/muscles_random_response.dart';
import 'package:super_fitness/features/explore/data/models/special_muscles.dart';
import 'package:super_fitness/features/explore/data/models/trainer_levels_response.dart';

abstract interface class ExploreDataSource {
  Future<Result<MusclesRandomDto>> getMusclesRandom();
  Future<Result<MusclesResponseDto>> getMusclesGroup();
  Future<Result<SpecialMusclesResponse>> getSpecificMusclesGroup({
    required String id,
  });
  Future<Result<CategoriesResponse>> getCategories();
  Future<Result<TrainerLevels>> getTrainerLevels();
  Future<Result<ExercisesByPrimeResponse>>
  getExerciseByPrimeMoverMuscleAndDiffLevel({
    required String primeMoverMuscle,
    required String difficultyLevel,
  });
}
