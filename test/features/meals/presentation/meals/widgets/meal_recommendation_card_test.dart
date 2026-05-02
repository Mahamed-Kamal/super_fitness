import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/core/theme/app_theme/dark_theme.dart';
import 'package:super_fitness/features/meals/domain/entities/meal_entity.dart';
import 'package:super_fitness/features/meals/presentation/meals/widgets/meals_by_category/meal_recommendation_card.dart';

void main() {
  Widget wrap(Widget child) {
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: MaterialApp(
        theme: DarkTheme().themeData,
        home: Scaffold(body: Center(child: child)),
      ),
    );
  }

  group('MealRecommendationCard', () {
    testWidgets('shows meal name and invokes onTap', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        wrap(
          SizedBox(
            width: 180,
            height: 220,
            child: MealRecommendationCard(
              meal: const MealEntity(id: '1', title: 'Protein Bowl', image: ''),
              onTap: () => tapped = true,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Protein Bowl'), findsOneWidget);

      await tester.tap(find.byType(InkWell));
      await tester.pump();
      expect(tapped, isTrue);
    });
  });
}
