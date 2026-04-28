import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/features/exercises/presentation/view_model/exercises_events.dart';

void main() {
  group('ExercisesIntent and Event Tests', () {
    test('GetExercisesIntent equality', () {
      final intent1 = GetExercisesIntent(
        primeMoverMuscleId: '1',
        difficultyLevelId: '1',
        page: 1,
      );
      final intent2 = GetExercisesIntent(
        primeMoverMuscleId: '1',
        difficultyLevelId: '1',
        page: 1,
      );

      expect(intent1, intent2);
    });

    test('ChangeDifficultyLevelIntent equality', () {
      final intent1 = ChangeDifficultyLevelIntent('d1', 'm1');
      final intent2 = ChangeDifficultyLevelIntent('d1', 'm1');

      expect(intent1, intent2);
    });

    test('GetDifficultyLevelsIntent equality', () {
      final intent1 = GetDifficultyLevelsIntent('m1');
      final intent2 = GetDifficultyLevelsIntent('m1');

      expect(intent1, intent2);
    });

    test('LoadMoreIntent equality', () {
      final intent1 = LoadMoreIntent('m1');
      final intent2 = LoadMoreIntent('m1');

      expect(intent1, intent2);
    });

    test('OpenExerciseVideoEvent equality', () {
      final event1 = OpenExerciseVideoEvent('url');
      final event2 = OpenExerciseVideoEvent('url');

      expect(event1, event2);
    });
  });
}
