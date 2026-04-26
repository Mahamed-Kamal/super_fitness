import 'package:equatable/equatable.dart';

class ExercisesResponseEntity extends Equatable {
  final List<ExerciseEntity> exercise;
  final int tasks;

  const ExercisesResponseEntity({required this.exercise, required this.tasks});

  @override
  List<Object?> get props => [exercise, tasks];
}

class ExerciseEntity extends Equatable {
  final String name;
  final String level;
  final String? story;

  const ExerciseEntity({
    required this.name,
    required this.level,
    required this.story,
  });

  @override
  List<Object?> get props => [name, level, story];
}
