import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/explore/domain/entities/trainer_levels_entity.dart';
import 'package:super_fitness/features/explore/domain/repo/explore_repo.dart';

@injectable
class GetRandomLevelUseCase {
  final ExploreRepo _exploreRepo;
  GetRandomLevelUseCase(this._exploreRepo);
  Future<Result<LevelEntity>> call() async {
    final result = await _exploreRepo.getTrainerLevels();
    switch (result) {
      case SuccessResponse<TrainerLevelsEntity>():
        final random = Random();
        int value = random.nextInt(result.data.levels.length);
        return SuccessResponse(data: result.data.levels[value]);
      case FailureResponse<TrainerLevelsEntity>():
        return FailureResponse(errorMessage: result.errorMessage);
    }
  }
}
