import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/widgets/lottie_error.dart';
import 'package:super_fitness/features/exercises/presentation/view_model/exercises_events.dart';
import 'package:super_fitness/features/exercises/presentation/view_model/exercises_state.dart';
import 'package:super_fitness/features/exercises/presentation/view_model/exercises_view_model.dart';
import 'package:super_fitness/features/exercises/presentation/widgets/exercises_list.dart';

class ExercisesViewBottomPart extends StatelessWidget {
  const ExercisesViewBottomPart({super.key, required this.viewModel});

  final ExercisesViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExercisesViewModel, ExercisesState>(
      builder: (context, state) {
        if (state.exercisesState!.isError) {
          return LottieError(
            message: state.exercisesState?.errorMessage ?? "",
            onRetry: () => context.read<ExercisesViewModel>().doIntent(
              GetExercisesIntent(
                primeMoverMuscleId: '69d982ef85f6bfa972bf2248',
                difficultyLevelId: state.selectedDifficultyId ?? '',
                page: state.currentPage,
              ),
            ),
          );
        } else if (state.exercisesState!.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.exercisesState!.isLoaded) {
          final exercises = state.exercisesState!.data!;
          return NotificationListener(
            onNotification: (notification) {
              if (notification is ScrollEndNotification &&
                  notification.metrics.pixels ==
                      notification.metrics.maxScrollExtent - 200) {
                context.read<ExercisesViewModel>().doIntent(
                  LoadMoreIntent('69d982ef85f6bfa972bf2248'),
                );
              }
              return true;
            },
            child: ExercisesList(exercises: exercises),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
