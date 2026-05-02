import 'package:flutter/material.dart';

class ScreenImageBackground extends StatelessWidget {
  const ScreenImageBackground({
    super.key,
    required this.child,
    required this.imagePath,
    this.appBar,
    this.drawer,
  });

  final Widget child;
  final String imagePath;
  final PreferredSizeWidget? appBar;
  final Widget? drawer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      endDrawer: drawer,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(imagePath, fit: BoxFit.cover),
          child,
        ],
      ),
    );
  }
}
