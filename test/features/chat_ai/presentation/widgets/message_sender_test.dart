import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/core/theme/app_theme/dark_theme.dart';
import 'package:super_fitness/features/chat_ai/presentation/widgets/message_sender.dart';

void main() {
  testWidgets('MessageSender shows user message aligned to end', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: DarkTheme().themeData,
        home: Scaffold(
          body: MessageSender(
            text: 'Hello user',
            isUser: true,
            timestamp: DateTime.now(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Hello user'), findsOneWidget);
    final row = tester.widget<Row>(find.byType(Row));
    expect(row.mainAxisAlignment, MainAxisAlignment.end);
  });

  testWidgets('MessageSender shows chat message aligned to start', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: DarkTheme().themeData,
        home: Scaffold(
          body: MessageSender(
            text: 'Hello chat',
            isUser: false,
            timestamp: DateTime.now(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Hello chat'), findsOneWidget);
    final row = tester.widget<Row>(find.byType(Row));
    expect(row.mainAxisAlignment, MainAxisAlignment.start);
  });
}
