import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/core/utils/assets_manager/assets_manager.dart';
import 'package:super_fitness/core/widgets/custom_image_view.dart';
import 'package:super_fitness/core/widgets/lottie_error.dart';
import 'package:super_fitness/core/widgets/super_fitness_app_bar.dart';
import 'package:super_fitness/features/exercises/presentation/view_model/exercises_events.dart';
import 'package:super_fitness/features/exercises/presentation/view_model/exercises_state.dart';
import 'package:super_fitness/features/exercises/presentation/view_model/exercises_view_model.dart';
import 'package:super_fitness/features/exercises/presentation/widgets/difficulty_levels_list.dart';
import 'package:super_fitness/features/exercises/presentation/widgets/min_and_cal_container.dart';

class ExercisesViewTopPart extends StatelessWidget {
  const ExercisesViewTopPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomImageView(
          imagePath: 'https://iili.io/33p7LoF.png',
          width: double.infinity,
          height: 350,
          fit: BoxFit.cover,
          placeHolder: AssetsManager.placeholder,
          radius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),

        Positioned(
          bottom: 60,
          left: 0,
          right: 0,
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, context.appTheme.neutral],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 60,
          left: 5,
          right: 5,
          child: Row(
            children: [
              MinAndCalContainer(
                text: "30 Min",
                color: context.appTheme.textMuted,
              ),
              Spacer(),
              MinAndCalContainer(
                text: "130 Cal",
                color: context.appTheme.primary,
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,

          child: SuperFitnessAppBar(
            showBack: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.appTheme.primary,
                ),
                child: SvgPicture.asset(AssetsManager.icBackSvg),
              ),
            ),
          ),
        ),

        Positioned(
          bottom: 100,
          left: 20,
          right: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Calf exercises",
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: context.appTheme.neutral,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: BlocBuilder<ExercisesViewModel, ExercisesState>(
              bloc: context.read<ExercisesViewModel>()
                ..doIntent(
                  GetDifficultyLevelsIntent("69d982ef85f6bfa972bf2248"),
                ),
              builder: (context, state) {
                if (state.difficultyLevelsState!.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.difficultyLevelsState!.isError) {
                  return InkWell(
                    onTap: () => context.read<ExercisesViewModel>().doIntent(
                      GetDifficultyLevelsIntent("69d982ef85f6bfa972bf2248"),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.refresh,
                            color: context.appTheme.primary,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Retry",
                            style: TextStyle(color: context.appTheme.primary),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (state.difficultyLevelsState!.isLoaded) {
                  final difficultyLevels =
                      state.difficultyLevelsState?.data ?? [];

                  return DifficultyLevelsList(
                    levels: difficultyLevels,
                    muscleId: "69d982ef85f6bfa972bf2248",
                    selectedId: state.selectedDifficultyId,
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
