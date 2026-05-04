import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/core/widgets/glass_container.dart';
import 'package:super_fitness/features/explore/domain/entities/exercises_response_entity.dart';

class PopularTrainingCard extends StatelessWidget {
  const PopularTrainingCard({
    super.key,
    required this.popularLevels,
    required this.imageUrl,
  });
  final ExercisesResponseEntity popularLevels;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Container(
      width: 200,
      height: 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: CachedNetworkImageProvider(imageUrl),
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            popularLevels.exercise[0].name,
            style: theme.semiBold16,
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GlassContainer(
                padding: EdgeInsets.all(8),
                child: Text(
                  "${popularLevels.tasks} tasks",
                  style: theme.semiBold12.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              GlassContainer(
                padding: EdgeInsets.all(8),
                child: Text(
                  popularLevels.exercise[0].level,
                  style: theme.semiBold12.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
