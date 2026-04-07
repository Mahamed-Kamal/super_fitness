import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/features/auth/domain/entities/activity_level.dart';
import 'package:super_fitness/features/auth/domain/entities/register_form_data.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_intent.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_view_model.dart';
import 'package:super_fitness/features/auth/presentation/widget/level_page.dart';
import 'package:super_fitness/features/auth/presentation/widget/select_goal_and_level_widget.dart';
import 'package:super_fitness/core/theme/app_theme/dark_theme.dart';

import 'level_page_test.mocks.dart';

@GenerateMocks([RegisterViewModel])
void main() {
  late MockRegisterViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockRegisterViewModel();
    when(mockViewModel.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget createWidgetUnderTest({
    String savedLevel = "",
    RequestState requestState = RequestState.init,
  }) {
    when(mockViewModel.state).thenReturn(
      RegisterState.init().copyWith(
        formData: RegisterFormData(activityLevel: savedLevel),
        requestState: requestState,
      ),
    );

    return MaterialApp(
      theme: DarkTheme().themeData,
      home: Scaffold(
        body: BlocProvider<RegisterViewModel>.value(
          value: mockViewModel,
          child: const LevelPage(),
        ),
      ),
    );
  }

  group('LevelPage Widget Tests', () {
    testWidgets('Should display 5 activity level options', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.byType(SelectGoalAndLevelWidget), findsNWidgets(5));
    });

    testWidgets('Next button should be disabled when no level is selected', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      final nextButton = tester.widget<ElevatedButton>(
        find.byType(ElevatedButton),
      );
      expect(nextButton.onPressed, isNull);
    });

    testWidgets('Should show loading indicator when state is loading', (
      tester,
    ) async {
      await tester.pumpWidget(
        createWidgetUnderTest(requestState: RequestState.loading),
      );
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(ElevatedButton), findsNothing);
    });

    testWidgets('Should select a level and enable Next button', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      await tester.tap(find.byType(SelectGoalAndLevelWidget).first);
      await tester.pumpAndSettle();

      final nextButton = tester.widget<ElevatedButton>(
        find.byType(ElevatedButton),
      );
      expect(nextButton.onPressed, isNotNull);
    });

    testWidgets('Should load initial level from state', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        createWidgetUnderTest(savedLevel: ActivityLevel.advanced.name),
      );
      await tester.pumpAndSettle();

      final widgets = tester
          .widgetList<SelectGoalAndLevelWidget>(
            find.byType(SelectGoalAndLevelWidget),
          )
          .toList();

      expect(
        widgets[3].isSelected,
        isTrue,
        reason: 'Advanced level should be selected',
      );

      final nextButton = tester.widget<ElevatedButton>(
        find.byType(ElevatedButton),
      );
      expect(nextButton.onPressed, isNotNull);
    });

    testWidgets('Should trigger FinishRegisterIntent when Next is pressed', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      await tester.tap(
        find.byType(SelectGoalAndLevelWidget).at(2),
      ); // rookie, beginner, intermediate
      await tester.pumpAndSettle();

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      verify(
        mockViewModel.doIntent(
          argThat(
            isA<FinishRegisterIntent>().having(
              (intent) => intent.activityLevel,
              'activityLevel',
              ActivityLevel.intermediate,
            ),
          ),
        ),
      ).called(1);
    });
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
