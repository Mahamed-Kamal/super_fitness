import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/core/theme/app_theme/dark_theme.dart';
import 'package:super_fitness/features/auth/data/models/login/login_response_dto.dart';
import 'package:super_fitness/features/auth/presentation/login/view_model/login_intent.dart';
import 'package:super_fitness/features/auth/presentation/login/view_model/login_view_model.dart';
import 'package:super_fitness/features/auth/presentation/login/views/login_view.dart';

import 'login_view_test.mocks.dart';

@GenerateMocks([LoginViewModel])
void main() {
  late MockLoginViewModel mockViewModel;
  late StreamController<LoginUIEvents> uiEventsController;
  late StreamController<LoginState> stateController;

  setUp(() {
    uiEventsController = StreamController<LoginUIEvents>.broadcast();
    stateController = StreamController<LoginState>.broadcast();
    mockViewModel = MockLoginViewModel();
  });

  tearDown(() {
    uiEventsController.close();
    stateController.close();
  });

  LoginState idleState() =>
      LoginState(loginState: BaseState.init(), isButtonEnabled: false);

  void setupMock(LoginState state) {
    when(mockViewModel.state).thenReturn(state);
    when(mockViewModel.stream).thenAnswer((_) => stateController.stream);
    when(
      mockViewModel.uiEventsStream,
    ).thenAnswer((_) => uiEventsController.stream);
    when(mockViewModel.doIntent(any)).thenReturn(null);
  }

  Widget buildTestableWidget() {
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: BlocProvider<LoginViewModel>.value(
        value: mockViewModel,
        child: MaterialApp(
          theme: DarkTheme().themeData,
          home: const LoginView(),
        ),
      ),
    );
  }

  // ══════════════════════════════════════════════════════════
  //  GROUP 1 – Initial render
  // ══════════════════════════════════════════════════════════
  group('Initial render', () {
    testWidgets('shows email and password TextFormFields', (tester) async {
      setupMock(idleState());
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      expect(find.byType(TextFormField), findsNWidgets(2));
    });

    testWidgets('shows a Form widget', (tester) async {
      setupMock(idleState());
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      expect(find.byType(Form), findsOneWidget);
    });

    testWidgets('shows login ElevatedButton', (tester) async {
      setupMock(idleState());
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('login button is disabled when form is empty', (tester) async {
      setupMock(idleState());
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('password field is obscured by default', (tester) async {
      setupMock(idleState());
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      final fields = tester
          .widgetList<EditableText>(find.byType(EditableText))
          .toList();
      expect(fields[1].obscureText, isTrue);
    });

    testWidgets('shows visibility_off icon when password is obscured', (
      tester,
    ) async {
      setupMock(idleState());
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
    });
  });

  // ══════════════════════════════════════════════════════════
  //  GROUP 2 – Form interaction
  // ══════════════════════════════════════════════════════════
  group('Form interaction', () {
    testWidgets('dispatches FormChangedIntent when email field changes', (
      tester,
    ) async {
      setupMock(idleState());
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      await tester.enterText(
        find.byType(TextFormField).first,
        'test@email.com',
      );
      await tester.pump();

      verify(
        mockViewModel.doIntent(argThat(isA<FormChangedIntent>())),
      ).called(greaterThanOrEqualTo(1));
    });

    testWidgets('dispatches FormChangedIntent when password field changes', (
      tester,
    ) async {
      setupMock(idleState());
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      await tester.enterText(find.byType(TextFormField).last, 'Secret123');
      await tester.pump();

      verify(
        mockViewModel.doIntent(argThat(isA<FormChangedIntent>())),
      ).called(greaterThanOrEqualTo(1));
    });

    testWidgets('toggles password visibility when suffix icon tapped', (
      tester,
    ) async {
      setupMock(idleState());
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      await tester.tap(find.byIcon(Icons.visibility_off_outlined));
      await tester.pump();

      expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);

      final fields = tester
          .widgetList<EditableText>(find.byType(EditableText))
          .toList();
      expect(fields[1].obscureText, isFalse);
    });

    testWidgets('login button enabled when isButtonEnabled = true', (
      tester,
    ) async {
      setupMock(
        LoginState(loginState: BaseState.init(), isButtonEnabled: true),
      );
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNotNull);
    });
  });

  // ══════════════════════════════════════════════════════════
  //  GROUP 3 – Login button
  // ══════════════════════════════════════════════════════════
  group('Login button', () {
    testWidgets('dispatches LoginIntent when form is valid and button tapped', (
      tester,
    ) async {
      setupMock(
        LoginState(loginState: BaseState.init(), isButtonEnabled: true),
      );
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      await tester.enterText(
        find.byType(TextFormField).first,
        'test@email.com',
      );
      await tester.enterText(find.byType(TextFormField).last, 'Secret123!');
      await tester.pump();

      await tester.ensureVisible(find.byType(ElevatedButton));
      await tester.pump();
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      verify(mockViewModel.doIntent(argThat(isA<LoginIntent>()))).called(1);
    });

    testWidgets('shows CircularProgressIndicator when loading', (tester) async {
      setupMock(
        LoginState(
          loginState: BaseState<LoginResponseDto>.init().loading,
          isButtonEnabled: true,
        ),
      );
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('login button is disabled while loading', (tester) async {
      setupMock(
        LoginState(
          loginState: BaseState<LoginResponseDto>.init().loading,
          isButtonEnabled: true,
        ),
      );
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });
  });

  // ══════════════════════════════════════════════════════════
  //  GROUP 5 – UI Events (toast)
  // ══════════════════════════════════════════════════════════
  group('UI Events', () {
    testWidgets('shows toast on LoginViewShowToast event', (tester) async {
      setupMock(idleState());
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      uiEventsController.add(
        LoginViewShowToast(message: 'Login successful', isError: false),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('Login successful'), findsOneWidget);
    });

    testWidgets('shows error toast on LoginViewShowToast with isError = true', (
      tester,
    ) async {
      setupMock(idleState());
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      uiEventsController.add(
        LoginViewShowToast(message: 'Invalid credentials', isError: true),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('Invalid credentials'), findsOneWidget);
    });
  });
}
