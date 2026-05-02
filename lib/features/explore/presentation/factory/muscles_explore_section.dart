import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/features/explore/domain/entities/explore_section.dart';
import 'package:super_fitness/features/explore/domain/entities/muscles_entity.dart';
import 'package:super_fitness/features/explore/presentation/factory/explore_section_factory.dart';
import 'package:super_fitness/features/explore/presentation/widgets/recommendation_today.dart';
import 'package:super_fitness/features/explore/presentation/widgets/section_widget.dart';

class MusclesExploreSection
    extends ExploreSectionFactory<MusclesRandomSection> {
  @override
  Widget buildErrorUI(BaseState<MusclesRandomSection> data) {
    return Center(
      child: Text(data.errorMessage ?? 'errors.something_went_wrong'.tr()),
    );
  }

  @override
  Widget buildLoadingUI(BaseState<MusclesRandomSection> data) {
    return _buildLoadingState();
  }

  @override
  Widget buildSuccessUI(BaseState<MusclesRandomSection> data) {
    return SectionWidget(
      title: "explore.recommendation_to_day".tr(),
      widget: RecommendationToDay(muscles: data.data?.muscles ?? []),
    );
  }

  final _fakeDataMuscles = List.filled(
    7,
    MusclesEntity(id: '', name: 'xxxxxx', image: ''),
  );
  Skeletonizer _buildLoadingState() => Skeletonizer(
    enabled: true,
    child: RecommendationToDay(muscles: _fakeDataMuscles),
  );
}
