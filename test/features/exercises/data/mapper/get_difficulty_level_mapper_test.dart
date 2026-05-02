import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/features/exercises/data/mapper/get_difficulty_level_mapper.dart';
import 'package:super_fitness/features/exercises/data/models/difficulty_levels_dto.dart';
import 'package:super_fitness/features/exercises/domain/entity/difficulty_levels_entity.dart';

void main() {
  group('DifficultyLevelMapper Tests', () {
    test(
      'should map DifficultyLevelsDTO to DifficultyLevelsEntity correctly',
      () {
        // Arrange
        const tId = '69d982ef85f6bfa972bf2248';
        const tName = 'Beginner';

        final tDto = DifficultyLevelsDTO(id: tId, name: tName);

        // Act
        final result = tDto.toEntity();

        // Assert
        expect(result, isA<DifficultyLevelsEntity>());
        expect(result.id, tId);
        expect(result.name, tName);
      },
    );

    test('should handle null or empty values if applicable', () {
      // Arrange
      final tDto = DifficultyLevelsDTO(id: '', name: '');

      // Act
      final result = tDto.toEntity();

      // Assert
      expect(result.id, '');
      expect(result.name, '');
    });
  });
}
