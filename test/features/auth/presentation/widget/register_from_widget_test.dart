import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_intent.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_view_model.dart';
import 'package:super_fitness/core/theme/app_theme/dark_theme.dart';
import 'package:super_fitness/features/auth/presentation/widget/register_from_widget.dart';

import 'register_from_widget_test.mocks.dart';

@GenerateMocks([RegisterViewModel])
void main() {
  late MockRegisterViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockRegisterViewModel();
    when(mockViewModel.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget createWidgetUnderTest({
    RequestState requestState = RequestState.init,
    String? errorMessage,
  }) {
    when(mockViewModel.state).thenReturn(
      RegisterState.init().copyWith(
        requestState: requestState,
        errorMessage: errorMessage,
      ),
    );

    return MaterialApp(
      theme: DarkTheme().themeData,
      home: Scaffold(
        body: BlocProvider<RegisterViewModel>.value(
          value: mockViewModel,
          child: const SingleChildScrollView(child: RegisterFormWidget()),
        ),
      ),
    );
  }

  group('RegisterFormWidget Tests', () {
    testWidgets('Should toggle password visibility when eye icon is clicked', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      Finder getPasswordField() => find.descendant(
        of: find.widgetWithText(TextFormField, 'password'),
        matching: find.byType(TextField),
      );

      TextField passwordTextField = tester.widget<TextField>(
        getPasswordField(),
      );
      expect(passwordTextField.obscureText, isTrue);

      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      passwordTextField = tester.widget<TextField>(getPasswordField());
      expect(passwordTextField.obscureText, isFalse);
    });

    testWidgets(
      'Should show validation errors if fields are empty and register is clicked',
      (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        expect(find.textContaining('first_name'), findsWidgets);
        verifyNever(mockViewModel.doIntent(any));
      },
    );

    testWidgets(
      'Should trigger RegisterButtonClickedIntent with correct data when valid',
      (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        await tester.enterText(
          find.widgetWithText(TextFormField, 'first_name'),
          'Abdelrahman',
        );
        await tester.enterText(
          find.widgetWithText(TextFormField, 'last_name'),
          'Ayman',
        );
        await tester.enterText(
          find.widgetWithText(TextFormField, 'email'),
          'test@test.com',
        );
        await tester.enterText(
          find.widgetWithText(TextFormField, 'password'),
          'Password123!',
        );

        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        verify(
          mockViewModel.doIntent(
            argThat(
              isA<RegisterButtonClickedIntent>()
                  .having((i) => i.firstName, 'firstName', 'Abdelrahman')
                  .having((i) => i.email, 'email', 'test@test.com'),
            ),
          ),
        ).called(1);
      },
    );

    testWidgets('Should show CircularProgressIndicator when state is loading', (
      tester,
    ) async {
      await tester.pumpWidget(
        createWidgetUnderTest(requestState: RequestState.loading),
      );
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(ElevatedButton), findsNothing);
    });

    testWidgets('Should show error message when requestState is error', (
      tester,
    ) async {
      const errorMsg = "Email already exists";
      await tester.pumpWidget(
        createWidgetUnderTest(
          requestState: RequestState.error,
          errorMessage: errorMsg,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(errorMsg), findsOneWidget);
    });

    testWidgets(
      'Should trigger LoginNavigationButtonClickedIntent when Login is clicked',
      (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        await tester.tap(find.text('login'));
        await tester.pumpAndSettle();

        verify(
          mockViewModel.doIntent(
            argThat(isA<LoginNavigationButtonClickedIntent>()),
          ),
        ).called(1);
      },
    );
  });
}

extension MatcherExtension on TypeMatcher {
  TypeMatcher<T> having<T>(
    dynamic Function(T) feature,
    String description,
    dynamic matcher,
  ) {
    return isA<T>().having(feature, description, matcher);
  }
}
