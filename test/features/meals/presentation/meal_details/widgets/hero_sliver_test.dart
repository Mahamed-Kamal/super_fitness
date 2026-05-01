import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:super_fitness/core/theme/app_theme/dark_theme.dart';
import 'package:super_fitness/features/meals/domain/entities/meal_entity.dart';
import 'package:super_fitness/features/meals/presentation/meal_details/widgets/hero_sliver.dart';
import 'package:super_fitness/features/meals/presentation/meal_details/widgets/placeholder_hero.dart';

void main() {
  setUpAll(() => HttpOverrides.global = null);

  Widget createWidgetUnderTest({
    required MealEntity meal,
    double height = 300,
  }) {
    return MaterialApp(
      theme: DarkTheme().themeData,
      home: Scaffold(
        body: CustomScrollView(
          slivers: [HeroSliver(meal: meal, heroHeight: height)],
        ),
      ),
    );
  }

  testWidgets(
    'should render meal title and network image when image URL is provided',
    (WidgetTester tester) async {
      await mockNetworkImagesFor(() async {
        const meal = MealEntity(
          title: 'Healthy Salad',
          image: 'https://example.com/image.png',
        );

        await tester.pumpWidget(createWidgetUnderTest(meal: meal));

        expect(find.text('Healthy Salad'), findsOneWidget);
        expect(find.byType(Image), findsOneWidget);
      });
    },
  );

  testWidgets('should render PlaceholderHero when image URL is empty', (
    WidgetTester tester,
  ) async {
    const meal = MealEntity(title: 'Healthy Salad', image: '');

    await tester.pumpWidget(createWidgetUnderTest(meal: meal));

    expect(find.byType(PlaceholderHero), findsOneWidget);
    expect(find.byType(Image), findsNothing);
  });

  testWidgets('should render "Untitled Meal" when meal title is empty', (
    WidgetTester tester,
  ) async {
    const meal = MealEntity(title: '', image: 'https://example.com/image.png');

    await tester.pumpWidget(createWidgetUnderTest(meal: meal));

    expect(find.text('Untitled Meal'), findsOneWidget);
  });

  testWidgets('should render PlaceholderHero when Image.network fails', (
    WidgetTester tester,
  ) async {
    await mockNetworkImagesFor(() async {
      const meal = MealEntity(
        title: 'Test',
        image: 'https://invalid-url.com/error.png',
      );

      await tester.pumpWidget(createWidgetUnderTest(meal: meal));

      final imageFinder = find.byType(Image);
      expect(imageFinder, findsOneWidget);

      final Image image = tester.widget<Image>(imageFinder);

      await tester.pumpWidget(
        MaterialApp(
          home: image.errorBuilder!(
            tester.element(imageFinder),
            Object(),
            null,
          ),
        ),
      );

      expect(find.byType(PlaceholderHero), findsOneWidget);
      expect(find.byIcon(Icons.restaurant), findsOneWidget);
    });
  });

  testWidgets('should apply correct height to SliverAppBar', (
    WidgetTester tester,
  ) async {
    const expectedHeight = 450.0;
    const meal = MealEntity(title: 'Test', image: '');

    await tester.pumpWidget(
      createWidgetUnderTest(meal: meal, height: expectedHeight),
    );

    final sliverAppBar = tester.widget<SliverAppBar>(find.byType(SliverAppBar));
    expect(sliverAppBar.expandedHeight, expectedHeight);
  });
}
