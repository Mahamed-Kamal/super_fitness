import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_fitness/core/theme/app_theme/dark_theme.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_event.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_view_model.dart';
import 'package:super_fitness/features/auth/presentation/register/views/register_view.dart';

import 'register_view_test.mocks.dart';

@GenerateMocks([RegisterViewModel])
void main() {
  late MockRegisterViewModel mockViewModel;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  setUp(() {
    mockViewModel = MockRegisterViewModel();
    when(mockViewModel.stream).thenAnswer((_) => Stream<RegisterState>.empty());
    when(mockViewModel.state).thenReturn(RegisterState.init());
    when(
      mockViewModel.eventStream,
    ).thenAnswer((_) => Stream<RegisterEvent>.empty());
    when(mockViewModel.close()).thenAnswer((_) async => {});
  });

  Widget buildTestableWidget() => EasyLocalization(
    saveLocale: false,
    supportedLocales: const [Locale('en'), Locale('ar')],
    path: 'assets/translations',
    fallbackLocale: const Locale("en"),
    child: Builder(
      builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          theme: DarkTheme().themeData,
          home: BlocProvider<RegisterViewModel>.value(
            value: mockViewModel,
            child: const RegisterView(),
          ),
        );
      },
    ),
  );

  group("register view", () {
    testWidgets("test register view", (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      expect(find.byType(RegisterView), findsOneWidget);
    });
  });
}
