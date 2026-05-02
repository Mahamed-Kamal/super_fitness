import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/exercises/domain/entity/difficulty_levels_entity.dart';
import 'package:super_fitness/features/exercises/domain/entity/exercises_entity.dart';
import 'package:super_fitness/features/exercises/domain/use_case/get_difficulty_levels_use_case.dart';
import 'package:super_fitness/features/exercises/domain/use_case/get_exercises_use_case.dart';
import 'package:super_fitness/features/exercises/presentation/view_model/exercises_events.dart';
import 'package:super_fitness/features/exercises/presentation/view_model/exercises_state.dart';
import 'package:super_fitness/features/exercises/presentation/view_model/exercises_view_model.dart';
import 'exercises_view_model_test.mocks.dart';

@GenerateMocks([GetDifficultyLevelsUseCase, GetExercisesUseCase])
void main() {
  late ExercisesViewModel viewModel;
  late MockGetDifficultyLevelsUseCase mockGetDifficultyLevelsUseCase;
  late MockGetExercisesUseCase mockGetExercisesUseCase;
  setUpAll(() {
    provideDummy<Result<List<DifficultyLevelsEntity>>>(
      SuccessResponse(data: []),
    );
    provideDummy<Result<List<ExerciseEntity>>>(SuccessResponse(data: []));
  });
  setUp(() {
    mockGetDifficultyLevelsUseCase = MockGetDifficultyLevelsUseCase();
    mockGetExercisesUseCase = MockGetExercisesUseCase();
    viewModel = ExercisesViewModel(
      mockGetDifficultyLevelsUseCase,
      mockGetExercisesUseCase,
    );
  });

  const tMuscleId = '69d982ef85f6bfa972bf2248';
  final tDifficultyLevels = [
    const DifficultyLevelsEntity(id: '1', name: 'Beginner'),
  ];
  final tExercises = [
    ExerciseEntity(
      id: '1',
      exercise: 'Push Up',
      muscle: '',
      equipment: '',
      difficulty: '',
      thumbnailUrl: '',
    ),
  ];

  group('GetDifficultyLevelsIntent', () {
    blocTest<ExercisesViewModel, ExercisesState>(
      'should emit loading then loaded and trigger getExercises when successful',
      build: () {
        when(
          mockGetDifficultyLevelsUseCase.invoke(primeMoverMuscleId: tMuscleId),
        ).thenAnswer((_) async => SuccessResponse(data: tDifficultyLevels));
        when(
          mockGetExercisesUseCase.invoke(
            primeMoverMuscleId: anyNamed('primeMoverMuscleId'),
            difficultyLevelId: anyNamed('difficultyLevelId'),
            page: anyNamed('page'),
          ),
        ).thenAnswer((_) async => SuccessResponse(data: tExercises));
        return viewModel;
      },
      act: (vm) => vm.doIntent(GetDifficultyLevelsIntent(tMuscleId)),
      expect: () => [
        isA<ExercisesState>().having(
          (s) => s.difficultyLevelsState?.isLoading,
          'loading',
          true,
        ),
        isA<ExercisesState>()
            .having(
              (s) => s.difficultyLevelsState?.data,
              'data',
              tDifficultyLevels,
            )
            .having((s) => s.selectedDifficultyId, 'selectedId', '1'),
        isA<ExercisesState>().having(
          (s) => s.exercisesState?.isLoading,
          'exercises loading',
          true,
        ),
        isA<ExercisesState>().having(
          (s) => s.exercisesState?.data,
          'exercises data',
          tExercises,
        ),
      ],
    );

    blocTest<ExercisesViewModel, ExercisesState>(
      'should emit error when fetching difficulty levels fails',
      build: () {
        when(
          mockGetDifficultyLevelsUseCase.invoke(primeMoverMuscleId: tMuscleId),
        ).thenAnswer((_) async => FailureResponse(errorMessage: 'Error'));
        return viewModel;
      },
      act: (vm) => vm.doIntent(GetDifficultyLevelsIntent(tMuscleId)),
      expect: () => [
        isA<ExercisesState>().having(
          (s) => s.difficultyLevelsState?.isLoading,
          'loading',
          true,
        ),
        isA<ExercisesState>().having(
          (s) => s.difficultyLevelsState?.errorMessage,
          'error',
          'Error',
        ),
      ],
    );
  });

  group('LoadMoreIntent', () {
    blocTest<ExercisesViewModel, ExercisesState>(
      'should append data and increment page when load more is called',
      build: () {
        when(
          mockGetExercisesUseCase.invoke(
            primeMoverMuscleId: anyNamed('primeMoverMuscleId'),
            difficultyLevelId: anyNamed('difficultyLevelId'),
            page: 2,
          ),
        ).thenAnswer((_) async => SuccessResponse(data: tExercises));
        return viewModel;
      },
      seed: () => ExercisesState(
        exercisesState: BaseState.loaded([
          ExerciseEntity(
            id: '0',
            exercise: 'Old',
            muscle: '',
            equipment: '',
            difficulty: '',
            thumbnailUrl: '',
          ),
        ]),
        currentPage: 1,
        selectedDifficultyId: '1',
      ),
      act: (vm) => vm.doIntent(LoadMoreIntent(tMuscleId)),
      expect: () => [
        isA<ExercisesState>()
            .having((s) => s.exercisesState?.data?.length, 'length', 2)
            .having((s) => s.currentPage, 'page', 2),
      ],
    );

    blocTest<ExercisesViewModel, ExercisesState>(
      'should not trigger loading if hasReachedMax is true',
      build: () => viewModel,
      seed: () => ExercisesState(
        exercisesState: BaseState.loaded([]),
        hasReachedMax: true,
      ),
      act: (vm) => vm.doIntent(LoadMoreIntent(tMuscleId)),
      expect: () => [],
    );
  });
}
