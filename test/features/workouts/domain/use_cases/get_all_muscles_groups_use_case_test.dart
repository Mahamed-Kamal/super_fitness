import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/workouts/data/repo/workouts_repo_impl.dart';
import 'package:super_fitness/features/workouts/domain/entity/muscles_group_entity.dart';
import 'package:super_fitness/features/workouts/domain/use_cases/get_all_muscles_groups_use_case.dart';

import 'get_all_muscles_by_muscles_groups_use_case_test.mocks.dart';

@GenerateMocks([WorkoutsRepoImpl])
void main() {
  late MockWorkoutsRepoImpl mockRepo;
  late GetAllMusclesGroupsUseCase useCase;
  late MusclesGroupEntity musclesGroupEntity;
  setUpAll(() {
    //arr
    mockRepo = MockWorkoutsRepoImpl();
    useCase = GetAllMusclesGroupsUseCase(mockRepo);
    musclesGroupEntity = MusclesGroupEntity(id: '1', name: 'arms');
    provideDummy<Result<List<MusclesGroupEntity>>>(
      SuccessResponse<List<MusclesGroupEntity>>(data: [musclesGroupEntity]),
    );
  });
  test(
    'test call getAllMusclesGroupsUseCase it should return success',
    () async {
      //acc
      when(useCase.call()).thenAnswer((_) async {
        return SuccessResponse<List<MusclesGroupEntity>>(
          data: [musclesGroupEntity],
        );
      });
      var result = await useCase.call();

      //ass
      expect(result, isA<SuccessResponse<List<MusclesGroupEntity>>>());
    },
  );
  test(
    'test call getAllMusclesGroupsUseCase it should return failure',
    () async {
      //acc
      when(useCase.call()).thenAnswer((_) async {
        return FailureResponse<List<MusclesGroupEntity>>(errorMessage: 'error');
      });
      var result = await useCase.call();

      //ass
      expect(result, isA<FailureResponse<List<MusclesGroupEntity>>>());
    },
  );
}
