import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_fitness/features/exercises/domain/entity/difficulty_levels_entity.dart';
import 'package:super_fitness/features/exercises/presentation/view_model/exercises_events.dart';
import 'package:super_fitness/features/exercises/presentation/view_model/exercises_view_model.dart';

class DifficultyLevelsList extends StatelessWidget {
  const DifficultyLevelsList({
    super.key,
    required this.levels,
    this.selectedId,
    required this.muscleId,
  });
  final List<DifficultyLevelsEntity> levels;
  final String? selectedId;
  final String muscleId;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      scrollDirection: Axis.horizontal,
      itemCount: levels.length,
      itemBuilder: (context, index) {
        final level = levels[index];

        final isSelected =
            level.id == selectedId || (selectedId == null && index == 0);
        return InkWell(
          onTap: () {
            if (level.id != selectedId) {
              context.read<ExercisesViewModel>().doIntent(
                ChangeDifficultyLevelIntent(level.id!, muscleId),
              );
            }
          },
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(right: 30, top: 7, bottom: 7),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: isSelected ? Colors.red : Colors.transparent,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              level.name ?? '',
              style: GoogleFonts.balooThambi2(
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ),
        );
      },
    );
  }
}
