import 'package:flutter/material.dart';

class ScreenImageBackground extends StatelessWidget {
  const ScreenImageBackground({
    super.key,
    required this.child,
    required this.imagePath,
    this.appBar,
  });

  final Widget child;
  final String imagePath;
  final PreferredSizeWidget? appBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
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
