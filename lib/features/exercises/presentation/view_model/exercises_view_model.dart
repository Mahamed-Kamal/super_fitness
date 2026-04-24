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
        throw UnimplementedError();
      case GetDifficultyLevelsIntent():
        _getDifficultyLevels(intent.muscleId);
      case GetNextPageIntent():
        // TODO: Handle this case.
        throw UnimplementedError();
      case LoadMoreIntent():
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  void _getDifficultyLevels(String primeMoverMuscleId) async {
    emit(state.copyWith(difficultyLevelsState: BaseState.loading()));
    var response = await _getDifficultyLevelsUseCase.invoke(
      primeMoverMuscleId: primeMoverMuscleId,
    );
    switch (response) {
      case SuccessResponse<List<DifficultyLevelsEntity>>():
        {
          emit(
            state.copyWith(
              difficultyLevelsState: BaseState.loaded(response.data),
            ),
          );
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
    emit(state.copyWith(exercisesState: BaseState.loading()));
    var response = await _getExercisesUseCase.invoke(
      primeMoverMuscleId: primeMoverMuscleId,
      difficultyLevelId: difficultyLevelId,
      page: page,
    );
    switch (response) {
      case SuccessResponse<List<ExerciseEntity>>():
        {
          emit(state.copyWith(exercisesState: BaseState.loaded(response.data)));
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
}
