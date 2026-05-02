import 'package:flutter/material.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/core/utils/assets_manager/assets_manager.dart';

class GymComingSoonDialog extends StatelessWidget {
  const GymComingSoonDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    final theme = context.appTheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: theme.neutral,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            offset: const Offset(0, 10),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close, size: 20),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),

          // Enhanced Image Container
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: theme.primary.withValues(alpha: 0.2),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                AssetsManager.gymComingSoon,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 24),
          Text(
            "GYM EXPERIENCE",
            style: theme.regular14.copyWith(color: theme.primary),
          ),

          const SizedBox(height: 8),

          Text("Coming Soon", style: theme.semiBold24),

          const SizedBox(height: 12),

          Text(
            "We are working hard to bring the ultimate gym tracking experience to your fingertips.",
            textAlign: TextAlign.center,
            style: theme.regular14.copyWith(color: theme.inputOutline),
          ),
        ],
      ),
    );
  }
}
