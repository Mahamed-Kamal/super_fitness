import 'package:super_fitness/features/workouts/domain/entity/muscles_entity.dart';

sealed class WorkoutsEvents {}

sealed class WorkoutsUiEvent {}

class GetAllMusclesByMusclesGroupEvents extends WorkoutsEvents {
  final String groupId;

  GetAllMusclesByMusclesGroupEvents({required this.groupId});
}

class GetAllMusclesGroupsEvents extends WorkoutsEvents {}

class NavigateToExerciseViewEvent extends WorkoutsUiEvent {
  MusclesEntity musclesEntity;

  NavigateToExerciseViewEvent({required this.musclesEntity});
}
