import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/explore/domain/entities/muscles_entity.dart';
import 'package:super_fitness/features/workouts/domain/repo/workouts_repo.dart';

@injectable
class GetAllMusclesByMusclesGroupsUseCase {
  final WorkoutsRepo repo;
  GetAllMusclesByMusclesGroupsUseCase(this.repo);
  Future<Result<List<MusclesEntity>>> call(String id) =>
      repo.getMusclesByMusclesGroupID(id);
}
