import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/core/utils/assets_manager/assets_manager.dart';
import 'package:super_fitness/core/widgets/core_back_button.dart';
import 'package:super_fitness/core/widgets/custom_image_view.dart';
import 'package:super_fitness/core/widgets/super_fitness_app_bar.dart';

import 'pump_app.dart';

void main() {
  testWidgets('shows title when title is set', (tester) async {
    await tester.pumpWidget(
      pumpWithDarkTheme(
        Scaffold(
          appBar: SuperFitnessAppBar(title: 'Screen title', showBack: false),
          body: const SizedBox(),
        ),
        scaffold: false,
      ),
    );

    expect(find.text('Screen title'), findsOneWidget);
  });

  testWidgets('shows back button when can pop and showBack is true', (
    tester,
  ) async {
    await tester.pumpWidget(
      pumpWithDarkTheme(
        Builder(
          builder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => Scaffold(
                          appBar: SuperFitnessAppBar(title: 'Inner'),
                          body: const SizedBox(),
                        ),
                      ),
                    );
                  },
                  child: const Text('go'),
                ),
              ],
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('go'));
    await tester.pumpAndSettle();

    expect(find.text('Inner'), findsOneWidget);
    expect(find.byType(CoreBackButton), findsOneWidget);
  });

  testWidgets('uses logo asset when title is null', (tester) async {
    await tester.pumpWidget(
      pumpWithDarkTheme(
        Scaffold(
          appBar: SuperFitnessAppBar(
            logo: AssetsManager.appLogoSvg,
            showBack: false,
          ),
          body: const SizedBox(),
        ),
        scaffold: false,
      ),
    );

    await tester.pumpAndSettle();
    expect(find.byType(CustomImageView), findsOneWidget);
  });
}
