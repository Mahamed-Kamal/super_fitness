import 'package:flutter/material.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';

class CoreBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double iconSize;
  const CoreBackButton({super.key, this.onPressed, this.iconSize = 16});

  @override
  Widget build(BuildContext context) {
    final primary = context.appTheme.primary;
    return Center(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed ?? () => Navigator.maybePop(context),
          child: Ink(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: primary, shape: BoxShape.circle),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
