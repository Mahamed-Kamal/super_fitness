import 'package:flutter/material.dart';
import 'package:super_fitness/features/exercises/presentation/widgets/exercises_list_content.dart';

class ExercisesList extends StatelessWidget {
  const ExercisesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 1, bottom: 100),
        physics: const BouncingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) {
          return ExercisesListContent(
            index: index,
            exercise: '',
            prime_equipment: '',
            thumbnail: '',
          );
        },
      ),
    );
  }
}
