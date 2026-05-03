import 'package:equatable/equatable.dart';
import 'package:super_fitness/core/bloc/base_state.dart';

import '../../../explore/domain/entities/muscles_entity.dart';

class WorkoutsStates extends Equatable {
  final BaseState<List<MusclesEntity>>? allMusclesByMusclesGroupsID;
  final BaseState<List<MusclesGroupEntity>>? allMusclesGroups;

  const WorkoutsStates({
    this.allMusclesByMusclesGroupsID,
    this.allMusclesGroups,
  });

  @override
  List<Object?> get props => [allMusclesByMusclesGroupsID, allMusclesGroups];

  WorkoutsStates copyWith({
    BaseState<List<MusclesEntity>>? allMusclesByMusclesGroupsID,
    BaseState<List<MusclesGroupEntity>>? allMusclesGroups,
  }) {
    return WorkoutsStates(
      allMusclesByMusclesGroupsID:
          allMusclesByMusclesGroupsID ?? this.allMusclesByMusclesGroupsID,
      allMusclesGroups: allMusclesGroups ?? this.allMusclesGroups,
    );
  }
}
