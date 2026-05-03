import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/core/di/di.dart';
import 'package:super_fitness/features/explore/domain/entities/explore_section.dart';
import 'package:super_fitness/features/explore/presentation/factory/explore_section_factory.dart';
import 'package:super_fitness/features/explore/presentation/view_model/explore_state.dart';
import 'package:super_fitness/features/explore/presentation/view_model/explore_view_model.dart';
import 'package:super_fitness/features/explore/presentation/widgets/food_meals.dart';
import 'package:super_fitness/features/explore/presentation/widgets/section_widget.dart';
import '../../domain/entities/categories_entity.dart';

class CategoriesExploreSection
    extends ExploreSectionFactory<CategoriesSection> {
  @override
  Widget buildErrorUI(BaseState<CategoriesSection> data) {
    return Center(
      child: Text(data.errorMessage ?? 'errors.something_went_wrong'.tr()),
    );
  }

  @override
  Widget buildLoadingUI(BaseState<CategoriesSection> data) {
    return _buildLoadingState();
  }

  @override
  Widget buildSuccessUI(BaseState<CategoriesSection> data) {
    return SectionWidget(
      title: 'explore.food_recommendation',
      widget: FoodMeals(foodCategories: data.data?.categories ?? []),
      onTap: () {
        getIt.get<ExploreViewModel>().doIntent(
          SeeAllFoodRecommendationIntent(),
        );
      },
    );
  }

  final _fakeCategories = List.filled(
    7,
    CategoriesEntity(
      idCategory: '',
      strCategory: '',
      strCategoryDescription: '',
      strCategoryThumb: '',
    ),
  );
  Skeletonizer _buildLoadingState() => Skeletonizer(
    enabled: true,
    child: FoodMeals(foodCategories: _fakeCategories),
  );
}
