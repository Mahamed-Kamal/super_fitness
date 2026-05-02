import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/features/explore/domain/entities/muscles_entity.dart';
import 'package:super_fitness/features/explore/presentation/view_model/explore_state.dart';
import 'package:super_fitness/features/explore/presentation/view_model/explore_view_model.dart';
import 'package:super_fitness/features/explore/presentation/widgets/recommendation_today.dart';

class UpcomingWorkout extends StatelessWidget {
  const UpcomingWorkout({super.key, required this.musclesGroup});
  final List<MusclesGroupEntity> musclesGroup;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Column(
      spacing: 8,
      children: [
        SizedBox(
          height: 30,
          child: BlocConsumer<ExploreViewModel, ExploreState>(
            listener: (context, state) => state.index,
            buildWhen: (previous, current) => previous.index != current.index,
            builder: (context, state) {
              return ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemCount: musclesGroup.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    final id = musclesGroup[state.index].id ?? '';

                    context.read<ExploreViewModel>().doIntent(
                      UpdateIndexMuscles(currentIndex: index),
                    );
                    context.read<ExploreViewModel>().doIntent(
                      LoadSpecialMuscles(id: id),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: state.index == index
                          ? theme.primary
                          : Colors.white12,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Text(
                      musclesGroup[index].name ?? '',
                      style: theme.semiBold12.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        BlocBuilder<ExploreViewModel, ExploreState>(
          builder: (context, state) {
            switch (state.specialMuscles.requestState) {
              case RequestState.init:
              case RequestState.loading:
                return _buildLoadingState();
              case RequestState.loaded:
                return RecommendationToDay(
                  muscles: state.specialMuscles.data?.muscles ?? [],
                );
              case RequestState.error:
                return Text(state.specialMuscles.errorMessage ?? '');
            }
          },
        ),
      ],
    );
  }

  Skeletonizer _buildLoadingState() {
    final fakeMuscles = List.filled(10, MusclesEntity(id: '', name: 'xxxxxx'));
    return Skeletonizer(
      enabled: true,
      child: RecommendationToDay(muscles: fakeMuscles),
    );
  }
}
