import 'package:super_fitness/features/explore/data/models/categories_dto.dart';
import 'package:super_fitness/features/explore/data/models/categories_response.dart';
import 'package:super_fitness/features/explore/data/models/exercises_response.dart';
import 'package:super_fitness/features/explore/data/models/muscles_dto.dart';
import 'package:super_fitness/features/explore/data/models/muscles_group_dto.dart';
import 'package:super_fitness/features/explore/data/models/muscles_group_response.dart';
import 'package:super_fitness/features/explore/data/models/muscles_random_response.dart';
import 'package:super_fitness/features/explore/data/models/special_muscles.dart';
import 'package:super_fitness/features/explore/data/models/trainer_levels_response.dart';
import 'package:super_fitness/features/explore/domain/entities/categories_entity.dart';
import 'package:super_fitness/features/explore/domain/entities/muscles_entity.dart';
import 'package:super_fitness/features/explore/domain/entities/special_muscles_response_entity.dart';
import 'package:super_fitness/features/explore/domain/entities/trainer_levels_entity.dart';

import '../../domain/entities/exercises_response_entity.dart';

extension MusclesRasponseMapper on MusclesRandomDto {
  MusclesResponseEntity toEntity() => MusclesResponseEntity(
    muscles: muscles?.map((e) => e.toEntity()).toList(),
  );
}

extension MusclesEntityMapper on Muscles {
  MusclesEntity toEntity() => MusclesEntity(id: id, image: image, name: name);
}

extension MusclesEntityGroupMapper on MusclesResponseDto {
  MusclesGroupResponseEntity toEntity() => MusclesGroupResponseEntity(
    musclesGroup: musclesGroup?.map((e) => e.toEntity()).toList(),
  );
}

extension MusclesGroupEntityMapper on MusclesGroup {
  MusclesGroupEntity toEntity() => MusclesGroupEntity(id: id, name: name);
}

extension CategoiresResponseEntityMapper on CategoriesResponse {
  CategoriesResponseEntity toEntity() => CategoriesResponseEntity(
    categories: categories?.map((e) => e.toEntity()).toList(),
  );
}

extension CategoriesEntityMapper on Categories {
  CategoriesEntity toEntity() => CategoriesEntity(
    idCategory: idCategory,
    strCategory: strCategory,
    strCategoryThumb: strCategoryThumb,
    strCategoryDescription: strCategoryDescription,
  );
}

extension SpecialMusclesResponseEntityMapper on SpecialMusclesResponse {
  SpecialMusclesResponseEntity toEntity() => SpecialMusclesResponseEntity(
    muscles: muscles?.map((e) => e.toEntity()).toList() ?? [],
    musclesGroup:
        muscleGroup?.toEntity() ?? MusclesGroupEntity(id: '', name: ''),
  );
}

extension TrainerLevelsMapper on TrainerLevels {
  TrainerLevelsEntity toEntity() => TrainerLevelsEntity(
    levels: levels?.map((e) => e.toEntity()).toList() ?? [],
  );
}

extension LevelsEntityMapper on Levels {
  LevelEntity toEntity() => LevelEntity(id: id, name: name);
}

extension ExercisesResponseMapper on ExercisesByPrimeResponse {
  ExercisesResponseEntity toEntity() => ExercisesResponseEntity(
    exercise: exercises?.map((e) => e.toEntity()).toList() ?? [],
    tasks: totalExercises ?? 0,
  );
}

extension ExercisesMapper on Exercises {
  ExerciseEntity toEntity() => ExerciseEntity(
    name: exercise ?? '',
    level: difficultyLevel ?? '',
    story: shortYoutubeDemonstration,
  );
}
