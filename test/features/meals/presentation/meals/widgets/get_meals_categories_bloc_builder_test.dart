import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/core/theme/app_theme/dark_theme.dart';
import 'package:super_fitness/core/widgets/lottie_error.dart';
import 'package:super_fitness/features/meals/domain/entities/meal_category_entity.dart';
import 'package:super_fitness/features/meals/presentation/meals/view_model/meals_intent.dart';
import 'package:super_fitness/features/meals/presentation/meals/view_model/meals_view_model.dart';
import 'package:super_fitness/features/meals/presentation/meals/widgets/meals_categories/get_meals_categories_bloc_builder.dart';

import 'get_meals_categories_bloc_builder_test.mocks.dart';

@GenerateMocks([MealsViewModel])
void main() {
  late MockMealsViewModel mockViewModel;

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
    mockViewModel = MockMealsViewModel();
  });

  void setupMock(MealsState state) {
    when(mockViewModel.state).thenReturn(state);
    when(
      mockViewModel.stream,
    ).thenAnswer((_) => const Stream<MealsState>.empty());
    when(mockViewModel.doIntent(any)).thenAnswer((_) async {});
  }

  Widget buildSubject() {
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: MaterialApp(
        theme: DarkTheme().themeData,
        home: Scaffold(
          body: BlocProvider<MealsViewModel>.value(
            value: mockViewModel,
            child: const SingleChildScrollView(
              child: GetMealsCategoriesBlocBuilder(),
            ),
          ),
        ),
      ),
    );
  }

  group('GetMealsCategoriesBlocBuilder', () {
    // testWidgets('shows loading row when categories are loading', (
    //   tester,
    // ) async {
    //   setupMock(
    //     MealsState(
    //       categoriesState: BaseState<List<MealCategoryEntity>>.loading(),
    //       mealsState: BaseState.init(),
    //       selectedCategoryIndex: 0,
    //     ),
    //   );
    //   await tester.pumpWidget(buildSubject());
    //   await tester.pump();
    //
    //   expect(find.byType(CircularProgressIndicator), findsOneWidget);
    //   expect(
    //     findTextByLocalizedOrKey(
    //       localizationKey: 'meals.loading_categories',
    //       fallbackText: 'Loading categories...',
    //     ),
    //     findsOneWidget,
    //   );
    // });

    testWidgets('shows empty message when categories list is empty', (
      tester,
    ) async {
      setupMock(
        MealsState(
          categoriesState: BaseState.loaded(<MealCategoryEntity>[]),
          mealsState: BaseState.init(),
          selectedCategoryIndex: 0,
        ),
      );
      await tester.pumpWidget(buildSubject());
      await tester.pump();

      expect(
        findTextByLocalizedOrKey(
          localizationKey: 'meals.no_categories',
          fallbackText: 'No categories available',
        ),
        findsOneWidget,
      );
    });

    testWidgets('tapping a pill dispatches SelectMealCategoryIntent', (
      tester,
    ) async {
      setupMock(
        MealsState(
          categoriesState: BaseState.loaded([
            const MealCategoryEntity(id: '1', name: 'Chicken'),
            const MealCategoryEntity(id: '2', name: 'Beef'),
          ]),
          mealsState: BaseState.init(),
          selectedCategoryIndex: 0,
        ),
      );
      await tester.pumpWidget(buildSubject());
      await tester.pump();

      await tester.tap(find.text('Beef'));
      await tester.pump();

      verify(
        mockViewModel.doIntent(
          argThat(
            predicate<MealsIntent>(
              (intent) =>
                  intent is SelectMealCategoryIntent &&
                  intent.selectedIndex == 1,
            ),
          ),
        ),
      ).called(1);
    });

    testWidgets('categories error shows LottieError; retry loads categories', (
      tester,
    ) async {
      setupMock(
        MealsState(
          categoriesState: BaseState<List<MealCategoryEntity>>.error(
            'no network',
          ),
          mealsState: BaseState.init(),
          selectedCategoryIndex: 0,
        ),
      );
      await tester.pumpWidget(buildSubject());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(LottieError), findsOneWidget);
      expect(find.text('no network'), findsOneWidget);

      final lottieErrorWidget = tester.widget<LottieError>(
        find.byType(LottieError),
      );
      lottieErrorWidget.onRetry();
      await tester.pump();

      verify(
        mockViewModel.doIntent(argThat(isA<GetMealsCategoriesIntent>())),
      ).called(1);
    });
  });
}
