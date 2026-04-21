import 'package:flutter/material.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';

class UpcomingWorkout extends StatelessWidget {
  const UpcomingWorkout({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return SizedBox(
      height: 30,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemCount: 9,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
            color: index == 0 ? theme.primary : theme.neutral,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.all(8),
          child: Text(
            "full Body",
            style: theme.semiBold12.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
