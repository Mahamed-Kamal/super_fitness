import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/core/widgets/show_toast.dart';

import 'pump_app.dart';

void main() {
  testWidgets('showToast displays SnackBar with message', (tester) async {
    await tester.pumpWidget(
      pumpWithDarkTheme(
        Builder(
          builder: (context) {
            return ElevatedButton(
              onPressed: () => Toast.showToast(context, 'toast body'),
              child: const Text('trigger'),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('trigger'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('toast body'), findsOneWidget);
  });

  testWidgets('showTop inserts overlay with message', (tester) async {
    await tester.pumpWidget(
      pumpWithDarkTheme(
        Builder(
          builder: (context) {
            return ElevatedButton(
              onPressed: () => Toast.showTop(context, 'top toast'),
              child: const Text('trigger top'),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('trigger top'));
    await tester.pump();

    expect(find.text('top toast'), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
  });
}
