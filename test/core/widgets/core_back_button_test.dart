import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/core/widgets/core_back_button.dart';

import 'pump_app.dart';

void main() {
  testWidgets('invokes onPressed when provided', (tester) async {
    var tapped = false;

    await tester.pumpWidget(
      pumpWithDarkTheme(CoreBackButton(onPressed: () => tapped = true)),
    );

    await tester.tap(find.byType(InkWell));
    await tester.pump();

    expect(tapped, isTrue);
  });

  testWidgets('pops route when onPressed is null', (tester) async {
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
                        builder: (_) => Scaffold(body: CoreBackButton()),
                      ),
                    );
                  },
                  child: const Text('open'),
                ),
              ],
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(InkWell));
    await tester.pumpAndSettle();

    expect(find.text('open'), findsOneWidget);
  });
}
