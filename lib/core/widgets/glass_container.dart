import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final Radius? bottomLeft;
  final Radius? bottomRight;
  final Radius? topLeft;
  final Radius? topRight;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  const GlassContainer({
    super.key,
    required this.child,
    this.bottomLeft,
    this.bottomRight,
    this.topLeft,
    this.topRight,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          borderRadius ??
          BorderRadius.only(
            bottomLeft: bottomLeft ?? Radius.circular(30),
            bottomRight: bottomRight ?? Radius.circular(30),
            topLeft: topLeft ?? Radius.circular(30),
            topRight: topRight ?? Radius.circular(30),
          ),
      clipBehavior: Clip.antiAlias,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 34, sigmaY: 34),
        child: Container(
          padding: padding ?? const EdgeInsets.all(20),
          decoration: BoxDecoration(color: context.appTheme.surfaceOverlayLow),
          child: child,
        ),
      ),
    );
  }
}
