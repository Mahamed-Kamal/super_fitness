import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/workouts/domain/entity/muscles_group_entity.dart';
import 'package:super_fitness/features/workouts/domain/repo/workouts_repo.dart';

@injectable
class GetAllMusclesGroupsUseCase {
  final WorkoutsRepo repo;
  GetAllMusclesGroupsUseCase(this.repo);
  Future<Result<List<MusclesGroupEntity>>> call() => repo.getAllMusclesGroups();
}
