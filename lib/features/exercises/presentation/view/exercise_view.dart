import 'package:flutter/material.dart';
import 'package:super_fitness/core/utils/assets_manager/assets_manager.dart';
import 'package:super_fitness/core/widgets/screen_backdrop.dart';
import 'package:super_fitness/features/exercises/presentation/widgets/exercises_list.dart';
import 'package:super_fitness/features/exercises/presentation/widgets/exercises_view_top_part.dart';

class ExerciseView extends StatelessWidget {
  const ExerciseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackdrop(
        image: AssetsManager.homeBackground,
        child: Column(
          children: [
            ExercisesViewTopPart(),
            SizedBox(height: 20),
            // ExercisesList(),
          ],
        ),
      ),
    );
  }
}
