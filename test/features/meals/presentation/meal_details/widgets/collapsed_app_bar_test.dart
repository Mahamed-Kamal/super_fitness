import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/core/theme/app_theme/dark_theme.dart';
import 'package:super_fitness/features/meals/presentation/meal_details/widgets/collapsed_app_bar.dart';

void main() {
  Widget createWidgetUnderTest(String title) {
    return MaterialApp(
      theme: DarkTheme().themeData,
      home: Scaffold(body: CollapsedAppBar(title: title)),
    );
  }

  testWidgets('should render title correctly with specific padding and style', (
    WidgetTester tester,
  ) async {
    const testTitle = 'Meal Details';

    await tester.pumpWidget(createWidgetUnderTest(testTitle));

    final textFinder = find.text(testTitle);
    expect(textFinder, findsOneWidget);

    final containerFinder = find.byType(Container);
    final container = tester.widget<Container>(containerFinder);
    final padding = container.padding as EdgeInsets;

    expect(padding.left, 56);
    expect(padding.right, 56);
    expect(padding.bottom, 12);

    final textWidget = tester.widget<Text>(textFinder);
    expect(textWidget.maxLines, 1);
    expect(textWidget.overflow, TextOverflow.ellipsis);
    expect(textWidget.style?.fontSize, 16);
    expect(textWidget.style?.fontWeight, FontWeight.w800);
    expect(textWidget.style?.shadows, isNotEmpty);
  });

  testWidgets('should handle long titles by showing ellipsis', (
    WidgetTester tester,
  ) async {
    const longTitle =
        'This is an extremely long title that should definitely overflow the container constraints';

    tester.view.physicalSize = const Size(200, 400);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(createWidgetUnderTest(longTitle));

    final textWidget = tester.widget<Text>(find.byType(Text));
    expect(textWidget.overflow, TextOverflow.ellipsis);

    addTearDown(tester.view.resetPhysicalSize);
  });
}
