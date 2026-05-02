import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/core/theme/app_theme/dark_theme.dart';
import 'package:super_fitness/features/meals/presentation/meal_details/widgets/ingredient_row.dart';

void main() {
  Widget createWidgetUnderTest({
    required String name,
    required String measure,
  }) {
    return MaterialApp(
      theme: DarkTheme().themeData,
      home: Scaffold(
        body: IngredientRow(name: name, measure: measure),
      ),
    );
  }

  testWidgets('should render capitalized name and trimmed measure', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      createWidgetUnderTest(name: 'chicken breast', measure: ' 200g '),
    );

    // Verify Capitalization logic (_capitalize)
    expect(find.text('Chicken breast'), findsOneWidget);

    // Verify Trimming logic (measure.trim())
    expect(find.text('200g'), findsOneWidget);
  });

  testWidgets('should apply correct theme colors and styles', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      createWidgetUnderTest(name: 'Egg', measure: '2 units'),
    );

    final nameText = tester.widget<Text>(find.text('Egg'));
    final measureText = tester.widget<Text>(find.text('2 units'));

    // Verify Name Style (semiBold18 + Bold weight)
    expect(nameText.style?.fontWeight, FontWeight.bold);

    // Verify Measure Color (should match primary color from DarkTheme)
    final expectedPrimary = DarkTheme().themeData.colorScheme.primary;
    expect(measureText.style?.color, expectedPrimary);
  });

  testWidgets('should handle empty name string gracefully', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(createWidgetUnderTest(name: '', measure: 'N/A'));

    expect(find.text(''), findsOneWidget);
  });

  testWidgets(
    'should handle long ingredient names using Expanded to prevent overflow',
    (WidgetTester tester) async {
      // Set a narrow surface to force a long text to wrap/constrain
      tester.view.physicalSize = const Size(300, 600);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        createWidgetUnderTest(
          name:
              'Extremely long ingredient name that would usually cause overflow',
          measure: '100g',
        ),
      );

      // If Expanded is working, the test will finish without an overflow exception.
      expect(tester.takeException(), isNull);

      addTearDown(tester.view.resetPhysicalSize);
    },
  );
}
