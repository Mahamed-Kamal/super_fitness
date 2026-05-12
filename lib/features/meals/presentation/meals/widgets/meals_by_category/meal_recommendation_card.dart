import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/features/meals/domain/entities/meal_entity.dart';

class MealRecommendationCard extends StatelessWidget {
  const MealRecommendationCard({
    super.key,
    required this.meal,
    required this.onTap,
  });

  final MealEntity meal;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (meal.imageUrl.isNotEmpty)
              CachedNetworkImage(
                imageUrl: meal.imageUrl,
                fit: BoxFit.cover,
                errorWidget: (_, _, _) => ColoredBox(
                  color: context.appTheme.neutral[800]!,
                  child: Icon(
                    Icons.restaurant,
                    color: context.appTheme.onBackground.withValues(alpha: 0.4),
                    size: 40,
                  ),
                ),
                placeholder: (_, _) =>
                    ColoredBox(color: context.appTheme.neutral[800]!),
              )
            else
              ColoredBox(color: context.appTheme.neutral[800]!),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.7),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 12),
                  child: Text(
                    meal.title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.appTheme.semiBold12.copyWith(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
