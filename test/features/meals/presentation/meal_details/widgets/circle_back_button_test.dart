import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/theme/app_theme/dark_theme.dart';
import 'package:super_fitness/features/meals/presentation/meal_details/widgets/circle_back_button.dart';

import 'circle_back_button_test.mocks.dart';

@GenerateNiceMocks([MockSpec<NavigatorObserver>()])
void main() {
  late MockNavigatorObserver mockObserver;

  setUp(() {
    mockObserver = MockNavigatorObserver();
  });

  Widget createWidgetUnderTest({Widget? child}) {
    return MaterialApp(
      theme: DarkTheme().themeData,
      themeMode: ThemeMode.dark,
      home: Scaffold(body: child ?? const CircleBackButton()),
      navigatorObservers: [mockObserver],
    );
  }

  testWidgets(
    'should render CircleBackButton with correct icon and decoration from DarkTheme',
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      final containerFinder = find.byType(Container);
      final container = tester.widget<Container>(containerFinder);
      final decoration = container.decoration as BoxDecoration;

      expect(find.byIcon(Icons.arrow_back_ios_new_rounded), findsOneWidget);
      expect(decoration.shape, BoxShape.circle);

      final expectedColor = DarkTheme().themeData.colorScheme.primary;
      expect(decoration.color, expectedColor);
    },
  );

  testWidgets('should call Navigator.maybePop when tapped', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: DarkTheme().themeData,
        navigatorObservers: [mockObserver],
        home: const Scaffold(body: Text('Root')),
      ),
    );

    final BuildContext context = tester.element(find.text('Root'));
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const Scaffold(body: CircleBackButton()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(CircleBackButton), findsOneWidget);

    await tester.tap(find.byType(CircleBackButton));
    await tester.pumpAndSettle();

    verify(mockObserver.didPop(any, any)).called(1);
    expect(find.text('Root'), findsOneWidget);
  });
}
