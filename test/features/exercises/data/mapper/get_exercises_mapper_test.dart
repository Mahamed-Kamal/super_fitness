import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/features/exercises/data/mapper/get_exercises_mapper.dart';
import 'package:super_fitness/features/exercises/data/models/exercises_dto.dart';

void main() {
  group('ExercisesMapper Tests', () {
    const tId = '123';
    const tExercise = 'Push Up';
    const tMuscle = 'Chest';
    const tEquipment = 'Bodyweight';
    const tDifficulty = 'Beginner';

    test(
      'should map ExercisesDTO to ExerciseEntity correctly with long YouTube URL',
      () {
        // Arrange
        const tVideoUrl = 'https://www.youtube.com/watch?v=op9scZ4J7p4';
        const expectedThumbnail =
            'https://img.youtube.com/vi/op9scZ4J7p4/0.jpg';

        final tDto = ExercisesDTO(
          id: tId,
          exercise: tExercise,
          primeMoverMuscle: tMuscle,
          primaryEquipment: tEquipment,
          difficultyLevel: tDifficulty,
          shortYoutubeDemonstrationLink: tVideoUrl,
        );

        // Act
        final result = tDto.toEntity();

        // Assert
        expect(result.id, tId);
        expect(result.videoUrl, tVideoUrl);
        expect(result.thumbnailUrl, expectedThumbnail);
      },
    );

    test('should map correctly when using short YouTube URL (youtu.be)', () {
      // Arrange
      const tVideoUrl = 'https://youtu.be/op9scZ4J7p4';
      const expectedThumbnail = 'https://img.youtube.com/vi/op9scZ4J7p4/0.jpg';

      final tDto = ExercisesDTO(
        id: tId,
        shortYoutubeDemonstrationLink: tVideoUrl,
      );

      // Act
      final result = tDto.toEntity();

      // Assert
      expect(result.thumbnailUrl, expectedThumbnail);
    });

    test('should return placeholder when URL is null', () {
      // Arrange
      final tDto = ExercisesDTO(id: tId, shortYoutubeDemonstrationLink: null);

      // Act
      final result = tDto.toEntity();

      // Assert
      expect(result.thumbnailUrl, "assets/images/placeholder.png");
    });

    test('should return placeholder when URL is empty or invalid', () {
      // Arrange
      final tDto = ExercisesDTO(id: tId, shortYoutubeDemonstrationLink: '');

      // Act
      final result = tDto.toEntity();

      // Assert
      expect(result.thumbnailUrl, "assets/images/placeholder.png");
    });
  });
}
