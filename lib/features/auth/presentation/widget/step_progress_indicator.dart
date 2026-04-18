import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';

class StepProgressIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const StepProgressIndicator({
    super.key,
    required this.currentStep,
    this.totalSteps = 6,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Transform.rotate(
              angle: -math.pi / 2,
              child: SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  value: currentStep == 1 ? 0 : currentStep / totalSteps,
                  strokeWidth: 4,

                  valueColor: AlwaysStoppedAnimation<Color>(
                    context.appTheme.primary,
                  ),
                ),
              ),
            ),

            Text(
              "$currentStep/$totalSteps",
              style: context.appTheme.regular16.copyWith(fontSize: 14),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
