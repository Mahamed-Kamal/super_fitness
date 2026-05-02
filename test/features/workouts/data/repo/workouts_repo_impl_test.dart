import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/workouts/data/data_source/workouts_data_source.dart';
import 'package:super_fitness/features/workouts/data/models/muscles_dto.dart';
import 'package:super_fitness/features/workouts/data/models/muscles_group_dto.dart';
import 'package:super_fitness/features/workouts/data/repo/workouts_repo_impl.dart';
import 'package:super_fitness/features/workouts/domain/entity/muscles_entity.dart';
import 'package:super_fitness/features/workouts/domain/entity/muscles_group_entity.dart';

import 'workouts_repo_impl_test.mocks.dart';

@GenerateMocks([WorkoutsDataSource])
void main() {
  late MockWorkoutsDataSource workoutsDataSource;
  late WorkoutsRepoImpl workoutsRepoImpl;
  late MusclesGroupDto musclesGroupDto;
  late MusclesDto musclesDto;
  setUp(() {
    workoutsDataSource = MockWorkoutsDataSource();
    workoutsRepoImpl = WorkoutsRepoImpl(workoutsDataSource);
    musclesGroupDto = MusclesGroupDto(id: '1', name: 'Chest');

    musclesDto = MusclesDto(id: '1', name: 'Pectoralis Major');
    provideDummy<Result<List<MusclesGroupDto>>>(
      SuccessResponse<List<MusclesGroupDto>>(
        data: [musclesGroupDto, musclesGroupDto],
      ),
    );
    provideDummy<Result<List<MusclesDto>>>(
      SuccessResponse<List<MusclesDto>>(data: [musclesDto, musclesDto]),
    );
  });
  test('test call getAllMusclesGroups it should return success', () async {
    when(workoutsDataSource.getAllMusclesGroups()).thenAnswer((_) async {
      return SuccessResponse<List<MusclesGroupDto>>(
        data: [musclesGroupDto, musclesGroupDto],
      );
    });
    final result =
        await workoutsRepoImpl.getAllMusclesGroups()
            as SuccessResponse<List<MusclesGroupEntity>>;
    expect(result, isA<SuccessResponse<List<MusclesGroupEntity>>>());
    expect(result.data.length, equals(2));
  });
  test('test call getAllMusclesGroups it should return failure', () async {
    when(workoutsDataSource.getAllMusclesGroups()).thenAnswer((_) async {
      return FailureResponse<List<MusclesGroupDto>>(errorMessage: 'error');
    });
    final result =
        await workoutsRepoImpl.getAllMusclesGroups()
            as FailureResponse<List<MusclesGroupEntity>>;
    expect(result, isA<FailureResponse<List<MusclesGroupEntity>>>());
    expect(result.errorMessage, 'error');
  });
  test(
    'test call getMusclesByMusclesGroupID it should return success',
    () async {
      when(workoutsDataSource.getMusclesByMusclesGroupID('1')).thenAnswer((
        _,
      ) async {
        return SuccessResponse<List<MusclesDto>>(
          data: [musclesDto, musclesDto],
        );
      });
      final result =
          await workoutsRepoImpl.getMusclesByMusclesGroupID('1')
              as SuccessResponse<List<MusclesEntity>>;
      expect(result, isA<SuccessResponse<List<MusclesEntity>>>());
      expect(result.data.length, equals(2));
    },
  );
  test(
    'test call getMusclesByMusclesGroupID it should return failure',
    () async {
      when(workoutsDataSource.getMusclesByMusclesGroupID('1')).thenAnswer((
        _,
      ) async {
        return FailureResponse<List<MusclesDto>>(errorMessage: 'error');
      });
      final result =
          await workoutsRepoImpl.getMusclesByMusclesGroupID('1')
              as FailureResponse<List<MusclesEntity>>;
      expect(result, isA<FailureResponse<List<MusclesEntity>>>());
      expect(result.errorMessage, 'error');
    },
  );
}
