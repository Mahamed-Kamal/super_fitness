import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/core/theme/app_theme/dark_theme.dart';
import 'package:super_fitness/features/auth/presentation/widget/step_progress_indicator.dart';

void main() {
  Widget createWidgetUnderTest({required int currentStep, int totalSteps = 6}) {
    return MaterialApp(
      theme: DarkTheme().themeData,
      home: Scaffold(
        body: StepProgressIndicator(
          currentStep: currentStep,
          totalSteps: totalSteps,
        ),
      ),
    );
  }

  group('StepProgressIndicator Widget Tests', () {
    testWidgets('Should display correct step text', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(currentStep: 3, totalSteps: 6),
      );

      expect(find.text('3/6'), findsOneWidget);
    });

    testWidgets('Should have progress value as 0 when currentStep is 1', (
      tester,
    ) async {
      await tester.pumpWidget(
        createWidgetUnderTest(currentStep: 1, totalSteps: 6),
      );

      final progressIndicator = tester.widget<CircularProgressIndicator>(
        find.byType(CircularProgressIndicator),
      );

      expect(progressIndicator.value, 0.0);
    });

    testWidgets('Should calculate correct progress value for other steps', (
      tester,
    ) async {
      const currentStep = 4;
      const totalSteps = 8;

      await tester.pumpWidget(
        createWidgetUnderTest(currentStep: currentStep, totalSteps: totalSteps),
      );

      final progressIndicator = tester.widget<CircularProgressIndicator>(
        find.byType(CircularProgressIndicator),
      );

      expect(progressIndicator.value, 0.5);
    });

    testWidgets('Should rotate the progress indicator by -90 degrees', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest(currentStep: 2));

      final transformFinder = find.ancestor(
        of: find.byType(CircularProgressIndicator),
        matching: find.byType(Transform),
      );

      final transformWidget = tester.widget<Transform>(transformFinder);

      expect(transformWidget.transform, isNotNull);

      expect(transformFinder, findsOneWidget);
    });

    testWidgets('Should use primary color for the progress indicator', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest(currentStep: 2));

      final progressIndicator = tester.widget<CircularProgressIndicator>(
        find.byType(CircularProgressIndicator),
      );

      final Color expectedColor = DarkTheme().themeData.colorScheme.primary;

      expect(
        (progressIndicator.valueColor as AlwaysStoppedAnimation).value,
        expectedColor,
      );
    });
  });
}
