import 'package:equatable/equatable.dart';

class ExerciseEntity extends Equatable {
  final String? id;
  final String? exercise;
  final String? videoUrl;
  final String? muscle;
  final String? equipment;
  final String? difficulty;
  final String? thumbnailUrl;

  const ExerciseEntity({
    required this.id,
    required this.exercise,
    this.videoUrl,
    required this.muscle,
    required this.equipment,
    required this.difficulty,
    required this.thumbnailUrl,
  });

  @override
  List<Object?> get props => [
    id,
    exercise,
    videoUrl,
    muscle,
    equipment,
    difficulty,
    thumbnailUrl,
  ];
}
