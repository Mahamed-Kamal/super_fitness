import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/features/exercises/domain/entity/difficulty_levels_entity.dart';

void main() {
  group('DifficultyLevelsEntity Tests', () {
    test('should support value equality', () {
      // Arrange
      const entity1 = DifficultyLevelsEntity(id: '1', name: 'Easy');
      const entity2 = DifficultyLevelsEntity(id: '1', name: 'Easy');

      // Assert
      expect(entity1, entity2);
    });

    test('props should contain id and name', () {
      // Arrange
      const entity = DifficultyLevelsEntity(id: '1', name: 'Easy');

      // Assert
      expect(entity.props, ['1', 'Easy']);
    });
  });
}
