import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/core/theme/app_theme/dark_theme.dart';
import 'package:super_fitness/features/app_section/view_model/app_section_view_model.dart';
import 'package:super_fitness/features/app_section/views/app_section_view.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  testWidgets('AppSectionView renders with bottom navigation bar', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: DarkTheme().themeData,
        home: BlocProvider(
          create: (context) => AppSectionViewModel(),
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
        home: BlocProvider(
          create: (context) => AppSectionViewModel(),
          child: const AppSectionView(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final element = tester.element(find.byType(AppSectionView));
    final viewModel = BlocProvider.of<AppSectionViewModel>(element);

    for (int i = 0; i < 4; i++) {
      viewModel.doIntent(i);
      await tester.pumpAndSettle();

      final bottomNavBar = tester.widget<BottomNavigationBar>(
        find.byType(BottomNavigationBar),
      );
      expect(bottomNavBar.currentIndex, i);
    }
  });
}
