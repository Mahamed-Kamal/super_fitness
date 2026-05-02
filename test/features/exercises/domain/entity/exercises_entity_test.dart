import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/features/exercises/domain/entity/exercises_entity.dart';

void main() {
  group('ExerciseEntity Tests', () {
    test('should support value equality', () {
      const entity1 = ExerciseEntity(
        id: '1',
        exercise: 'Push Up',
        muscle: 'Chest',
        equipment: 'Bodyweight',
        difficulty: 'Beginner',
        thumbnailUrl: 'url',
      );
      const entity2 = ExerciseEntity(
        id: '1',
        exercise: 'Push Up',
        muscle: 'Chest',
        equipment: 'Bodyweight',
        difficulty: 'Beginner',
        thumbnailUrl: 'url',
      );

      expect(entity1, entity2);
    });

    test('props should contain all fields', () {
      const entity = ExerciseEntity(
        id: '1',
        exercise: 'Push Up',
        videoUrl: 'v_url',
        muscle: 'Chest',
        equipment: 'Bodyweight',
        difficulty: 'Beginner',
        thumbnailUrl: 't_url',
      );

      expect(entity.props, [
        '1',
        'Push Up',
        'v_url',
        'Chest',
        'Bodyweight',
        'Beginner',
        't_url',
      ]);
    });
  });
}
