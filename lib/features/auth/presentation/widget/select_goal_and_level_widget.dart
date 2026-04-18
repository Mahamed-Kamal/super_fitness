import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';

class SelectGoalAndLevelWidget extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectGoalAndLevelWidget({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: isSelected
                      ? context.appTheme.primary
                      : context.appTheme.textMuted,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title.toUpperCase(),
                      style: context.appTheme.semiBold12,
                    ),
                  ),

                  // الـ Custom Radio Circle
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? context.appTheme.primary
                            : context.appTheme.textMuted,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: isSelected ? 10 : 0,
                        height: isSelected ? 10 : 0,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? context.appTheme.primary
                              : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
