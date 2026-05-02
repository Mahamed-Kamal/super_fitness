import 'package:flutter/material.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';

class MainProfileItem extends StatelessWidget {
  final Widget? prefix;
  final Widget? suffix;
  final String title;
  final VoidCallback? onTap;

  const MainProfileItem({
    super.key,
    required this.title,
    required this.onTap,
    this.prefix,
    this.suffix = const Icon(Icons.navigate_next_rounded, size: 24),
  });

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          prefix ?? const SizedBox.shrink(),
          prefix != null ? const SizedBox(width: 4) : const SizedBox.shrink(),
          Text(title, style: context.appTheme.semiBold18),
          const Spacer(),
          suffix ??
              const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFFFF4500),
                size: 16,
              ),
        ],
      ),
    ),
  );
}
