import 'package:flutter/material.dart';
import 'package:super_fitness/core/utils/assets_manager/assets_manager.dart';
import 'package:super_fitness/core/widgets/glass_container.dart';

class RecommendationToDay extends StatelessWidget {
  const RecommendationToDay({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 104,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemCount: 5,
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetsManager.chatBackground),
              fit: BoxFit.cover,
            ),
            color: Colors.white12,
            borderRadius: BorderRadius.circular(20),
          ),
          width: 104,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: GlassContainer(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),

                  child: Center(child: Text("data")),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
