import 'package:flutter/material.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';

class SectionWidget extends StatelessWidget {
  final String title;
  final Widget widget;
  final void Function()? onTap;

  const SectionWidget({
    super.key,
    required this.title,
    required this.widget,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: theme.semiBold16),
            if (onTap != null)
              GestureDetector(
                onTap: onTap,
                child: Text(
                  "See All",
                  style: theme.regular14.copyWith(
                    decoration: TextDecoration.underline,
                    color: theme.primary,
                    decorationColor: theme.primary,
                  ),
                ),
              ),
          ],
        ),
        widget,
      ],
    );
  }
}
