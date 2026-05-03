import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/di/di.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/core/route_manager/app_routes.dart';
import 'package:super_fitness/core/utils/assets_manager/assets_manager.dart';
import 'package:super_fitness/core/widgets/screen_image_background.dart';
import 'package:super_fitness/features/explore/domain/entities/muscles_entity.dart';
import 'package:super_fitness/features/workouts/presentation/view_model/workouts_cubit.dart';
import 'package:super_fitness/features/workouts/presentation/view_model/workouts_events.dart';
import '../../../../core/bloc/base_state.dart';
import '../view_model/workouts_states.dart';

class WorkoutsView extends StatefulWidget {
  const WorkoutsView({super.key});

  @override
  State<WorkoutsView> createState() => _WorkoutsViewState();
}

class _WorkoutsViewState extends State<WorkoutsView> {
  final workoutsCubit = getIt.get<WorkoutsCubit>();
  late List<MusclesGroupEntity> musclesGroups;
  @override
  void initState() {
    super.initState();
    workoutsCubit.workoutsUiEvent.listen((event) {
      switch (event) {
        case NavigateToExerciseViewEvent():
          {
            if (!mounted) return;
            Navigator.pushNamed(
              context,
              AppRoutes.exercise,
              arguments: event.musclesEntity,
            );
          }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenImageBackground(
      imagePath: AssetsManager.exploreBg,
      appBar: AppBar(
        title: Text(
          "workouts.Workouts".tr(),
          style: context.appTheme.semiBold24,
        ).tr(),
      ),
      child: BlocProvider<WorkoutsCubit>(
        create: (context) =>
            workoutsCubit..doIntent(GetAllMusclesGroupsEvents()),
        child: BlocBuilder<WorkoutsCubit, WorkoutsStates>(
          builder: (context, state) {
            if (state.allMusclesGroups?.requestState == RequestState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.allMusclesGroups?.requestState ==
                RequestState.error) {
              return Center(
                child: Text(state.allMusclesGroups?.errorMessage ?? ""),
              );
            } else {
              musclesGroups = state.allMusclesGroups?.data ?? [];
              if (musclesGroups.isNotEmpty &&
                  state.allMusclesByMusclesGroupsID == null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.read<WorkoutsCubit>().doIntent(
                    GetAllMusclesByMusclesGroupEvents(
                      groupId: musclesGroups.first.id!,
                    ),
                  );
                });
              }
              return Column(
                children: [
                  SizedBox(height: 124),
                  DefaultTabController(
                    length: musclesGroups.length,
                    child: Builder(
                      builder: (context) {
                        return TabBar(
                          dividerColor: Colors.transparent,
                          indicator: BoxDecoration(
                            color: context.appTheme.primary,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),

                          isScrollable: true,
                          tabs: musclesGroups
                              .map(
                                (occasions) => Tab(
                                  child: Text(
                                    occasions.name ?? "untitled".tr(),
                                    style: context.appTheme.semiBold12,
                                  ),
                                ),
                              )
                              .toList(),
                          onTap: (index) {
                            final selectedMuscles = musclesGroups[index];
                            context.read<WorkoutsCubit>().doIntent(
                              GetAllMusclesByMusclesGroupEvents(
                                groupId: selectedMuscles.id ?? "",
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  BlocBuilder<WorkoutsCubit, WorkoutsStates>(
                    builder: (context, state) {
                      if (state.allMusclesByMusclesGroupsID?.errorMessage !=
                              null &&
                          state
                              .allMusclesByMusclesGroupsID!
                              .errorMessage!
                              .isNotEmpty) {
                        return Text(
                          state.allMusclesByMusclesGroupsID!.errorMessage!,
                        );
                      } else if (!(state
                                  .allMusclesByMusclesGroupsID
                                  ?.isLoading ??
                              false) &&
                          state.allMusclesByMusclesGroupsID?.data != null &&
                          state.allMusclesByMusclesGroupsID!.data!.isNotEmpty) {
                        final products =
                            state.allMusclesByMusclesGroupsID?.data ?? [];
                        if (products.isEmpty) {
                          return Center(
                            child: Text(
                              "There is no Muscles yet",
                              style: context.appTheme.medium20,
                            ).tr(),
                          );
                        }
                        return Expanded(
                          child: GridView.builder(
                            padding: const EdgeInsets.all(12),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 160,
                                  crossAxisCount: 2,
                                  childAspectRatio: 1,
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 16,
                                ),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              final musclesGroups =
                                  state.allMusclesByMusclesGroupsID?.data ?? [];

                              final muscle = musclesGroups[index];
                              return InkWell(
                                onTap: () {
                                  workoutsCubit.doEvent(
                                    NavigateToExerciseViewEvent(
                                      musclesEntity: muscle,
                                    ),
                                  );
                                },

                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: Stack(
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        height: 250,
                                        child: Image.network(
                                          muscle.image ??
                                              "https://img.youm7.com/ArticleImgs/2018/11/29/41524-%D8%B9%D8%B6%D9%84%D8%A7%D8%AA-%D8%A7%D9%84%D8%AC%D8%B3%D9%85.jpg",
                                          fit: BoxFit.cover,
                                        ),
                                      ),

                                      Container(
                                        width: double.infinity,
                                        height: 250,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.black.withValues(
                                                alpha: 0.2,
                                              ),
                                              Colors.black.withValues(
                                                alpha: 0.4,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      Positioned(
                                        bottom: 20,
                                        left: 20,
                                        right: 30,
                                        child: Text(
                                          muscle.name ?? "",
                                          style: context.appTheme.semiBold24,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount:
                                state.allMusclesByMusclesGroupsID!.data!.length,
                          ),
                        );
                      } else if (!(state
                                  .allMusclesByMusclesGroupsID
                                  ?.isLoading ??
                              false) &&
                          state.allMusclesByMusclesGroupsID?.data != null &&
                          state.allMusclesByMusclesGroupsID!.data!.isEmpty) {
                        return Text(
                          "There is no muscles yet",
                          style: context.appTheme.medium20,
                        ).tr();
                      } else {
                        return Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 50,
                                width: 50,
                                child: const CircularProgressIndicator(),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
