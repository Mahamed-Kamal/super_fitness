import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/core/theme/app_theme/dark_theme.dart';
import 'package:super_fitness/features/app_section/view_model/app_section_state.dart';
import 'package:super_fitness/features/app_section/view_model/app_section_view_model.dart';
import 'package:super_fitness/features/app_section/views/app_section_view.dart';
import 'package:super_fitness/features/explore/presentation/view_model/explore_state.dart';
import 'package:super_fitness/features/explore/presentation/view_model/explore_view_model.dart';

import 'app_section_view_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AppSectionViewModel>(),
  MockSpec<ExploreViewModel>(),
])
void main() {
  late MockAppSectionViewModel mockViewModel;
  late MockExploreViewModel mockExploreViewModel;
  late AppSectionState currentAppSectionState;
  late StreamController<AppSectionState> appSectionController;
  setUp(() async {
    mockViewModel = MockAppSectionViewModel();
    mockExploreViewModel = MockExploreViewModel();
    appSectionController = StreamController<AppSectionState>.broadcast();

    currentAppSectionState = const AppSectionState(currentIndex: 0);

    // ✅ Correct: Only one stub for the stream
    when(mockViewModel.stream).thenAnswer((_) => appSectionController.stream);
    when(mockViewModel.state).thenAnswer((_) => currentAppSectionState);

    // ✅ Handle close properly
    when(
      mockViewModel.close(),
    ).thenAnswer((_) async => await appSectionController.close());

    final initialState = ExploreState(
      specialMuscles: BaseState.init(),
      exploreData: [],
      index: 0,
    );
    when(mockExploreViewModel.state).thenReturn(initialState);

    // Stub Explore stream and eventStream once
    when(mockExploreViewModel.stream).thenAnswer((_) => const Stream.empty());
    when(
      mockExploreViewModel.eventStream,
    ).thenAnswer((_) => const Stream.empty());
  });

  testWidgets('AppSectionView renders with bottom navigation bar', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: DarkTheme().themeData,
        home: MultiBlocProvider(
          providers: [
            BlocProvider<AppSectionViewModel>.value(value: mockViewModel),
            BlocProvider<ExploreViewModel>.value(
              value: mockExploreViewModel..doIntent(LoadDataEvent()),
            ),
          ],
          child: const AppSectionView(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(BottomNavigationBar), findsOneWidget);

    final bottomNavBar = tester.widget<BottomNavigationBar>(
      find.byType(BottomNavigationBar),
    );
    expect(bottomNavBar.currentIndex, 0);

    await tester.pumpAndSettle();
  });

  testWidgets('Changing index updates bottom navigation bar', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: DarkTheme().themeData,
        home: MultiBlocProvider(
          providers: [
            BlocProvider<AppSectionViewModel>.value(value: mockViewModel),
            BlocProvider<ExploreViewModel>.value(
              value: mockExploreViewModel..doIntent(LoadDataEvent()),
            ),
          ],
          child: const AppSectionView(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    for (int i = 0; i < 4; i++) {
      // 1. Update the local variable (which the mock answer points to)
      currentAppSectionState = currentAppSectionState.copyWith(currentIndex: i);

      // 2. Notify the UI via the stream
      appSectionController.add(currentAppSectionState);

      // 3. Rebuild the widget tree
      await tester.pumpAndSettle();

      final bottomNavBar = tester.widget<BottomNavigationBar>(
        find.byType(BottomNavigationBar),
      );

      expect(bottomNavBar.currentIndex, i);
    }
  });
}
