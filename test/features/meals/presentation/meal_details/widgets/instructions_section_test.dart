import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/core/theme/app_theme/dark_theme.dart';
import 'package:super_fitness/features/meals/presentation/meal_details/widgets/instructions_section.dart';

void main() {
  Widget createWidgetUnderTest(String text) {
    return MaterialApp(
      theme: DarkTheme().themeData,
      home: Scaffold(
        body: SingleChildScrollView(
          child: InstructionsSection(text: text),
        ),
      ),
    );
  }

  group('InstructionsSection Tests', () {
    testWidgets(
      'should render full text and no button if text is shorter than preview length',
          (WidgetTester tester) async {
        const shortText = 'Small instruction set.';

        await tester.pumpWidget(createWidgetUnderTest(shortText));

        expect(find.text(shortText), findsOneWidget);
        expect(find.text('Show more'), findsNothing);
      },
    );

    testWidgets(
      'should truncate text and show "Show more" when text is long',
          (WidgetTester tester) async {
        final longText = 'A' * 350; // Greater than _previewLength (300)
        final expectedTruncated = '${'A' * 300}…';

        await tester.pumpWidget(createWidgetUnderTest(longText));

        expect(find.text(expectedTruncated), findsOneWidget);
        expect(find.text('Show more'), findsOneWidget);
        expect(find.text(longText), findsNothing);
      },
    );

    testWidgets(
      'should toggle between expanded and collapsed states when tapped',
          (WidgetTester tester) async {
        final longText = 'B' * 400;
        await tester.pumpWidget(createWidgetUnderTest(longText));

        // Initial state: Collapsed
        expect(find.text('Show more'), findsOneWidget);

        // Tap to Expand
        await tester.tap(find.text('Show more'));
        await tester.pump(); // Trigger setState

        expect(find.text('Show less'), findsOneWidget);
        expect(find.text(longText), findsOneWidget);

        // Tap to Collapse
        await tester.tap(find.text('Show less'));
        await tester.pump();

        expect(find.text('Show more'), findsOneWidget);
        expect(find.text(longText), findsNothing);
      },
    );

    testWidgets(
      'should apply primary color and correct font weight to toggle button',
          (WidgetTester tester) async {
        final longText = 'C' * 310;
        await tester.pumpWidget(createWidgetUnderTest(longText));

        final toggleButton = tester.widget<Text>(find.text('Show more'));
        final expectedColor = DarkTheme().themeData.colorScheme.primary;

        expect(toggleButton.style?.color, expectedColor);
        expect(toggleButton.style?.fontWeight, FontWeight.w600);
        expect(toggleButton.style?.fontSize, 13);
      },
    );
  });
}