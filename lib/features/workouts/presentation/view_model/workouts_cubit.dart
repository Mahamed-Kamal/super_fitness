import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/workouts/domain/use_cases/get_all_muscles_by_muscles_groups_use_case.dart';
import 'package:super_fitness/features/workouts/domain/use_cases/get_all_muscles_groups_use_case.dart';
import 'package:super_fitness/features/workouts/presentation/view_model/workouts_events.dart';
import 'package:super_fitness/features/workouts/presentation/view_model/workouts_states.dart';

import '../../../explore/domain/entities/muscles_entity.dart';

@injectable
class WorkoutsCubit extends Cubit<WorkoutsStates> {
  final GetAllMusclesByMusclesGroupsUseCase
  _getAllMusclesByMusclesGroupsUseCase;
  final GetAllMusclesGroupsUseCase _getAllMusclesGroupsUseCase;

  WorkoutsCubit(
    this._getAllMusclesByMusclesGroupsUseCase,
    this._getAllMusclesGroupsUseCase,
  ) : super(const WorkoutsStates());

  final StreamController<WorkoutsUiEvent> _workoutsUiEvents =
      StreamController.broadcast();

  Stream<WorkoutsUiEvent> get workoutsUiEvent => _workoutsUiEvents.stream;

  void doIntent(WorkoutsEvents event) {
    switch (event) {
      case GetAllMusclesByMusclesGroupEvents():
        _getAllProductsByWorkouts(event.groupId);
      case GetAllMusclesGroupsEvents():
        _getAllMusclesGroups();
    }
  }

  void doEvent(WorkoutsUiEvent event) {
    switch (event) {
      case NavigateToExerciseViewEvent():
        _workoutsUiEvents.add(
          NavigateToExerciseViewEvent(musclesEntity: event.musclesEntity),
        );
    }
  }

  Future<void> _getAllProductsByWorkouts(String? groupId) async {
    emit(
      state.copyWith(
        allMusclesByMusclesGroupsID: const BaseState<List<MusclesEntity>>(
          requestState: RequestState.loading,
        ),
      ),
    );
    Result<List<MusclesEntity>> response =
        await _getAllMusclesByMusclesGroupsUseCase(groupId!);
    switch (response) {
      case SuccessResponse<List<MusclesEntity>>():
        {
          emit(
            state.copyWith(
              allMusclesByMusclesGroupsID:
                  BaseState<List<MusclesEntity>>.loaded(response.data),
            ),
          );
        }

      case FailureResponse<List<MusclesEntity>>():
        {
          emit(
            state.copyWith(
              allMusclesByMusclesGroupsID: BaseState<List<MusclesEntity>>.error(
                response.errorMessage,
              ),
            ),
          );
        }
    }
  }

  Future<void> _getAllMusclesGroups() async {
    emit(
      state.copyWith(
        allMusclesGroups: const BaseState<List<MusclesGroupEntity>>(
          requestState: RequestState.loading,
        ),
      ),
    );
    Result<List<MusclesGroupEntity>> response =
        await _getAllMusclesGroupsUseCase();
    switch (response) {
      case SuccessResponse<List<MusclesGroupEntity>>():
        {
          emit(
            state.copyWith(
              allMusclesGroups: BaseState<List<MusclesGroupEntity>>.loaded(
                response.data,
              ),
            ),
          );
        }

      case FailureResponse<List<MusclesGroupEntity>>():
        {
          emit(
            state.copyWith(
              allMusclesGroups: BaseState<List<MusclesGroupEntity>>.error(
                response.errorMessage,
              ),
            ),
          );
        }
    }
  }
}
