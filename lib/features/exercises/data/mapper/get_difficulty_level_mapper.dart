import 'package:super_fitness/features/exercises/data/models/difficulty_levels_dto.dart';
import 'package:super_fitness/features/exercises/domain/entity/difficulty_levels_entity.dart';

extension GetDifficultyLevelMapper on DifficultyLevelsDTO {
  DifficultyLevelsEntity toEntity() {
    return DifficultyLevelsEntity(id: id, name: name);
  }
}
