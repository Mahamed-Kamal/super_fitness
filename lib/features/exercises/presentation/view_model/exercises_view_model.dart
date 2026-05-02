import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/core/bloc/base_view_model.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/exercises/domain/entity/difficulty_levels_entity.dart';
import 'package:super_fitness/features/exercises/domain/entity/exercises_entity.dart';
import 'package:super_fitness/features/exercises/domain/use_case/get_difficulty_levels_use_case.dart';
import 'package:super_fitness/features/exercises/domain/use_case/get_exercises_use_case.dart';
import 'package:super_fitness/features/exercises/presentation/view_model/exercises_events.dart';
import 'package:super_fitness/features/exercises/presentation/view_model/exercises_state.dart';

@injectable
class ExercisesViewModel
    extends BaseViewModel<ExercisesState, ExercisesIntent, ExercisesEvent> {
  final GetDifficultyLevelsUseCase _getDifficultyLevelsUseCase;
  final GetExercisesUseCase _getExercisesUseCase;

  ExercisesViewModel(
    this._getDifficultyLevelsUseCase,
    this._getExercisesUseCase,
  ) : super(
        ExercisesState(
          difficultyLevelsState: BaseState.init(),
          exercisesState: BaseState.init(),
        ),
      );

  @override
  void doIntent(intent) {
    switch (intent) {
      case GetExercisesIntent():
        _getExercises(
          primeMoverMuscleId: intent.primeMoverMuscleId,
          difficultyLevelId: intent.difficultyLevelId,
          page: intent.page,
        );

      case GetDifficultyLevelsIntent():
        _getDifficultyLevels(intent.muscleId);
      case GetNextPageIntent():
        _nextPage();
      case LoadMoreIntent():
        _loadMore('69d982ef85f6bfa972bf2248');
      case ChangeDifficultyLevelIntent():
        _changeDifficulty(
          difficultyId: intent.difficultyId,
          muscleId: intent.muscleId,
        );
    }
  }

  void _getDifficultyLevels(String primeMoverMuscleId) async {
    emit(state.copyWith(difficultyLevelsState: BaseState.loading()));
    var response = await _getDifficultyLevelsUseCase.invoke(
      primeMoverMuscleId: primeMoverMuscleId,
    );
    switch (response) {
      case SuccessResponse<List<DifficultyLevelsEntity>>():
        final firstLevelId = response.data.isNotEmpty
            ? response.data[0].id
            : '';
        {
          emit(
            state.copyWith(
              difficultyLevelsState: BaseState.loaded(response.data),
              selectedDifficultyId: firstLevelId,
            ),
          );
          if (firstLevelId!.isNotEmpty) {
            _getExercises(
              primeMoverMuscleId: primeMoverMuscleId,
              difficultyLevelId: firstLevelId,
              page: 1,
            );
          }
        }
      case FailureResponse<List<DifficultyLevelsEntity>>():
        {
          emit(
            state.copyWith(
              difficultyLevelsState: BaseState.error(response.errorMessage),
            ),
          );
        }
    }
  }

  void _getExercises({
    required String primeMoverMuscleId,
    required String difficultyLevelId,
    required int page,
  }) async {
    if (page == 1) {
      emit(
        state.copyWith(
          exercisesState: BaseState.loading(),
          hasReachedMax: false,
        ),
      );
    }

    var response = await _getExercisesUseCase.invoke(
      primeMoverMuscleId: primeMoverMuscleId,
      difficultyLevelId: difficultyLevelId,
      page: page,
    );

    switch (response) {
      case SuccessResponse<List<ExerciseEntity>>():
        {
          List<ExerciseEntity> currentList = [];

          if (page > 1 && state.exercisesState?.data != null) {
            currentList = List.from(state.exercisesState!.data!);
            currentList.addAll(response.data);
          } else {
            currentList = response.data;
          }

          emit(
            state.copyWith(
              exercisesState: BaseState.loaded(currentList),
              currentPage: page,
              hasReachedMax: response.data.length < 10,
            ),
          );
        }
      case FailureResponse<List<ExerciseEntity>>():
        {
          emit(
            state.copyWith(
              exercisesState: BaseState.error(response.errorMessage),
            ),
          );
        }
    }
  }

  void _changeDifficulty({
    required String difficultyId,
    required String muscleId,
  }) {
    if (state.selectedDifficultyId == difficultyId) return;

    emit(
      state.copyWith(
        selectedDifficultyId: difficultyId,
        currentPage: state.currentPage,
      ),
    );

    doIntent(
      GetExercisesIntent(
        difficultyLevelId: difficultyId,
        primeMoverMuscleId: muscleId,
        page: state.currentPage,
      ),
    );
  }

  void _nextPage() => emit(state.copyWith(currentPage: state.currentPage + 1));

  void _loadMore(String muscleId) {
    if (state.exercisesState!.isLoading || state.hasReachedMax) return;

    final nextPage = state.currentPage + 1;

    _getExercises(
      primeMoverMuscleId: muscleId,
      difficultyLevelId: state.selectedDifficultyId ?? '',
      page: nextPage,
    );
  }
}
