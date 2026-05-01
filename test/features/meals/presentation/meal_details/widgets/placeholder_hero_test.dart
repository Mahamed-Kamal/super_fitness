import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/features/meals/presentation/meal_details/widgets/placeholder_hero.dart';

void main() {
  testWidgets(
    'should render with correct gradient and icon',
        (WidgetTester tester) async {
      // Wrap in MaterialApp/Scaffold to provide Directionality for the Icon
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PlaceholderHero(),
          ),
        ),
      );

      // 1. Verify Container and Decoration
      final containerFinder = find.byType(Container);
      expect(containerFinder, findsOneWidget);

      final container = tester.widget<Container>(containerFinder);
      final decoration = container.decoration as BoxDecoration;
      final gradient = decoration.gradient as LinearGradient;

      // Verify Gradient Colors
      expect(gradient.colors, [
        const Color(0xFF2A1A10),
        const Color(0xFF1A1A1A),
      ]);
      expect(gradient.begin, Alignment.topLeft);
      expect(gradient.end, Alignment.bottomRight);

      // 2. Verify Icon
      final iconFinder = find.byIcon(Icons.restaurant);
      expect(iconFinder, findsOneWidget);

      final icon = tester.widget<Icon>(iconFinder);
      expect(icon.size, 64);
      expect(icon.color, const Color(0xFF333333));
    },
  );
}