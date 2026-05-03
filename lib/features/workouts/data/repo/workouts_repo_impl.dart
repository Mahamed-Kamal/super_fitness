import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/explore/domain/entities/muscles_entity.dart';
import 'package:super_fitness/features/workouts/data/data_source/workouts_data_source.dart';
import 'package:super_fitness/features/workouts/data/models/muscles_dto.dart';
import 'package:super_fitness/features/workouts/data/models/muscles_group_dto.dart';
import 'package:super_fitness/features/workouts/domain/repo/workouts_repo.dart';

@Injectable(as: WorkoutsRepo)
class WorkoutsRepoImpl implements WorkoutsRepo {
  @override
  final WorkoutsDataSource dataSource;

  WorkoutsRepoImpl(this.dataSource);

  @override
  Future<Result<List<MusclesGroupEntity>>> getAllMusclesGroups() async {
    final response = await dataSource.getAllMusclesGroups();
    switch (response) {
      case SuccessResponse<List<MusclesGroupDto>>():
        {
          List<MusclesGroupDto> dto = response.data;
          List<MusclesGroupEntity> entity = dto
              .map((dto) => dto.toEntity())
              .toList();
          return SuccessResponse(data: entity);
        }
      case FailureResponse<List<MusclesGroupDto>>():
        {
          return FailureResponse(errorMessage: response.errorMessage);
        }
    }
  }

  @override
  Future<Result<List<MusclesEntity>>> getMusclesByMusclesGroupID(
    String id,
  ) async {
    final response = await dataSource.getMusclesByMusclesGroupID(id);
    switch (response) {
      case SuccessResponse<List<MusclesDto>>():
        {
          List<MusclesDto> dto = response.data;
          List<MusclesEntity> entity = dto
              .map((dto) => dto.toEntity())
              .toList();
          return SuccessResponse(data: entity);
        }
      case FailureResponse<List<MusclesDto>>():
        {
          return FailureResponse(errorMessage: response.errorMessage);
        }
    }
  }
}
