import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/core/theme/app_theme/dark_theme.dart';
import 'package:super_fitness/features/auth/presentation/widget/select_goal_and_level_widget.dart';

void main() {
  Widget createWidgetUnderTest({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return MaterialApp(
      theme: DarkTheme().themeData,
      home: Scaffold(
        body: SelectGoalAndLevelWidget(
          title: title,
          isSelected: isSelected,
          onTap: onTap,
        ),
      ),
    );
  }

  group('SelectGoalAndLevelWidget Tests', () {
    testWidgets('Should display title in uppercase', (tester) async {
      const title = 'rookie';
      await tester.pumpWidget(
        createWidgetUnderTest(title: title, isSelected: false, onTap: () {}),
      );

      expect(find.text('ROOKIE'), findsOneWidget);
    });

    testWidgets('Should call onTap when clicked', (tester) async {
      bool isClicked = false;
      await tester.pumpWidget(
        createWidgetUnderTest(
          title: 'test',
          isSelected: false,
          onTap: () => isClicked = true,
        ),
      );

      await tester.tap(find.byType(SelectGoalAndLevelWidget));
      await tester.pumpAndSettle();

      expect(isClicked, isTrue);
    });

    testWidgets('Should show active styles when isSelected is true', (
      tester,
    ) async {
      await tester.pumpWidget(
        createWidgetUnderTest(title: 'active', isSelected: true, onTap: () {}),
      );

      final innerCircleFinder = find.byType(AnimatedContainer);

      final innerCircle = tester
          .widgetList<AnimatedContainer>(innerCircleFinder)
          .firstWhere((element) => element.constraints?.maxWidth == 10);

      expect(innerCircle.constraints?.maxWidth, 10);
      expect(innerCircle.constraints?.maxHeight, 10);
    });

    testWidgets('Should show inactive styles when isSelected is false', (
      tester,
    ) async {
      await tester.pumpWidget(
        createWidgetUnderTest(
          title: 'inactive',
          isSelected: false,
          onTap: () {},
        ),
      );

      final innerCircleFinder = find.byType(AnimatedContainer);
      final innerCircle = tester
          .widgetList<AnimatedContainer>(innerCircleFinder)
          .firstWhere((element) => element.constraints?.maxWidth == 0);

      expect(innerCircle.constraints?.maxWidth, 0);
    });
  });
}
