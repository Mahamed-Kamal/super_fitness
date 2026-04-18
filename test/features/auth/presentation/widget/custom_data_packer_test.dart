import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/features/auth/presentation/widget/custom_data_packer.dart';
import 'package:super_fitness/core/theme/app_theme/dark_theme.dart';

void main() {
  bool nextPressed = false;

  Widget createWidgetUnderTest({
    int initialValue = 20,
    int min = 10,
    int max = 100,
  }) {
    return MaterialApp(
      theme: DarkTheme().themeData,
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      home: Scaffold(
        body: CustomDataPicker(
          title: 'Title',
          subtitle: 'Subtitle',
          unit: 'kg',
          minValue: min,
          maxValue: max,
          initialValue: initialValue,
          onValueChanged: (val) => {},
          onNext: () => nextPressed = true,
        ),
      ),
    );
  }

  group('CustomDataPicker Widget Tests', () {
    testWidgets('Should display the passed title, subtitle and unit', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('TITLE'), findsOneWidget); //toUpperCase check
      expect(find.text('Subtitle'), findsOneWidget);
      expect(find.text('kg'), findsOneWidget);
    });

    testWidgets(
      'Should initialize NumberPicker with the correct initialValue',
      (tester) async {
        await tester.pumpWidget(createWidgetUnderTest(initialValue: 50));

        expect(find.text('50'), findsOneWidget);
      },
    );

    testWidgets('Should call onNext callback when ElevatedButton is pressed', (
      tester,
    ) async {
      nextPressed = false;
      await tester.pumpWidget(createWidgetUnderTest());

      final nextButton = find.byType(ElevatedButton);
      await tester.tap(nextButton);
      await tester.pump();

      expect(nextPressed, isTrue);
    });

    testWidgets('Should respect minValue and maxValue limits', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(initialValue: 10, min: 10, max: 12),
      );

      expect(find.text('10'), findsOneWidget);
      expect(find.text('12'), findsOneWidget);
      expect(find.text('13'), findsNothing);
    });
  });
}
