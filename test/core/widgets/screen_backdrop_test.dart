import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/core/utils/assets_manager/assets_manager.dart';
import 'package:super_fitness/core/widgets/screen_backdrop.dart';

import 'pump_app.dart';

void main() {
  testWidgets('lays out child over blurred image and overlay', (tester) async {
    await tester.pumpWidget(
      pumpWithDarkTheme(
        Scaffold(
          body: ScreenBackdrop(
            image: AssetsManager.appLogoSvg,
            child: const Align(
              alignment: Alignment.center,
              child: Text('foreground'),
            ),
          ),
        ),
        scaffold: false,
      ),
    );

    expect(find.byType(Stack), findsWidgets);
    expect(find.text('foreground'), findsOneWidget);
    expect(find.byType(ImageFiltered), findsOneWidget);
  });
}
