import 'package:flutter/material.dart';
import 'package:super_fitness/core/utils/assets_manager/assets_manager.dart';
import 'package:super_fitness/features/exercises/domain/entity/exercises_entity.dart';
import 'package:super_fitness/features/exercises/presentation/widgets/exercises_list_content.dart';

class ExercisesList extends StatelessWidget {
  const ExercisesList({super.key, required this.exercises});
  final List<ExerciseEntity> exercises;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 1, bottom: 20),
      physics: const BouncingScrollPhysics(),
      itemCount: exercises.length,
      itemBuilder: (context, index) {
        return ExercisesListContent(
          exercises: exercises,
          index: index,
          exercise: exercises[index].exercise ?? '',
          primeEquipment: exercises[index].equipment ?? '',
          thumbnail: exercises[index].thumbnailUrl ?? AssetsManager.placeholder,
          videoUrl: exercises[index].videoUrl ?? '',
        );
      },
    );
  }
}
