import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/explore/domain/entities/muscles_entity.dart';
import 'package:super_fitness/features/workouts/data/data_source/workouts_data_source.dart';

abstract interface class WorkoutsRepo {
  final WorkoutsDataSource dataSource;
  WorkoutsRepo(this.dataSource);
  Future<Result<List<MusclesGroupEntity>>> getAllMusclesGroups();
  Future<Result<List<MusclesEntity>>> getMusclesByMusclesGroupID(String id);
}
