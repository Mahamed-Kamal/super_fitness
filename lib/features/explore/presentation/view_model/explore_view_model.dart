import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/bloc/base_cubit.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/explore/domain/entities/exercises_response_entity.dart';
import 'package:super_fitness/features/explore/domain/entities/explore_section.dart';
import 'package:super_fitness/features/explore/domain/entities/special_muscles_response_entity.dart';
import 'package:super_fitness/features/explore/domain/usecase/explore_use_case.dart';
import 'package:super_fitness/features/explore/domain/usecase/get_popular_training_use_case.dart';
import 'package:super_fitness/features/explore/domain/usecase/get_spesical_muscles_use_case.dart';
import 'package:super_fitness/features/explore/presentation/view_model/explore_state.dart';

@singleton
class ExploreViewModel
    extends BaseCubit<ExploreState, ExploreIntent, ExploreEvents> {
  final ExploreUseCase _exploreUseCase;
  final GetSpecificMusclesGroup _getSpecificMusclesGroup;
  final GetPopularTrainingUseCase _getPopularTrainingUseCase;
  ExploreViewModel(
    this._exploreUseCase,
    this._getSpecificMusclesGroup,
    this._getPopularTrainingUseCase,
  ) : super(
        ExploreState(
          exploreData: [
            BaseState<MusclesRandomSection>.init(),
            BaseState<MusclesGroupSection>.init(),
            BaseState<CategoriesSection>.init(),
            BaseState<PopularSection>.init(),
          ],
          specialMuscles: BaseState<SpecialMusclesResponseEntity>.init(),
          index: 0,
        ),
      );

  void loadPopular() {
    _getPopularTrainingUseCase.call();
  }

  @override
  void doIntent(intent) {
    switch (intent) {
      case LoadDataEvent():
        _loadData();

      case SeeAllFoodRecommendationIntent():
        _navigateToFoodRecommendation();
      case LoadSpecialMuscles():
        _loadSpecialMuscles(intent.id);
      case UpdateIndexMuscles():
        _updateIndex(intent.currentIndex);
      case GoToPrimeExerciseIntent():
        _navigateToExercise();
    }
  }

  void _navigateToFoodRecommendation() {
    emitEvent(NavigateToFoodRecommendation());
  }

  void _navigateToExercise() {
    emitEvent(NavigateToFoodRecommendation());
  }

  void _updateIndex(int index) {
    emit(state.copyWith(index: index));
  }

  Future<void> _loadSpecialMuscles(String index) async {
    emit(state.copyWith(specialMuscles: BaseState.loading()));
    final response = await _getSpecificMusclesGroup.call(id: index);
    switch (response) {
      case SuccessResponse<SpecialMusclesResponseEntity>():
        emit(state.copyWith(specialMuscles: BaseState.loaded(response.data)));
      case FailureResponse<SpecialMusclesResponseEntity>():
        emit(
          state.copyWith(
            specialMuscles: BaseState.error(response.errorMessage),
          ),
        );
    }
  }

  Future<void> _loadData() async {
    if (state.exploreData.any(
      (element) => element.isLoaded || element.isLoading,
    )) {
      return;
    }
    emit(
      state.copyWith(
        exploreData: [
          BaseState<MusclesRandomSection>.loadingWithData(
            data: MusclesRandomSection([], 0),
          ),
          BaseState<MusclesGroupSection>.loadingWithData(
            data: MusclesGroupSection([], 1),
          ),
          BaseState<CategoriesSection>.loadingWithData(
            data: CategoriesSection([], 2),
          ),
          BaseState<PopularSection>.loadingWithData(
            data: PopularSection(
              ExercisesResponseEntity(exercise: [], tasks: 0),
              3,
            ),
          ),
        ],
      ),
    );
    var response = await _exploreUseCase.getExploreData();
    List<BaseState<ExploreSection>> exploreSection = [];
    for (var section in response) {
      switch (section) {
        case SuccessResponse<ExploreSection>():
          {
            switch (section.data) {
              case MusclesRandomSection():
                exploreSection.add(
                  BaseState.loaded(section.data as MusclesRandomSection),
                );
              case MusclesGroupSection():
                final data = section.data as MusclesGroupSection;
                exploreSection.add(BaseState.loaded(data));
                final currentIndex = state.index;
                final id = data.musclesGroup[currentIndex].id;
                if (id != null) {
                  _loadSpecialMuscles(id);
                }
              case CategoriesSection():
                exploreSection.add(
                  BaseState.loaded(section.data as CategoriesSection),
                );
              case PopularSection():
                exploreSection.add(
                  BaseState.loaded(section.data as PopularSection),
                );
            }
          }
        case FailureResponse<ExploreSection>():
          {
            exploreSection.add(BaseState.error(section.errorMessage));
          }
      }
    }
    emit(state.copyWith(exploreData: exploreSection));
  }
}
