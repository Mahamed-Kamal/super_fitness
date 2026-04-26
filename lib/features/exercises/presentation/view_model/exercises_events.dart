import 'package:equatable/equatable.dart';

sealed class ExercisesIntent {}

class GetExercisesIntent extends ExercisesIntent with EquatableMixin {
  final String primeMoverMuscleId;
  final String difficultyLevelId;
  final int page;

  GetExercisesIntent(
    this.primeMoverMuscleId,
    this.difficultyLevelId,
    this.page,
  );

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

class LoadMoreIntent extends ExercisesIntent {}

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
