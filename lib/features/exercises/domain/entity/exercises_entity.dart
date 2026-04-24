class ExerciseEntity {
  final String? id;
  final String? exercise;
  final String? videoUrl;
  final String? muscle;
  final String? equipment;
  final String? difficulty;
  final String? thumbnailUrl;

  ExerciseEntity({
    required this.id,
    required this.exercise,
    this.videoUrl,
    required this.muscle,
    required this.equipment,
    required this.difficulty,
    required this.thumbnailUrl,
  });
}
