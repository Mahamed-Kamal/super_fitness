import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/exercises/data/data_sources/exercises_data_source.dart';
import 'package:super_fitness/features/exercises/data/models/difficulty_levels_dto.dart';
import 'package:super_fitness/features/exercises/data/models/difficulty_levels_response.dart';
import 'package:super_fitness/features/exercises/data/models/exercises_dto.dart';
import 'package:super_fitness/features/exercises/data/models/exercises_response.dart';
import 'package:super_fitness/features/exercises/data/repo/exercises_repo_impl.dart';
import 'package:super_fitness/features/exercises/domain/entity/difficulty_levels_entity.dart';
import 'package:super_fitness/features/exercises/domain/entity/exercises_entity.dart';

@GenerateMocks([ExercisesDataSource])
import 'exercises_repo_impl_test.mocks.dart';

void main() {
  late ExercisesRepoImpl repository;
  late MockExercisesDataSource mockDataSource;

  setUpAll(() {
    provideDummy<Result<DifficultyLevelsResponse>>(
      SuccessResponse(data: DifficultyLevelsResponse(difficultyLevels: [])),
    );
    provideDummy<Result<ExercisesResponse>>(
      SuccessResponse(data: ExercisesResponse(exercises: [])),
    );
  });

  setUp(() {
    mockDataSource = MockExercisesDataSource();
    repository = ExercisesRepoImpl(mockDataSource);
  });

  const tMuscleId = '69d982ef85f6bfa972bf2248';
  const tDifficultyId = '123';
  const tPage = 1;

  group('getDifficultyLevels', () {
    final tDifficultyLevelsResponse = DifficultyLevelsResponse(
      difficultyLevels: [DifficultyLevelsDTO(id: '1', name: 'Beginner')],
    );

    final tDifficultyLevelsEntities = [
      const DifficultyLevelsEntity(id: '1', name: 'Beginner'),
    ];

    test(
      'should return SuccessResponse when DataSource returns data',
      () async {
        when(
          mockDataSource.getDifficultyLevels(
            primeMoverMuscleId: anyNamed('primeMoverMuscleId'),
          ),
        ).thenAnswer(
          (_) async => SuccessResponse(data: tDifficultyLevelsResponse),
        );

        final result = await repository.getDifficultyLevels(
          primeMoverMuscleId: tMuscleId,
        );

        expect(result, SuccessResponse(data: tDifficultyLevelsEntities));
        verify(
          mockDataSource.getDifficultyLevels(primeMoverMuscleId: tMuscleId),
        ).called(1);
      },
    );

    test(
      'should return FailureResponse when DataSource returns FailureResponse',
      () async {
        when(
          mockDataSource.getDifficultyLevels(
            primeMoverMuscleId: anyNamed('primeMoverMuscleId'),
          ),
        ).thenAnswer((_) async => FailureResponse(errorMessage: 'Error'));

        final result = await repository.getDifficultyLevels(
          primeMoverMuscleId: tMuscleId,
        );

        expect(result, isA<FailureResponse>());
        expect((result as FailureResponse).errorMessage, 'Error');
      },
    );
  });

  group('getExercises', () {
    final tExercisesResponse = ExercisesResponse(
      exercises: [
        ExercisesDTO(
          id: '1',
          exercise: 'Push Up',
          shortYoutubeDemonstrationLink: 'https://youtu.be/video',
        ),
      ],
    );

    test(
      'should return SuccessResponse when DataSource returns exercises',
      () async {
        when(
          mockDataSource.getExercises(
            primeMoverMuscleId: anyNamed('primeMoverMuscleId'),
            difficultyLevelId: anyNamed('difficultyLevelId'),
            page: anyNamed('page'),
          ),
        ).thenAnswer((_) async => SuccessResponse(data: tExercisesResponse));

        final result = await repository.getExercises(
          primeMoverMuscleId: tMuscleId,
          difficultyLevelId: tDifficultyId,
          page: tPage,
        );

        expect(result, isA<SuccessResponse<List<ExerciseEntity>>>());
        expect((result as SuccessResponse).data.first.exercise, 'Push Up');
        verify(
          mockDataSource.getExercises(
            primeMoverMuscleId: tMuscleId,
            difficultyLevelId: tDifficultyId,
            page: tPage,
          ),
        ).called(1);
      },
    );

    test(
      'should return FailureResponse when DataSource returns FailureResponse',
      () async {
        when(
          mockDataSource.getExercises(
            primeMoverMuscleId: anyNamed('primeMoverMuscleId'),
            difficultyLevelId: anyNamed('difficultyLevelId'),
            page: anyNamed('page'),
          ),
        ).thenAnswer(
          (_) async => FailureResponse(errorMessage: 'Internal Error'),
        );

        final result = await repository.getExercises(
          primeMoverMuscleId: tMuscleId,
          difficultyLevelId: tDifficultyId,
          page: tPage,
        );

        expect(result, isA<FailureResponse>());
        expect((result as FailureResponse).errorMessage, 'Internal Error');
      },
    );
  });
}
