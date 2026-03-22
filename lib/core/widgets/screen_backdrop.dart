import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:super_fitness/core/widgets/custom_image_view.dart';

class ScreenBackdrop extends StatelessWidget {
  final Widget child;
  final String image;
  const ScreenBackdrop({super.key, required this.child, required this.image});
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: CustomImageView(
            imagePath: image,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
        ),
        Container(color: const Color(0x1A1A1A80)),
        child,
      ],
    );
  }
}
