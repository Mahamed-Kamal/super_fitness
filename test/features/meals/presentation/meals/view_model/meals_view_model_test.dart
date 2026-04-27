import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/meals/domain/entities/meal_category_entity.dart';
import 'package:super_fitness/features/meals/domain/entities/meal_entity.dart';
import 'package:super_fitness/features/meals/domain/use_cases/get_meals_by_category_use_case.dart';
import 'package:super_fitness/features/meals/domain/use_cases/get_meals_categories_use_case.dart';
import 'package:super_fitness/features/meals/presentation/meals/view_model/meals_intent.dart';
import 'package:super_fitness/features/meals/presentation/meals/view_model/meals_view_model.dart';

import 'meals_view_model_test.mocks.dart';

@GenerateMocks([GetMealsCategoriesUseCase, GetMealsByCategoryUseCase])
void main() {
  late MockGetMealsCategoriesUseCase mockCategoriesUseCase;
  late MockGetMealsByCategoryUseCase mockByCategoryUseCase;
  late MealsViewModel viewModel;

  final catA = const MealCategoryEntity(id: 'a', name: 'Chicken');
  final catB = const MealCategoryEntity(id: 'b', name: 'Beef');
  final meal = const MealEntity(id: '1', name: 'Grilled');

  const err = 'errors.connectionError';

  setUp(() {
    mockCategoriesUseCase = MockGetMealsCategoriesUseCase();
    mockByCategoryUseCase = MockGetMealsByCategoryUseCase();
    viewModel = MealsViewModel(mockCategoriesUseCase, mockByCategoryUseCase);
  });

  tearDown(() async {
    await viewModel.close();
  });

  group('MealsViewModel', () {
    blocTest<MealsViewModel, MealsState>(
      'GetMealsCategoriesIntent: emits loading then loaded and loads meals for first category',
      build: () => viewModel,
      setUp: () {
        final catsOk = SuccessResponse<List<MealCategoryEntity>>(
          data: [catA, catB],
        );
        final mealsOk = SuccessResponse<List<MealEntity>>(data: [meal]);
        provideDummy<Result<List<MealCategoryEntity>>>(catsOk);
        provideDummy<Result<List<MealEntity>>>(mealsOk);
        when(mockCategoriesUseCase.call()).thenAnswer((_) async => catsOk);
        when(
          mockByCategoryUseCase.call(category: 'Chicken'),
        ).thenAnswer((_) async => mealsOk);
      },
      act: (vm) => vm.doIntent(const GetMealsCategoriesIntent()),
      expect: () => [
        MealsState(
          categoriesState: BaseState<List<MealCategoryEntity>>.loading(),
          mealsState: BaseState.init(),
          selectedCategoryIndex: 0,
        ),
        MealsState(
          categoriesState: BaseState.loaded([catA, catB]),
          mealsState: BaseState.init(),
          selectedCategoryIndex: 0,
        ),
        MealsState(
          categoriesState: BaseState.loaded([catA, catB]),
          mealsState: BaseState<List<MealEntity>>.loading(),
          selectedCategoryIndex: 0,
        ),
        MealsState(
          categoriesState: BaseState.loaded([catA, catB]),
          mealsState: BaseState.loaded([meal]),
          selectedCategoryIndex: 0,
        ),
      ],
    );

    blocTest<MealsViewModel, MealsState>(
      'GetMealsCategoriesIntent: empty categories skips meals fetch',
      build: () => viewModel,
      setUp: () {
        final catsOk = SuccessResponse<List<MealCategoryEntity>>(data: []);
        provideDummy<Result<List<MealCategoryEntity>>>(catsOk);
        when(mockCategoriesUseCase.call()).thenAnswer((_) async => catsOk);
      },
      act: (vm) => vm.doIntent(const GetMealsCategoriesIntent()),
      expect: () => [
        MealsState(
          categoriesState: BaseState<List<MealCategoryEntity>>.loading(),
          mealsState: BaseState.init(),
          selectedCategoryIndex: 0,
        ),
        MealsState(
          categoriesState: BaseState.loaded(<MealCategoryEntity>[]),
          mealsState: BaseState.init(),
          selectedCategoryIndex: 0,
        ),
      ],
      verify: (_) {
        verifyZeroInteractions(mockByCategoryUseCase);
      },
    );

    blocTest<MealsViewModel, MealsState>(
      'GetMealsCategoriesIntent: meals fetch fails after categories load',
      build: () => viewModel,
      setUp: () {
        final catsOk = SuccessResponse<List<MealCategoryEntity>>(
          data: [catA, catB],
        );
        final mealsFail = FailureResponse<List<MealEntity>>(errorMessage: err);
        provideDummy<Result<List<MealCategoryEntity>>>(catsOk);
        provideDummy<Result<List<MealEntity>>>(mealsFail);
        when(mockCategoriesUseCase.call()).thenAnswer((_) async => catsOk);
        when(
          mockByCategoryUseCase.call(category: 'Chicken'),
        ).thenAnswer((_) async => mealsFail);
      },
      act: (vm) => vm.doIntent(const GetMealsCategoriesIntent()),
      expect: () => [
        MealsState(
          categoriesState: BaseState<List<MealCategoryEntity>>.loading(),
          mealsState: BaseState.init(),
          selectedCategoryIndex: 0,
        ),
        MealsState(
          categoriesState: BaseState.loaded([catA, catB]),
          mealsState: BaseState.init(),
          selectedCategoryIndex: 0,
        ),
        MealsState(
          categoriesState: BaseState.loaded([catA, catB]),
          mealsState: BaseState<List<MealEntity>>.loading(),
          selectedCategoryIndex: 0,
        ),
        MealsState(
          categoriesState: BaseState.loaded([catA, catB]),
          mealsState: BaseState<List<MealEntity>>.error(err),
          selectedCategoryIndex: 0,
        ),
      ],
    );

    blocTest<MealsViewModel, MealsState>(
      'GetMealsCategoriesIntent: categories failure',
      build: () => viewModel,
      setUp: () {
        final fail = FailureResponse<List<MealCategoryEntity>>(
          errorMessage: err,
        );
        provideDummy<Result<List<MealCategoryEntity>>>(fail);
        when(mockCategoriesUseCase.call()).thenAnswer((_) async => fail);
      },
      act: (vm) => vm.doIntent(const GetMealsCategoriesIntent()),
      expect: () => [
        MealsState(
          categoriesState: BaseState<List<MealCategoryEntity>>.loading(),
          mealsState: BaseState.init(),
          selectedCategoryIndex: 0,
        ),
        MealsState(
          categoriesState: BaseState<List<MealCategoryEntity>>.error(err),
          mealsState: BaseState.init(),
          selectedCategoryIndex: 0,
        ),
      ],
    );

    blocTest<MealsViewModel, MealsState>(
      'SelectMealCategoryIntent: same index does nothing',
      build: () => viewModel,
      seed: () => MealsState(
        categoriesState: BaseState.loaded([catA, catB]),
        mealsState: BaseState.loaded([meal]),
        selectedCategoryIndex: 0,
      ),
      act: (vm) => vm.doIntent(const SelectMealCategoryIntent(0)),
      expect: () => <MealsState>[],
      verify: (_) {
        verifyZeroInteractions(mockByCategoryUseCase);
      },
    );

    blocTest<MealsViewModel, MealsState>(
      'SelectMealCategoryIntent: new index reloads meals',
      build: () => viewModel,
      seed: () => MealsState(
        categoriesState: BaseState.loaded([catA, catB]),
        mealsState: BaseState.loaded([meal]),
        selectedCategoryIndex: 0,
      ),
      setUp: () {
        final mealsOk = SuccessResponse<List<MealEntity>>(
          data: [const MealEntity(id: '2', name: 'Steak')],
        );
        provideDummy<Result<List<MealEntity>>>(mealsOk);
        when(
          mockByCategoryUseCase.call(category: 'Beef'),
        ).thenAnswer((_) async => mealsOk);
      },
      act: (vm) => vm.doIntent(const SelectMealCategoryIntent(1)),
      expect: () => [
        MealsState(
          categoriesState: BaseState.loaded([catA, catB]),
          mealsState: BaseState<List<MealEntity>>.loading(),
          selectedCategoryIndex: 1,
        ),
        MealsState(
          categoriesState: BaseState.loaded([catA, catB]),
          mealsState: BaseState.loaded([
            const MealEntity(id: '2', name: 'Steak'),
          ]),
          selectedCategoryIndex: 1,
        ),
      ],
    );

    blocTest<MealsViewModel, MealsState>(
      'GetMealsByCategoryIntent: retries meals for current category',
      build: () => viewModel,
      seed: () => MealsState(
        categoriesState: BaseState.loaded([catA, catB]),
        mealsState: BaseState.error(err),
        selectedCategoryIndex: 1,
      ),
      setUp: () {
        final mealsOk = SuccessResponse<List<MealEntity>>(data: [meal]);
        provideDummy<Result<List<MealEntity>>>(mealsOk);
        when(
          mockByCategoryUseCase.call(category: 'Beef'),
        ).thenAnswer((_) async => mealsOk);
      },
      act: (vm) => vm.doIntent(const GetMealsByCategoryIntent()),
      expect: () => [
        MealsState(
          categoriesState: BaseState.loaded([catA, catB]),
          mealsState: BaseState<List<MealEntity>>.loading(),
          selectedCategoryIndex: 1,
        ),
        MealsState(
          categoriesState: BaseState.loaded([catA, catB]),
          mealsState: BaseState.loaded([meal]),
          selectedCategoryIndex: 1,
        ),
      ],
    );

    blocTest<MealsViewModel, MealsState>(
      'MealCardClickedIntent emits NavigateToMealsDetails on uiEventsStream',
      build: () => viewModel,
      act: (vm) {
        expectLater(
          vm.uiEventsStream,
          emits(predicate<NavigateToMealsDetails>((e) => e.meal == meal)),
        );
        vm.doIntent(MealCardClickedIntent(meal));
      },
      expect: () => <MealsState>[],
    );
  });
}
