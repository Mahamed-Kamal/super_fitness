import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/core/theme/app_theme/dark_theme.dart';

void main() {
  testWidgets('Dark theme MaterialApp builds', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: DarkTheme().themeData,
        home: const Scaffold(body: Center(child: Text('ok'))),
      ),
    );

    expect(find.text('ok'), findsOneWidget);
  });
}
