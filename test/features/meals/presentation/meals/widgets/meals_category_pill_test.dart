import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/core/theme/app_theme/dark_theme.dart';
import 'package:super_fitness/features/meals/presentation/meals/widgets/meals_categories/meals_category_pill.dart';

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

  group('MealsCategoryPill', () {
    testWidgets('shows label and calls onTap', (tester) async {
      var taps = 0;
      await tester.pumpWidget(
        wrap(
          MealsCategoryPill(
            label: 'Vegan',
            selected: false,
            onTap: () => taps++,
          ),
        ),
      );
      await tester.pump();

      expect(find.text('Vegan'), findsOneWidget);

      await tester.tap(find.text('Vegan'));
      await tester.pump();
      expect(taps, 1);
    });

    testWidgets('selected pill renders label', (tester) async {
      await tester.pumpWidget(
        wrap(MealsCategoryPill(label: 'Keto', selected: true, onTap: () {})),
      );
      await tester.pump();

      expect(find.text('Keto'), findsOneWidget);
    });
  });
}
