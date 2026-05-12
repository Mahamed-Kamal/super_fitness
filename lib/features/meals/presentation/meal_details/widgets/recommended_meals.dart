import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness/core/route_manager/app_routes.dart';
import 'package:super_fitness/core/widgets/glass_container.dart';
import 'package:super_fitness/features/meals/domain/entities/meal_entity.dart';

class RecommendedMeals extends StatelessWidget {
  const RecommendedMeals({super.key, required this.meals});

  final List<MealEntity> meals;

  @override
  Widget build(BuildContext context) {
    var randomMeals = getRandomMeals(meals);
    return SizedBox(
      height: 104,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemCount: randomMeals.length,
        itemBuilder: (context, index) {
          if (randomMeals.isEmpty) {
            return const SizedBox.shrink();
          }
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.mealDetails,
                arguments: [meals[index].id, meals],
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(20),
              ),
              width: 104,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: randomMeals[index].imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Center(
                        child: Row(
                          spacing: 5,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(child: Text("errors.unknown".tr())),
                            const Icon(Icons.error_outline),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: GlassContainer(
                      padding: const EdgeInsets.all(8),
                      bottomLeft: const Radius.circular(20),
                      bottomRight: const Radius.circular(20),
                      child: Center(
                        child: Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          randomMeals[index].title,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  List<MealEntity> getRandomMeals(List<MealEntity> meals, {int count = 5}) {
    if (meals.length <= count) return meals;

    final shuffled = List<MealEntity>.from(meals)..shuffle();
    return shuffled.take(count).toList();
  }
}
