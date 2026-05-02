import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/core/theme/app_theme/dark_theme.dart';
import 'package:super_fitness/features/meals/presentation/meals/widgets/meals_async_placeholder.dart';

void main() {
  Finder findTextByLocalizedOrKey({
    required String localizationKey,
    required String fallbackText,
  }) {
    return find.byWidgetPredicate(
      (widget) =>
          widget is Text &&
          (widget.data == localizationKey || widget.data == fallbackText),
    );
  }

  Widget wrap(Widget child) {
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: MaterialApp(
        theme: DarkTheme().themeData,
        home: Scaffold(body: child),
      ),
    );
  }

  group('MealsAsyncLoading', () {
    testWidgets('shows spinner and loading label text', (tester) async {
      await tester.pumpWidget(
        wrap(const MealsAsyncLoading(messageKey: 'meals.loading_categories')),
      );
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(
        findTextByLocalizedOrKey(
          localizationKey: 'meals.loading_categories',
          fallbackText: 'Loading categories...',
        ),
        findsOneWidget,
      );
    });
  });

  group('MealsInfoMessage', () {
    testWidgets('shows meals info label text', (tester) async {
      await tester.pumpWidget(
        wrap(const MealsInfoMessage(messageKey: 'meals.no_meals')),
      );
      await tester.pump();

      expect(
        findTextByLocalizedOrKey(
          localizationKey: 'meals.no_meals',
          fallbackText: 'No meals in this category',
        ),
        findsOneWidget,
      );
    });
  });
}
