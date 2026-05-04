import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';

class StepProgressIndicator extends StatefulWidget {
  final int currentStep;
  final int totalSteps;

  const StepProgressIndicator({
    super.key,
    required this.currentStep,
    this.totalSteps = 6,
  });

  @override
  State<StepProgressIndicator> createState() => _StepProgressIndicatorState();
}

class _StepProgressIndicatorState extends State<StepProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _previousValue = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    final targetValue = widget.currentStep == 1
        ? 0.0
        : widget.currentStep / widget.totalSteps;

    _animation = Tween<double>(
      begin: 0,
      end: targetValue,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _previousValue = targetValue;
    _controller.forward();
  }

  @override
  void didUpdateWidget(StepProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentStep != widget.currentStep) {
      final targetValue = widget.currentStep == 1
          ? 0.0
          : widget.currentStep / widget.totalSteps;

      _animation = Tween<double>(
        begin: _previousValue,
        end: targetValue,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

      _previousValue = targetValue;
      _controller
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return CircularProgressIndicator(
                      value: _animation.value,
                      strokeWidth: 4,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        context.appTheme.primary,
                      ),
                    );
                  },
                ),
              ),
            ),
            Text(
              "${widget.currentStep}/${widget.totalSteps}",
              style: context.appTheme.regular16.copyWith(fontSize: 14),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
