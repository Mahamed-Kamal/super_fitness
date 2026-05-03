import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_fitness/core/di/di.dart';
import 'package:super_fitness/core/theme/app_theme/dark_theme.dart';
import 'package:super_fitness/features/auth/presentation/logout/logout_view_model.dart';
import 'package:super_fitness/features/auth/presentation/logout/logout_events.dart';
import 'package:super_fitness/features/auth/presentation/logout/logout_state.dart';
import 'package:super_fitness/features/auth/presentation/widget/logout_dialog.dart';

import 'logout_dialog_test.mocks.dart';

@GenerateMocks([LogoutCubit])
void main() {
  late MockLogoutCubit mockCubit;
  late StreamController<LogoutUiEvents> uiEventController;

  setUp(() async {
    mockCubit = MockLogoutCubit();
    uiEventController = StreamController<LogoutUiEvents>.broadcast();

    when(mockCubit.state).thenReturn(const LogoutStates());
    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockCubit.logoutUiEvent).thenAnswer((_) => uiEventController.stream);

    if (getIt.isRegistered<LogoutCubit>()) {
      getIt.unregister<LogoutCubit>();
    }
    getIt.registerSingleton<LogoutCubit>(mockCubit);

    SharedPreferences.setMockInitialValues({});
  });

  tearDown(() {
    uiEventController.close();
  });

  Widget createWidgetUnderTest() {
    final darkTheme = DarkTheme().themeData;

    return MaterialApp(
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      theme: darkTheme,
      home: const Scaffold(body: LogOuDialog()),
    );
  }

  testWidgets('Should display logout titles and buttons', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.byType(LogOuDialog), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(OutlinedButton), findsOneWidget);
  });

  testWidgets('Tapping logout button should dispatch LogoutEvent intent', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    final logoutButton = find.byType(ElevatedButton);
    await tester.tap(logoutButton);
    await tester.pump();

    verify(mockCubit.doIntent(any)).called(1);
  });
}
