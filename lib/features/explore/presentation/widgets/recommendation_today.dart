import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness/core/widgets/glass_container.dart';
import 'package:super_fitness/features/explore/domain/entities/muscles_entity.dart';

import '../../../../core/route_manager/app_routes.dart';

class RecommendationToDay extends StatelessWidget {
  const RecommendationToDay({super.key, required this.muscles});
  final List<MusclesEntity> muscles;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 104,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemCount: muscles.length,
        itemBuilder: (context, index) {
          if (muscles.isEmpty) {
            return SizedBox.shrink();
          }
          return GestureDetector(
            onTap: () {
              Navigator.of(
                context,
              ).pushNamed(AppRoutes.exercise, arguments: muscles[index]);
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
                      imageUrl: muscles[index].image ?? '',
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Center(
                        child: Row(
                          spacing: 5,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text("Error"), Icon(Icons.error_outline)],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: GlassContainer(
                      padding: EdgeInsets.all(8),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),

                      child: Center(
                        child: Text(
                          maxLines: 1,

                          overflow: TextOverflow.ellipsis,
                          muscles[index].name ?? "Not Found",
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
}
