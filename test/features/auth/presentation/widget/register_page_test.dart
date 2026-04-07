import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_view_model.dart';
import 'package:super_fitness/features/auth/presentation/widget/register_from_widget.dart';
import 'package:super_fitness/core/theme/app_theme/dark_theme.dart';
import 'package:super_fitness/features/auth/presentation/widget/register_page.dart';

import 'register_page_test.mocks.dart';

@GenerateMocks([RegisterViewModel])
void main() {
  late MockRegisterViewModel mockViewModel;
  late PageController pageController;

  setUp(() {
    mockViewModel = MockRegisterViewModel();
    pageController = PageController();

    when(mockViewModel.state).thenReturn(RegisterState.init());
    when(mockViewModel.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      theme: DarkTheme().themeData,
      home: Scaffold(
        body: BlocProvider<RegisterViewModel>.value(
          value: mockViewModel,
          child: RegisterPage(pageController: pageController),
        ),
      ),
    );
  }

  group('RegisterPage Widget Tests', () {
    testWidgets('Should display welcome messages and register form', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.textContaining('hey_there'), findsOneWidget);
      expect(find.textContaining('create_an_account'), findsOneWidget);

      expect(find.byType(RegisterFormWidget), findsOneWidget);
    });

    testWidgets('Should be scrollable when content overflows', (tester) async {
      tester.view.physicalSize = const Size(1200, 400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      final scrollFinder = find.byType(SingleChildScrollView);
      expect(scrollFinder, findsOneWidget);

      await tester.drag(scrollFinder, const Offset(0, -300));
      await tester.pump();

      expect(tester.takeException(), isNull);
    });
  });
}
