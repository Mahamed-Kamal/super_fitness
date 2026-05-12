import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/features/meals/domain/entities/meal_entity.dart';

import 'placeholder_hero.dart';

class HeroSliver extends StatelessWidget {
  final MealEntity meal;
  final double heroHeight;
  final Widget? player;

  const HeroSliver({
    super.key,
    required this.meal,
    required this.heroHeight,
    this.player,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final playerHeight = screenWidth * 9 / 16;

    return SliverToBoxAdapter(
      child: SizedBox(
        height: heroHeight,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (player != null)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: playerHeight,
                child: player!,
              )
            else if (meal.imageUrl.isNotEmpty)
              Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const PlaceholderHero(),
              )
            else
              const PlaceholderHero(),

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
                  shadows: const [
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
