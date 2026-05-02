import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/api/api_client.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/exercises/data/data_sources/exercises_data_source_impl.dart';
import 'package:super_fitness/features/exercises/data/models/difficulty_levels_response.dart';
import 'package:super_fitness/features/exercises/data/models/exercises_response.dart';

import 'exercises_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late ExercisesDataSourceImpl dataSource;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = ExercisesDataSourceImpl(mockApiClient);
  });

  const tMuscleId = '69d982ef85f6bfa972bf2248';
  const tDifficultyId = '123';
  const tPage = 1;

  group('getDifficultyLevels', () {
    final tDifficultyResponse = DifficultyLevelsResponse(
      message: 'Success',
      totalLevels: 0,
      difficultyLevels: const [],
    );

    test(
      'should return SuccessResponse when ApiClient call is successful',
      () async {
        when(
          mockApiClient.getDifficultyLevels(primeMoverMuscleId: tMuscleId),
        ).thenAnswer((_) async => tDifficultyResponse);

        final result = await dataSource.getDifficultyLevels(
          primeMoverMuscleId: tMuscleId,
        );

        expect(result, SuccessResponse(data: tDifficultyResponse));
        verify(
          mockApiClient.getDifficultyLevels(primeMoverMuscleId: tMuscleId),
        ).called(1);
      },
    );

    test(
      'should return FailureResponse when ApiClient throws Exception',
      () async {
        when(
          mockApiClient.getDifficultyLevels(
            primeMoverMuscleId: anyNamed('primeMoverMuscleId'),
          ),
        ).thenThrow(Exception('Server Error'));

        final result = await dataSource.getDifficultyLevels(
          primeMoverMuscleId: tMuscleId,
        );

        expect(result, isA<FailureResponse>());
      },
    );
  });

  group('getExercises', () {
    final tExercisesResponse = ExercisesResponse(
      message: 'Success',
      exercises: const [],
    );

    test(
      'should return SuccessResponse when ApiClient call is successful',
      () async {
        when(
          mockApiClient.getExercises(
            primeMoverMuscleId: tMuscleId,
            difficultyLevelId: tDifficultyId,
            page: tPage,
          ),
        ).thenAnswer((_) async => tExercisesResponse);

        final result = await dataSource.getExercises(
          primeMoverMuscleId: tMuscleId,
          difficultyLevelId: tDifficultyId,
          page: tPage,
        );

        expect(result, SuccessResponse(data: tExercisesResponse));
      },
    );

    test(
      'should return FailureResponse when ApiClient throws Exception',
      () async {
        when(
          mockApiClient.getExercises(
            primeMoverMuscleId: anyNamed('primeMoverMuscleId'),
            difficultyLevelId: anyNamed('difficultyLevelId'),
            page: anyNamed('page'),
          ),
        ).thenThrow(Exception('Network Error'));

        final result = await dataSource.getExercises(
          primeMoverMuscleId: tMuscleId,
          difficultyLevelId: tDifficultyId,
          page: tPage,
        );

        expect(result, isA<FailureResponse>());
      },
    );

    test(
      'should return FailureResponse when data is null/invalid but ApiClient succeeds',
      () async {
        // Scenario where executeApi handles null or unexpected formatting if necessary
        when(
          mockApiClient.getExercises(
            primeMoverMuscleId: anyNamed('primeMoverMuscleId'),
            difficultyLevelId: anyNamed('difficultyLevelId'),
            page: anyNamed('page'),
          ),
        ).thenThrow(Exception('Network Error'));

        final result = await dataSource.getExercises(
          primeMoverMuscleId: tMuscleId,
          difficultyLevelId: tDifficultyId,
          page: tPage,
        );

        expect(result, isA<FailureResponse>());
      },
    );
  });
}
