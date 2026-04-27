import 'package:equatable/equatable.dart';

sealed class ExercisesIntent {}

class GetExercisesIntent extends ExercisesIntent with EquatableMixin {
  final String primeMoverMuscleId;
  final String difficultyLevelId;
  final int page;

  GetExercisesIntent({
    required this.primeMoverMuscleId,
    required this.difficultyLevelId,
    required this.page,
  });

  @override
  List<Object?> get props => [difficultyLevelId, primeMoverMuscleId, page];
}

class ChangeDifficultyLevelIntent extends ExercisesIntent with EquatableMixin {
  final String difficultyId;
  final String muscleId;
  ChangeDifficultyLevelIntent(this.difficultyId, this.muscleId);

  @override
  List<Object?> get props => [difficultyId, muscleId];
}

class GetDifficultyLevelsIntent extends ExercisesIntent with EquatableMixin {
  final String muscleId;
  GetDifficultyLevelsIntent(this.muscleId);

  @override
  List<Object?> get props => [muscleId];
}

class GetNextPageIntent extends ExercisesIntent {}

class LoadMoreIntent extends ExercisesIntent with EquatableMixin {
  final String muscleId;
  LoadMoreIntent(this.muscleId);

  @override
  List<Object?> get props => [muscleId];
}

sealed class ExercisesEvent {}

class OpenExerciseVideoEvent extends ExercisesEvent with EquatableMixin {
  final String videoUrl;
  OpenExerciseVideoEvent(this.videoUrl);

  @override
  List<Object?> get props => [videoUrl];
}

class ChangeDifficultyLevelEvent extends ExercisesEvent {
  final String? difficultyLevelId;
  ChangeDifficultyLevelEvent({this.difficultyLevelId});
}

class NavigateToWorkoutEvent extends ExercisesEvent {}
