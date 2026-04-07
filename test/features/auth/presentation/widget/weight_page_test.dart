import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_intent.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_view_model.dart';
import 'package:super_fitness/features/auth/presentation/widget/custom_data_packer.dart';
import 'package:super_fitness/core/theme/app_theme/dark_theme.dart';
import 'package:super_fitness/features/auth/presentation/widget/weight_page.dart';

import 'weight_page_test.mocks.dart';

@GenerateMocks([RegisterViewModel])
void main() {
  late MockRegisterViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockRegisterViewModel();
    when(mockViewModel.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget createWidgetUnderTest({int savedWeight = 0}) {
    when(mockViewModel.state).thenReturn(
      RegisterState.init().copyWith(
        formData: RegisterState.init().formData.copyWith(weight: savedWeight),
      ),
    );

    return MaterialApp(
      theme: DarkTheme().themeData,
      home: Scaffold(
        body: BlocProvider<RegisterViewModel>.value(
          value: mockViewModel,
          child: const WeightPage(),
        ),
      ),
    );
  }

  group('WeightPage Widget Tests', () {
    testWidgets('Should load saved weight from state in initState', (
      tester,
    ) async {
      const savedWeight = 85;
      await tester.pumpWidget(createWidgetUnderTest(savedWeight: savedWeight));
      await tester.pumpAndSettle();

      final picker = tester.widget<CustomDataPicker>(
        find.byType(CustomDataPicker),
      );
      expect(picker.initialValue, savedWeight);
    });

    testWidgets('Should use default weight (70) if no weight is saved', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest(savedWeight: 0));
      await tester.pumpAndSettle();

      final picker = tester.widget<CustomDataPicker>(
        find.byType(CustomDataPicker),
      );
      expect(picker.initialValue, 70);
    });

    testWidgets(
      'Should trigger SwitchViewToSelectHeight with correct weight when Next is pressed',
      (tester) async {
        await tester.pumpWidget(createWidgetUnderTest(savedWeight: 70));
        await tester.pumpAndSettle();

        final picker = tester.widget<CustomDataPicker>(
          find.byType(CustomDataPicker),
        );
        picker.onValueChanged(90); // تغيير الوزن لـ 90
        await tester.pumpAndSettle();

        picker.onNext();
        await tester.pumpAndSettle();

        verify(
          mockViewModel.doIntent(
            argThat(
              isA<SwitchViewToSelectHeight>().having(
                (i) => i.weight,
                'weight',
                90,
              ),
            ),
          ),
        ).called(1);
      },
    );
  });
}
