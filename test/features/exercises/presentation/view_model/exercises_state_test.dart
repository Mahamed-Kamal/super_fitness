import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/features/exercises/presentation/view_model/exercises_state.dart';

void main() {
  group('ExercisesState Tests', () {
    test('supports value equality (Equatable)', () {
      expect(const ExercisesState(), const ExercisesState());
    });

    test('props should contain all fields', () {
      const state = ExercisesState(
        currentPage: 1,
        hasReachedMax: false,
        selectedDifficultyId: '1',
      );

      expect(state.props, [
        null, // difficultyLevelsState
        null, // exercisesState
        1, // currentPage
        false, // hasReachedMax
        '1', // selectedDifficultyId
      ]);
    });

    test('copyWith should return a new object with updated values', () {
      const state = ExercisesState(currentPage: 1);
      final updatedState = state.copyWith(currentPage: 2, hasReachedMax: true);

      expect(updatedState.currentPage, 2);
      expect(updatedState.hasReachedMax, true);
      expect(updatedState.difficultyLevelsState, state.difficultyLevelsState);
    });

    test('copyWith should keep old values when parameters are null', () {
      const state = ExercisesState(currentPage: 5, selectedDifficultyId: 'abc');
      final updatedState = state.copyWith();

      expect(updatedState, state);
    });
  });
}
