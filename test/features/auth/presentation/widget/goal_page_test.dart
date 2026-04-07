import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/features/auth/domain/entities/register_form_data.dart';
import 'package:super_fitness/features/auth/domain/entities/user_goal.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_intent.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_view_model.dart';
import 'package:super_fitness/features/auth/presentation/widget/goal_page.dart';
import 'package:super_fitness/features/auth/presentation/widget/select_goal_and_level_widget.dart';
import 'package:super_fitness/core/theme/app_theme/dark_theme.dart';

import 'goal_page_test.mocks.dart';

@GenerateMocks([RegisterViewModel])
void main() {
  late MockRegisterViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockRegisterViewModel();
    when(mockViewModel.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget createWidgetUnderTest(String savedGoal) {
    when(mockViewModel.state).thenReturn(
      RegisterState.init().copyWith(
        formData: RegisterFormData(goal: savedGoal),
      ),
    );

    return MaterialApp(
      theme: DarkTheme().themeData,
      home: Scaffold(
        body: BlocProvider<RegisterViewModel>.value(
          value: mockViewModel,
          child: const GoalPage(),
        ),
      ),
    );
  }

  group('GoalPage Widget Tests', () {
    testWidgets('Should display all goal options correctly', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(createWidgetUnderTest(""));
      await tester.pumpAndSettle();

      expect(find.byType(SelectGoalAndLevelWidget), findsNWidgets(5));
    });

    testWidgets('Should select a goal and enable Next button on tap', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(createWidgetUnderTest(""));
      await tester.pumpAndSettle();

      final firstItem = find.byType(SelectGoalAndLevelWidget).first;
      await tester.tap(firstItem);
      await tester.pumpAndSettle();

      final nextButton = tester.widget<ElevatedButton>(
        find.byType(ElevatedButton),
      );
      expect(nextButton.onPressed, isNotNull);
    });

    testWidgets('Should load initial goal from state if it exists', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(createWidgetUnderTest(UserGoal.loseWeight.name));
      await tester.pumpAndSettle();

      final nextButton = tester.widget<ElevatedButton>(
        find.byType(ElevatedButton),
      );
      expect(nextButton.onPressed, isNotNull);

      final goalWidgets = tester.widgetList<SelectGoalAndLevelWidget>(
        find.byType(SelectGoalAndLevelWidget),
      );
      final isAnySelected = goalWidgets.any((widget) => widget.isSelected);
      expect(isAnySelected, isTrue);
    });

    testWidgets(
      'Should trigger SwitchViewToSelectActivityLevel intent when Next is pressed',
      (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(createWidgetUnderTest(""));
        await tester.pumpAndSettle();

        await tester.tap(find.byType(SelectGoalAndLevelWidget).at(2));
        await tester.pumpAndSettle();

        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        verify(
          mockViewModel.doIntent(
            argThat(
              isA<SwitchViewToSelectActivityLevel>().having(
                (intent) => intent.goal,
                'goal',
                UserGoal.getFitter,
              ),
            ),
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
