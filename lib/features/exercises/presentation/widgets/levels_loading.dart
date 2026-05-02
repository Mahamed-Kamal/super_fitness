import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LevelsLoading extends StatelessWidget {
  const LevelsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.only(right: 15, top: 7, bottom: 7),
          width: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
