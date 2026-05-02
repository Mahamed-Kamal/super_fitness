import 'package:flutter/material.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';

class CollapsedAppBar extends StatelessWidget {
  final String title;

  const CollapsedAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 56,
        right: 56,
        bottom: 12,
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: context.appTheme.semiBold24.copyWith(
          height: 1.2,
          fontSize: 16,
          fontWeight: FontWeight.w800,
          shadows: [
            Shadow(blurRadius: 8, color: Colors.black54, offset: Offset(0, 2)),
          ],
        ),
      ),
    );
  }
}
