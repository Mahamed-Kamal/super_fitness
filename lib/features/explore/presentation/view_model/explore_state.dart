import 'package:equatable/equatable.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/features/explore/domain/entities/explore_section.dart';
import 'package:super_fitness/features/explore/domain/entities/special_muscles_response_entity.dart';

class ExploreState extends Equatable {
  final List<BaseState<ExploreSection>> exploreData;
  final BaseState<SpecialMusclesResponseEntity> specialMuscles;
  final int index;
  const ExploreState({
    required this.specialMuscles,
    required this.exploreData,
    required this.index,
  });

  ExploreState copyWith({
    List<BaseState<ExploreSection>>? exploreData,
    int? index,
    BaseState<SpecialMusclesResponseEntity>? specialMuscles,
  }) => ExploreState(
    exploreData: exploreData ?? this.exploreData,
    index: index ?? this.index,
    specialMuscles: specialMuscles ?? this.specialMuscles,
  );

  @override
  List<Object?> get props => [exploreData, specialMuscles, index];
}

sealed class ExploreIntent {}

class LoadDataEvent extends ExploreIntent {}

class LoadSpecialMuscles extends ExploreIntent {
  final String id;
  LoadSpecialMuscles({required this.id});
}

class UpdateIndexMuscles extends ExploreIntent {
  final int currentIndex;
  UpdateIndexMuscles({required this.currentIndex});
}

class SeeAllFoodRecommendationIntent extends ExploreIntent {}

sealed class ExploreEvents {}

class NavigateToFoodRecommendation extends ExploreEvents {}
