import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/api/api_client.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/workouts/data/data_source/workouts_data_source_impl.dart';
import 'package:super_fitness/features/workouts/data/models/all_muscles_by_muscle_group_id_response.dart';
import 'package:super_fitness/features/workouts/data/models/all_muscles_group_response.dart';
import 'package:super_fitness/features/workouts/data/models/muscles_dto.dart';
import 'package:super_fitness/features/workouts/data/models/muscles_group_dto.dart';

import '../../../auth/data/data_source/auth_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late WorkoutsDataSourceImpl workoutsDataSourceImpl;
  late MockApiClient mockApiClient;
  late Exception exception;
  setUp(() {
    //arr
    mockApiClient = MockApiClient();
    workoutsDataSourceImpl = WorkoutsDataSourceImpl(mockApiClient);
    exception = Exception('error');
  });
  test('test call getAllMusclesGroups it should return success', () async {
    AllMusclesGroupResponse response = AllMusclesGroupResponse(message: "");
    //acc
    when(mockApiClient.getAllMusclesGroups()).thenAnswer((_) async {
      return response;
    });

    final result = await workoutsDataSourceImpl.getAllMusclesGroups();
    //ass
    expect(result, isA<SuccessResponse<List<MusclesGroupDto>>>());
  });
  test('test call getAllMusclesGroups it should return failure', () async {
    //acc
    when(mockApiClient.getAllMusclesGroups()).thenThrow(exception);
    final result =
        await workoutsDataSourceImpl.getAllMusclesGroups()
            as FailureResponse<List<MusclesGroupDto>>;
    //ass
    expect(result, isA<FailureResponse<List<MusclesGroupDto>>>());
    expect(result.errorMessage, 'errors.unexpected');
  });
  test(
    'test call getMusclesByMusclesGroupID it should return success',
    () async {
      AllMusclesByMuscleGroupIdResponse response =
          AllMusclesByMuscleGroupIdResponse(message: "");
      //acc
      when(mockApiClient.getMusclesByMusclesGroupID('1')).thenAnswer((_) async {
        return response;
      });
      final result = await workoutsDataSourceImpl.getMusclesByMusclesGroupID(
        '1',
      );
      //ass
      expect(result, isA<SuccessResponse<List<MusclesDto>>>());
    },
  );
  test(
    'test call getMusclesByMusclesGroupID it should return failure',
    () async {
      //acc
      when(mockApiClient.getMusclesByMusclesGroupID('1')).thenThrow(exception);
      final result =
          await workoutsDataSourceImpl.getMusclesByMusclesGroupID('1')
              as FailureResponse<List<MusclesDto>>;
      //ass
      expect(result, isA<FailureResponse<List<MusclesDto>>>());
      expect(result.errorMessage, 'errors.unexpected');
    },
  );
}
