import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/core/theme/app_theme/dark_theme.dart';
import 'package:super_fitness/features/meals/presentation/meal_details/meal_details_view.dart';
import 'package:super_fitness/features/meals/presentation/meal_details/view_model/meal_details_intent.dart';
import 'package:super_fitness/features/meals/presentation/meal_details/view_model/meal_details_state.dart';
import 'package:super_fitness/features/meals/presentation/meal_details/view_model/meal_details_view_model.dart';

class MockMealDetailsViewModel
    extends MockBloc<MealDetailsIntent, MealDetailsState>
    implements MealDetailsViewModel {}

void main() {
  late MockMealDetailsViewModel mockViewModel;
  const testId = '123';

  setUp(() {
    mockViewModel = MockMealDetailsViewModel();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      theme: DarkTheme().themeData,
      home: BlocProvider<MealDetailsViewModel>.value(
        value: mockViewModel,
        child: const MealDetailsView(id: testId, meals: [],),
      ),
    );
  }

  group('MealDetailsView Tests', () {
    testWidgets('should display loader when state is loading', (tester) async {
      whenListen(
        mockViewModel,
        Stream.fromIterable([
          const MealDetailsState(requestState: RequestState.loading),
        ]),
        initialState: const MealDetailsState(
          requestState: RequestState.loading,
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
