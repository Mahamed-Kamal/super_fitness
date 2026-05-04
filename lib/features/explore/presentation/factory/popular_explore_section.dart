import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/features/explore/domain/entities/explore_section.dart';
import 'package:super_fitness/features/explore/presentation/factory/explore_section_factory.dart';
import 'package:super_fitness/features/explore/presentation/widgets/popular_training_widget.dart';
import 'package:super_fitness/features/explore/presentation/widgets/section_widget.dart';

class PopularExploreSection extends ExploreSectionFactory<PopularSection> {
  @override
  Widget buildErrorUI(BaseState<PopularSection> data) {
    return Center(
      child: Text(data.errorMessage ?? 'errors.something_went_wrong'.tr()),
    );
  }

  @override
  Widget buildLoadingUI(BaseState<PopularSection> data) {
    return Center(child: CircularProgressIndicator());
  }

  @override
  Widget buildSuccessUI(BaseState<PopularSection> data) {
    if (data.data == null || data.data!.popularLevels.exercise.isEmpty) {
      return SizedBox.shrink();
    }
    return SectionWidget(
      title: "explore.popular_training",
      widget: InkWell(
        child: PopularTrainingCard(
          popularLevels: data.data!.popularLevels,
          imageUrl:
              data.data!.popularLevels.exercise[data.data!.index].story ?? '',
        ),
      ),
    );
  }
}
