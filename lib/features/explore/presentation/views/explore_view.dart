import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/core/route_manager/app_routes.dart';
import 'package:super_fitness/core/utils/assets_manager/assets_manager.dart';
import 'package:super_fitness/core/widgets/screen_image_background.dart';
import 'package:super_fitness/features/explore/domain/entities/explore_section.dart';
import 'package:super_fitness/features/explore/presentation/factory/categories_explore_section.dart';
import 'package:super_fitness/features/explore/presentation/factory/muscles_explore_section.dart';
import 'package:super_fitness/features/explore/presentation/factory/muscles_group_explore_section.dart';
import 'package:super_fitness/features/explore/presentation/factory/popular_explore_section.dart';
import 'package:super_fitness/features/explore/presentation/view_model/explore_state.dart';
import 'package:super_fitness/features/explore/presentation/view_model/explore_view_model.dart';
import 'package:super_fitness/features/explore/presentation/widgets/section_widget.dart';
import '../../../profile/presentation/view_model/profile_states.dart';
import '../../../profile/presentation/view_model/profile_view_model.dart';
import '../widgets/fitness_categories.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  late final StreamSubscription _exploreEvents;
  @override
  void initState() {
    _exploreEvents = context.read<ExploreViewModel>().eventStream.listen((
      event,
    ) {
      if (event is NavigateToFoodRecommendation && mounted) {
        Navigator.of(context).pushNamed(AppRoutes.meals);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _exploreEvents.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenImageBackground(
      imagePath: AssetsManager.exploreBg,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 32),
            BlocBuilder<ProfileViewModel, ProfileStates>(
              builder: (context, state) {
                final user = state.userData?.data;
                if (user != null) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text("explore.hi".tr()+ user.firstName),
                    subtitle: Text("explore.start_your_day".tr()),
                    trailing: CircleAvatar(
                      foregroundImage: NetworkImage(user.profilePicture),
                    ),
                  );
                }
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text("explore.hi".tr()),
                  subtitle: Text("explore.start_your_day".tr()),
                  trailing: CircleAvatar(),
                );
              },
            ),
            const SizedBox(height: 24),
            SectionWidget(
              title: "explore.category".tr(),
              widget: const FitnessCategories(),
            ),
            Expanded(
              child: BlocBuilder<ExploreViewModel, ExploreState>(
                builder: (context, state) {
                  return ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return switch (state.exploreData[index].data) {
                        null => const CircularProgressIndicator(),
                        MusclesRandomSection() =>
                          MusclesExploreSection().buildUI(
                            switch (state.exploreData[index].requestState) {
                                  RequestState.init =>
                                    BaseState<MusclesRandomSection>.init(),
                                  RequestState.loading =>
                                    BaseState<MusclesRandomSection>.loading(),
                                  RequestState.loaded =>
                                    BaseState<MusclesRandomSection>.loaded(
                                      state.exploreData[index].data
                                          as MusclesRandomSection,
                                    ),
                                  RequestState.error =>
                                    BaseState<MusclesExploreSection>.error(
                                      state.exploreData[index].errorMessage!,
                                    ),
                                }
                                as BaseState<MusclesRandomSection>,
                          ),
                        MusclesGroupSection() =>
                          MusclesGroupExploreSection().buildUI(
                            switch (state.exploreData[index].requestState) {
                              RequestState.init =>
                                BaseState<MusclesGroupSection>.init(),

                              RequestState.loading =>
                                BaseState<MusclesGroupSection>.loading(),

                              RequestState.loaded =>
                                BaseState<MusclesGroupSection>.loaded(
                                  state.exploreData[index].data
                                      as MusclesGroupSection,
                                ),
                              RequestState.error =>
                                BaseState<MusclesGroupSection>.error(
                                  state.exploreData[index].errorMessage!,
                                ),
                            },
                          ),
                        CategoriesSection() =>
                          CategoriesExploreSection().buildUI(
                            switch (state.exploreData[index].requestState) {
                              RequestState.init =>
                                BaseState<CategoriesSection>.init(),

                              RequestState.loading =>
                                BaseState<CategoriesSection>.loading(),

                              RequestState.loaded =>
                                BaseState<CategoriesSection>.loaded(
                                  state.exploreData[index].data
                                      as CategoriesSection,
                                ),
                              RequestState.error =>
                                BaseState<CategoriesSection>.error(
                                  state.exploreData[index].errorMessage!,
                                ),
                            },
                          ),

                        PopularSection() => PopularExploreSection().buildUI(
                          switch (state.exploreData[index].requestState) {
                            RequestState.init =>
                              BaseState<PopularSection>.init(),

                            RequestState.loading =>
                              BaseState<PopularSection>.loading(),

                            RequestState.loaded =>
                              BaseState<PopularSection>.loaded(
                                state.exploreData[index].data as PopularSection,
                              ),
                            RequestState.error =>
                              BaseState<PopularSection>.error(
                                state.exploreData[index].errorMessage!,
                              ),
                          },
                        ),
                      };
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 24),
                    itemCount: state.exploreData.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
