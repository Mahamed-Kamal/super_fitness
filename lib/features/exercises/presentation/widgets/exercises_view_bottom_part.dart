import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:super_fitness/core/utils/assets_manager/assets_manager.dart';
import 'package:super_fitness/core/widgets/lottie_error.dart';
import 'package:super_fitness/features/exercises/presentation/view_model/exercises_events.dart';
import 'package:super_fitness/features/exercises/presentation/view_model/exercises_state.dart';
import 'package:super_fitness/features/exercises/presentation/view_model/exercises_view_model.dart';
import 'package:super_fitness/features/exercises/presentation/widgets/exercises_list.dart';
import 'package:super_fitness/features/exercises/presentation/widgets/exercises_list_content.dart';

class ExercisesViewBottomPart extends StatefulWidget {
  const ExercisesViewBottomPart({super.key, required this.primeMoverMuscleId});

  final String primeMoverMuscleId;

  @override
  State<ExercisesViewBottomPart> createState() =>
      _ExercisesViewBottomPartState();
}

class _ExercisesViewBottomPartState extends State<ExercisesViewBottomPart> {
  late ExercisesViewModel _viewModel;
  @override
  void initState() {
    super.initState();
    _viewModel = context.read<ExercisesViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExercisesViewModel, ExercisesState>(
      builder: (context, state) {
        if (state.exercisesState!.isInitial ||
            state.exercisesState!.isLoading) {
          return Skeletonizer(
            enabled: true,

            enableSwitchAnimation: true,
            effect: PulseEffect(),
            child: Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 1, bottom: 20),
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => ExercisesListContent(
                  index: index,
                  exercise: 'exercise'.tr(),
                  prime_equipment: 'prime_equipment'.tr(),
                  thumbnail: AssetsManager.placeholder,
                  videoUrl: '',
                  exercises: [],
                ),
                itemCount: 5,
              ),
            ),
          );
        } else if (state.exercisesState!.isError) {
          return LottieError(
            message: state.exercisesState?.errorMessage ?? "",
            onRetry: () => _viewModel.doIntent(
              GetExercisesIntent(
                primeMoverMuscleId: widget.primeMoverMuscleId,
                difficultyLevelId: state.selectedDifficultyId ?? '',
                page: 1,
              ),
            ),
          );
        } else if (state.exercisesState!.isLoaded) {
          final exercises = state.exercisesState!.data!;
          return NotificationListener(
            onNotification: (notification) {
              if (notification is ScrollEndNotification &&
                  notification.metrics.pixels >=
                      notification.metrics.maxScrollExtent - 100) {
                _viewModel.doIntent(LoadMoreIntent(widget.primeMoverMuscleId));
              }
              return true;
            },
            child: ExercisesList(exercises: exercises),
          );
        } else if (state.exercisesState!.data!.isEmpty) {
          return Center(child: Text('no_exercises'.tr()));
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
