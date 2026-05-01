import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/core/theme/app_theme/dark_theme.dart';
import 'package:super_fitness/features/meals/domain/entities/meal_entity.dart';
import 'package:super_fitness/features/meals/presentation/meal_details/widgets/meal_detail_body.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  const testMeal = MealEntity(
    title: 'Gourmet Pasta',
    image: 'https://example.com/pasta.png',
    ingredients: [MapEntry('Pasta', '200g')],
    instructions: 'Boil water and cook pasta.',
  );

  Widget createWidgetUnderTest(MealEntity meal) {
    return MaterialApp(
      theme: DarkTheme().themeData,
      home: Scaffold(body: MealDetailBody(meal: meal)),
    );
  }

  testWidgets('should render empty instructions state correctly', (
    tester,
  ) async {
    await mockNetworkImagesFor(() async {
      const mealNoInstructions = MealEntity(
        title: 'Water',
        image: '',
        ingredients: [],
        instructions: '',
      );

      await tester.pumpWidget(createWidgetUnderTest(mealNoInstructions));

      expect(find.text('Instructions'), findsOneWidget);
      expect(find.text('Boil water and cook pasta.'), findsNothing);
    });
  });

  testWidgets('controller disposal check', (tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(createWidgetUnderTest(testMeal));
      await tester.pumpWidget(Container());
      expect(tester.takeException(), isNull);
    });
  });
}
