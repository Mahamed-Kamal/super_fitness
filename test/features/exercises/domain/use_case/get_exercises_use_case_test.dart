import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/exercises/domain/entity/exercises_entity.dart';
import 'package:super_fitness/features/exercises/domain/repo/exercises_repo.dart';
import 'package:super_fitness/features/exercises/domain/use_case/get_exercises_use_case.dart';
import 'get_exercises_use_case_test.mocks.dart';

@GenerateMocks([ExercisesRepo])
void main() {
  late GetExercisesUseCase useCase;
  late MockExercisesRepo mockExercisesRepo;

  setUpAll(() {
    provideDummy<Result<List<ExerciseEntity>>>(SuccessResponse(data: []));
  });

  setUp(() {
    mockExercisesRepo = MockExercisesRepo();
    useCase = GetExercisesUseCase(mockExercisesRepo);
  });

  const tMuscleId = '69d982ef85f6bfa972bf2248';
  const tDifficultyId = '123';
  const tPage = 1;

  final tExercises = [
    ExerciseEntity(
      id: '1',
      exercise: 'Push Up',
      muscle: 'Chest',
      equipment: 'Bodyweight',
      difficulty: 'Beginner',
      videoUrl: 'https://www.youtube.com/watch?v=op9scZ4J7p4',
      thumbnailUrl: 'https://img.youtube.com/vi/op9scZ4J7p4/0.jpg',
    ),
  ];

  test(
    'should call getExercises from repository and return SuccessResponse',
    () async {
      when(
        mockExercisesRepo.getExercises(
          primeMoverMuscleId: anyNamed('primeMoverMuscleId'),
          difficultyLevelId: anyNamed('difficultyLevelId'),
          page: anyNamed('page'),
        ),
      ).thenAnswer((_) async => SuccessResponse(data: tExercises));

      final result = await useCase.invoke(
        primeMoverMuscleId: tMuscleId,
        difficultyLevelId: tDifficultyId,
        page: tPage,
      );

      expect(result, SuccessResponse(data: tExercises));
      verify(
        mockExercisesRepo.getExercises(
          primeMoverMuscleId: tMuscleId,
          difficultyLevelId: tDifficultyId,
          page: tPage,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockExercisesRepo);
    },
  );

  test('should return FailureResponse when repository call fails', () async {
    const tError = 'Network Error';
    when(
      mockExercisesRepo.getExercises(
        primeMoverMuscleId: anyNamed('primeMoverMuscleId'),
        difficultyLevelId: anyNamed('difficultyLevelId'),
        page: anyNamed('page'),
      ),
    ).thenAnswer(
      (_) async => FailureResponse<List<ExerciseEntity>>(errorMessage: tError),
    );

    final result = await useCase.invoke(
      primeMoverMuscleId: tMuscleId,
      difficultyLevelId: tDifficultyId,
      page: tPage,
    );

    expect(result, isA<FailureResponse<List<ExerciseEntity>>>());
    expect((result as FailureResponse).errorMessage, tError);
    verify(
      mockExercisesRepo.getExercises(
        primeMoverMuscleId: tMuscleId,
        difficultyLevelId: tDifficultyId,
        page: tPage,
      ),
    ).called(1);
    verifyNoMoreInteractions(mockExercisesRepo);
  });
}
