import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/api/api_client.dart';
import 'package:super_fitness/core/api/execute_api.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/workouts/data/data_source/workouts_data_source.dart';
import 'package:super_fitness/features/workouts/data/models/muscles_dto.dart';
import 'package:super_fitness/features/workouts/data/models/muscles_group_dto.dart';

@Injectable(as: WorkoutsDataSource)
class WorkoutsDataSourceImpl implements WorkoutsDataSource {
  final ApiClient _apiClient;

  WorkoutsDataSourceImpl(this._apiClient);
  @override
  Future<Result<List<MusclesGroupDto>>> getAllMusclesGroups() =>
      executeApi(() async {
        var response = await _apiClient.getAllMusclesGroups();
        return response.musclesGroupDto ?? [];
      });
  @override
  Future<Result<List<MusclesDto>>> getMusclesByMusclesGroupID(String id) =>
      executeApi(() async {
        var response = await _apiClient.getMusclesByMusclesGroupID(id);
        return response.musclesDto ?? [];
      });
}
