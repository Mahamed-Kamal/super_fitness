import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/workouts/data/repo/workouts_repo_impl.dart';
import 'package:super_fitness/features/workouts/domain/use_cases/get_all_muscles_by_muscles_groups_use_case.dart';
import 'package:super_fitness/features/explore/domain/entities/muscles_entity.dart';

import 'get_all_muscles_by_muscles_groups_use_case_test.mocks.dart';

@GenerateMocks([WorkoutsRepoImpl])
void main() {
  late MockWorkoutsRepoImpl mockRepo;
  late GetAllMusclesByMusclesGroupsUseCase useCase;
  late MusclesEntity musclesEntity;
  setUpAll(() {
    //arr
    mockRepo = MockWorkoutsRepoImpl();
    useCase = GetAllMusclesByMusclesGroupsUseCase(mockRepo);
    musclesEntity = MusclesEntity(id: '1', name: 'arms');
    provideDummy<Result<List<MusclesEntity>>>(
      SuccessResponse<List<MusclesEntity>>(data: [musclesEntity]),
    );
  });
  test(
    'test call getAllMusclesGroupsUseCase it should return success',
    () async {
      //acc
      when(useCase.call("1")).thenAnswer((_) async {
        return SuccessResponse<List<MusclesEntity>>(data: [musclesEntity]);
      });
      var result = await useCase.call("1");

      //ass
      expect(result, isA<SuccessResponse<List<MusclesEntity>>>());
    },
  );
  test(
    'test call getAllMusclesGroupsUseCase it should return failure',
    () async {
      //acc
      when(useCase.call("1")).thenAnswer((_) async {
        return FailureResponse<List<MusclesEntity>>(errorMessage: 'error');
      });
      var result = await useCase.call("1");

      //ass
      expect(result, isA<FailureResponse<List<MusclesEntity>>>());
    },
  );
}
