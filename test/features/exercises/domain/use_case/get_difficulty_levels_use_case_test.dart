import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/exercises/domain/entity/difficulty_levels_entity.dart';
import 'package:super_fitness/features/exercises/domain/repo/exercises_repo.dart';
import 'package:super_fitness/features/exercises/domain/use_case/get_difficulty_levels_use_case.dart';
import 'get_difficulty_levels_use_case_test.mocks.dart';

@GenerateMocks([ExercisesRepo])
void main() {
  late GetDifficultyLevelsUseCase useCase;
  late MockExercisesRepo mockExercisesRepo;

  setUpAll(() {
    provideDummy<Result<List<DifficultyLevelsEntity>>>(
      SuccessResponse(data: []),
    );
  });

  setUp(() {
    mockExercisesRepo = MockExercisesRepo();
    useCase = GetDifficultyLevelsUseCase(mockExercisesRepo);
  });

  const tMuscleId = '69d982ef85f6bfa972bf2248';
  final tDifficultyLevels = [
    const DifficultyLevelsEntity(id: '1', name: 'Beginner'),
  ];

  test(
    'should call getDifficultyLevels from repository and return SuccessResponse',
    () async {
      when(
        mockExercisesRepo.getDifficultyLevels(
          primeMoverMuscleId: anyNamed('primeMoverMuscleId'),
        ),
      ).thenAnswer((_) async => SuccessResponse(data: tDifficultyLevels));

      final result = await useCase.invoke(primeMoverMuscleId: tMuscleId);

      expect(result, SuccessResponse(data: tDifficultyLevels));
      verify(
        mockExercisesRepo.getDifficultyLevels(primeMoverMuscleId: tMuscleId),
      ).called(1);
      verifyNoMoreInteractions(mockExercisesRepo);
    },
  );

  test('should return FailureResponse when repository call fails', () async {
    const tError = 'Server Error';

    when(
      mockExercisesRepo.getDifficultyLevels(
        primeMoverMuscleId: anyNamed('primeMoverMuscleId'),
      ),
    ).thenAnswer(
      (_) async =>
          FailureResponse<List<DifficultyLevelsEntity>>(errorMessage: tError),
    );

    final result = await useCase.invoke(primeMoverMuscleId: tMuscleId);

    expect(result, isA<FailureResponse<List<DifficultyLevelsEntity>>>());
    expect((result as FailureResponse).errorMessage, tError);

    verify(
      mockExercisesRepo.getDifficultyLevels(primeMoverMuscleId: tMuscleId),
    ).called(1);
    verifyNoMoreInteractions(mockExercisesRepo);
  });
}
