import 'package:equatable/equatable.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/features/meals/domain/entities/meal_entity.dart';

class MealDetailsState extends BaseState<List<MealEntity>> with EquatableMixin {
  const MealDetailsState({
    required super.requestState,
    super.errorMessage,
    super.data,
  });

  factory MealDetailsState.init() =>
      const MealDetailsState(requestState: RequestState.init);

  factory MealDetailsState.loading() =>
      MealDetailsState(requestState: RequestState.loading);

  factory MealDetailsState.loaded(List<MealEntity> data) =>
      MealDetailsState(requestState: RequestState.loaded, data: data);

  factory MealDetailsState.error(String message) =>
      MealDetailsState(requestState: RequestState.error, errorMessage: message);

  MealDetailsState copyWith({
    RequestState? requestState,
    String? errorMessage,
    List<MealEntity>? data,
  }) => MealDetailsState(
    requestState: requestState ?? this.requestState,
    errorMessage: errorMessage ?? this.errorMessage,
    data: data ?? this.data,
  );

  @override
  List<Object?> get props => [requestState, errorMessage, data];
}
