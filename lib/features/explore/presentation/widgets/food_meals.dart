import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness/core/widgets/glass_container.dart';
import 'package:super_fitness/features/explore/domain/entities/categories_entity.dart';

class FoodMeals extends StatelessWidget {
  const FoodMeals({super.key, required this.foodCategories});
  final List<CategoriesEntity> foodCategories;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 104,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemCount: foodCategories.length,
        itemBuilder: (context, index) {
          if (foodCategories.isEmpty) {
            return const SizedBox.shrink();
          }
          return Container(
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
                    imageUrl: foodCategories[index].strCategoryThumb ?? '',
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
                        foodCategories[index].strCategory ??
                            "errors.notFound".tr(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
