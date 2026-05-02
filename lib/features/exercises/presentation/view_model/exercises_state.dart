import 'package:equatable/equatable.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/features/exercises/domain/entity/difficulty_levels_entity.dart';
import 'package:super_fitness/features/exercises/domain/entity/exercises_entity.dart';

class ExercisesState extends Equatable {
  final BaseState<List<DifficultyLevelsEntity>>? difficultyLevelsState;
  final BaseState<List<ExerciseEntity>>? exercisesState;
  final int currentPage;
  final bool hasReachedMax;
  final String? selectedDifficultyId;

  const ExercisesState({
    this.difficultyLevelsState,
    this.exercisesState,
    this.currentPage = 1,
    this.hasReachedMax = false,
    this.selectedDifficultyId,
  });

  ExercisesState copyWith({
    BaseState<List<DifficultyLevelsEntity>>? difficultyLevelsState,
    BaseState<List<ExerciseEntity>>? exercisesState,
    int? currentPage,
    bool? hasReachedMax,
    String? selectedDifficultyId,
  }) {
    return ExercisesState(
      difficultyLevelsState:
          difficultyLevelsState ?? this.difficultyLevelsState,
      exercisesState: exercisesState ?? this.exercisesState,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      selectedDifficultyId: selectedDifficultyId ?? this.selectedDifficultyId,
    );
  }

  @override
  List<Object?> get props => [
    difficultyLevelsState,
    exercisesState,
    currentPage,
    hasReachedMax,
    selectedDifficultyId,
  ];
}
