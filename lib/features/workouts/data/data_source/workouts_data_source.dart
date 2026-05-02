import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/workouts/data/models/muscles_dto.dart';
import 'package:super_fitness/features/workouts/data/models/muscles_group_dto.dart';

abstract interface class WorkoutsDataSource {
  Future<Result<List<MusclesGroupDto>>> getAllMusclesGroups();
  Future<Result<List<MusclesDto>>> getMusclesByMusclesGroupID(String id);
}
