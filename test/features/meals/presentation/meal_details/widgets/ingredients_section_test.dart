import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/core/extensions/theme_extension.dart';
import 'package:super_fitness/core/theme/app_theme/dark_theme.dart';
import 'package:super_fitness/features/meals/presentation/meal_details/widgets/ingredient_row.dart';
import 'package:super_fitness/features/meals/presentation/meal_details/widgets/ingredients_section.dart';

void main() {
  Widget createWidgetUnderTest(List<MapEntry<String, String>> ingredients) {
    return MaterialApp(
      theme: DarkTheme().themeData,
      home: Scaffold(body: IngredientsSection(ingredients: ingredients)),
    );
  }

  testWidgets('should show "No ingredients available." when list is empty', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(createWidgetUnderTest([]));

    expect(find.text('No ingredients available.'), findsOneWidget);
    expect(find.byType(ListView), findsNothing);
  });

  testWidgets(
    'should filter out ingredients with empty or whitespace-only keys',
    (WidgetTester tester) async {
      final ingredients = [
        const MapEntry('Chicken', '200g'),
        const MapEntry(' ', '100g'), // Should be filtered
        const MapEntry('', '50g'), // Should be filtered
        const MapEntry('Rice', '1 cup'),
      ];

      await tester.pumpWidget(createWidgetUnderTest(ingredients));

      // Should only find the 2 valid ones
      expect(find.byType(IngredientRow), findsNWidgets(2));
      expect(find.text('Chicken'), findsOneWidget);
      expect(find.text('Rice'), findsOneWidget);
    },
  );

  testWidgets('should render ListView with dividers between items', (
    WidgetTester tester,
  ) async {
    final ingredients = [
      const MapEntry('Egg', '2'),
      const MapEntry('Milk', '1 cup'),
      const MapEntry('Bread', '2 slices'),
    ];

    await tester.pumpWidget(createWidgetUnderTest(ingredients));

    // Verify ListView configuration
    final listViewFinder = find.byType(ListView);
    final listView = tester.widget<ListView>(listViewFinder);

    expect(listView.shrinkWrap, isTrue);
    expect(listView.physics, isA<NeverScrollableScrollPhysics>());

    // For 3 items, there should be exactly 2 dividers
    expect(find.byType(Divider), findsNWidgets(2));

    // Verify Divider style from theme
    final divider = tester.widget<Divider>(find.byType(Divider).first);
    expect(divider.height, 1);
    expect(divider.thickness, 1);
    expect(
      divider.color,
      DarkTheme().themeData.extension<AppThemeExtension>()?.borderMuted,
    );
  });

  testWidgets(
    'should render nothing if all ingredients are filtered out but list wasn\'t initially empty',
    (WidgetTester tester) async {
      final ingredients = [const MapEntry(' ', '100g')];

      await tester.pumpWidget(createWidgetUnderTest(ingredients));

      // The logic skips the empty text check because ingredients.isEmpty is false,
      // but validIngredients.length will be 0.
      expect(find.byType(IngredientRow), findsNothing);
      expect(find.text('No ingredients available.'), findsNothing);
    },
  );
}
