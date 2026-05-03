import 'package:flutter/material.dart';
import 'package:super_fitness/core/utils/assets_manager/assets_manager.dart';
import 'package:super_fitness/core/widgets/screen_backdrop.dart';
import 'package:super_fitness/features/exercises/presentation/widgets/exercises_view_bottom_part.dart';
import 'package:super_fitness/features/exercises/presentation/widgets/exercises_view_top_part.dart';
import 'package:super_fitness/features/explore/domain/entities/muscles_entity.dart';

class ExerciseView extends StatelessWidget {
  const ExerciseView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as MusclesEntity;
    return Scaffold(
      body: ScreenBackdrop(
        image: AssetsManager.homeBackground,
        child: Column(
          children: [
            ExercisesViewTopPart(muscle: args),
            SizedBox(height: 20),
            Expanded(
              child: ExercisesViewBottomPart(primeMoverMuscleId: args.id ?? ''),
            ),
          ],
        ),
      ),
    );
  }
}
