import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/core/theme/app_theme/dark_theme.dart';
import 'package:super_fitness/features/meals/domain/entities/meal_category_entity.dart';
import 'package:super_fitness/features/meals/domain/entities/meal_entity.dart';
import 'package:super_fitness/features/meals/presentation/meals/view_model/meals_intent.dart';
import 'package:super_fitness/features/meals/presentation/meals/view_model/meals_view_model.dart';
import 'package:super_fitness/features/meals/presentation/meals/views/meals_view.dart';

import 'meals_view_test.mocks.dart';

@GenerateMocks([MealsViewModel])
void main() {
  late MockMealsViewModel mockViewModel;
  late StreamController<MealsUIEvents> uiEventsController;

  Finder findTextByLocalizedOrKey({
    required String localizationKey,
    required String fallbackText,
  }) {
    return find.byWidgetPredicate(
      (widget) =>
          widget is Text &&
          (widget.data == localizationKey || widget.data == fallbackText),
    );
  }

  setUp(() {
    uiEventsController = StreamController<MealsUIEvents>.broadcast();
    mockViewModel = MockMealsViewModel();
  });

  tearDown(() {
    uiEventsController.close();
  });

  MealsState idleState() => MealsState.initial();

  void setupMock(MealsState state) {
    when(mockViewModel.state).thenReturn(state);
    when(
      mockViewModel.stream,
    ).thenAnswer((_) => const Stream<MealsState>.empty());
    when(
      mockViewModel.uiEventsStream,
    ).thenAnswer((_) => uiEventsController.stream);
    when(mockViewModel.doIntent(any)).thenAnswer((_) async {});
  }

  Widget buildTestableWidget() {
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: BlocProvider<MealsViewModel>.value(
        value: mockViewModel,
        child: MaterialApp(
          theme: DarkTheme().themeData,
          home: const MealsView(),
        ),
      ),
    );
  }

  group('MealsView', () {
    testWidgets('shows meals app bar title', (tester) async {
      setupMock(idleState());
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      expect(
        findTextByLocalizedOrKey(
          localizationKey: 'meals.food_recommendation',
          fallbackText: 'Food Recommendation',
        ),
        findsOneWidget,
      );
    });

    testWidgets('dispatches GetMealsCategoriesIntent after first frame', (
      tester,
    ) async {
      setupMock(idleState());
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();
      await tester.pump();

      verify(
        mockViewModel.doIntent(argThat(isA<GetMealsCategoriesIntent>())),
      ).called(1);
    });

    testWidgets('shows category strip and meal grid when data loaded', (
      tester,
    ) async {
      setupMock(
        MealsState(
          categoriesState: BaseState.loaded([
            const MealCategoryEntity(id: '1', name: 'Chicken'),
            const MealCategoryEntity(id: '2', name: 'Beef'),
          ]),
          mealsState: BaseState.loaded([
            const MealEntity(id: '10', name: 'Meal One'),
            const MealEntity(id: '11', name: 'Meal Two'),
          ]),
          selectedCategoryIndex: 0,
        ),
      );
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      expect(find.text('Chicken'), findsOneWidget);
      expect(find.text('Beef'), findsOneWidget);
      expect(find.text('Meal One'), findsOneWidget);
      expect(find.text('Meal Two'), findsOneWidget);
    });
  });
}
