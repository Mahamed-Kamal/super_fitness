import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/utils/assets_manager/assets_manager.dart';
import 'package:super_fitness/core/widgets/screen_backdrop.dart';
import 'package:super_fitness/features/exercises/presentation/view_model/exercises_events.dart';
import 'package:super_fitness/features/exercises/presentation/view_model/exercises_view_model.dart';
import 'package:super_fitness/features/exercises/presentation/widgets/exercises_view_bottom_part.dart';
import 'package:super_fitness/features/exercises/presentation/widgets/exercises_view_top_part.dart';

class ExerciseView extends StatefulWidget {
  const ExerciseView({super.key});

  @override
  State<ExerciseView> createState() => _ExerciseViewState();
}

class _ExerciseViewState extends State<ExerciseView> {
  late ExercisesViewModel _viewModel;
  @override
  void initState() {
    _viewModel = context.read<ExercisesViewModel>();

    _viewModel.doIntent(
      GetExercisesIntent(
        primeMoverMuscleId: '69d982ef85f6bfa972bf2248',
        difficultyLevelId: _viewModel.state.selectedDifficultyId ?? '',
        page: 1,
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackdrop(
        image: AssetsManager.homeBackground,
        child: Column(
          children: [
            ExercisesViewTopPart(),
            SizedBox(height: 20),
            Expanded(child: ExercisesViewBottomPart(viewModel: _viewModel)),
          ],
        ),
      ),
    );
  }
}
