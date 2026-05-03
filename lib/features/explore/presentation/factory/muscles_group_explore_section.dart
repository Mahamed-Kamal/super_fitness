import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/core/di/di.dart';
import 'package:super_fitness/features/app_section/view_model/app_section_view_model.dart';
import 'package:super_fitness/features/explore/domain/entities/explore_section.dart';
import 'package:super_fitness/features/explore/domain/entities/muscles_entity.dart';
import 'package:super_fitness/features/explore/presentation/factory/explore_section_factory.dart';
import 'package:super_fitness/features/explore/presentation/widgets/section_widget.dart';
import 'package:super_fitness/features/explore/presentation/widgets/upcoming_workouts.dart';

class MusclesGroupExploreSection
    extends ExploreSectionFactory<MusclesGroupSection> {
  @override
  Widget buildErrorUI(BaseState<MusclesGroupSection> data) {
    return Center(
      child: Text(data.errorMessage ?? 'errors.something_went_wrong'.tr()),
    );
  }

  @override
  Widget buildLoadingUI(BaseState<MusclesGroupSection> data) {
    return _buildLoadingState();
  }

  @override
  Widget buildSuccessUI(BaseState<MusclesGroupSection> data) {
    return SectionWidget(
      title: "explore.upcoming_workouts",
      widget: UpcomingWorkout(musclesGroup: data.data?.musclesGroup ?? []),
      onTap: () {
        getIt.get<AppSectionViewModel>().doIntent(2);
      },
    );
  }

  final _fakeDataMuscles = List.filled(
    10,
    MusclesGroupEntity(id: '', name: 'xxxxxx'),
  );
  Skeletonizer _buildLoadingState() => Skeletonizer(
    enabled: true,
    child: UpcomingWorkout(musclesGroup: _fakeDataMuscles),
  );
}
