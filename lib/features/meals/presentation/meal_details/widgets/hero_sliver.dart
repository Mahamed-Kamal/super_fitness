import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/features/meals/domain/entities/meal_entity.dart';

import 'placeholder_hero.dart';

class HeroSliver extends StatelessWidget {
  final MealEntity meal;
  final double heroHeight;

  const HeroSliver({super.key, required this.meal, required this.heroHeight});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: heroHeight,
      pinned: false,
      stretch: true,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.zoomBackground],
        background: Stack(
          fit: StackFit.expand,
          children: [
            if (meal.image.isNotEmpty)
              Image.network(
                meal.image,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const PlaceholderHero(),
              )
            else
              const PlaceholderHero(),

            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.45, 1.0],
                  colors: [
                    Colors.black.withValues(alpha: 0.25),
                    Colors.transparent,
                    Colors.black,
                  ],
                ),
              ),
            ),

            Positioned(
              left: 20,
              right: 20,
              bottom: 24,
              child: Text(
                meal.title.isEmpty ? 'untitled_meal'.tr() : meal.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: context.appTheme.semiBold24.copyWith(
                  height: 1.2,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  shadows: [
                    Shadow(
                      blurRadius: 8,
                      color: Colors.black54,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
