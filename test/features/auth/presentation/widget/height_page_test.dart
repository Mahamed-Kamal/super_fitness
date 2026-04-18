import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/features/auth/domain/entities/register_form_data.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_view_model.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_intent.dart';
import 'package:super_fitness/features/auth/presentation/widget/custom_data_packer.dart';
import 'package:super_fitness/core/theme/app_theme/dark_theme.dart';
import 'package:super_fitness/features/auth/presentation/widget/height_page.dart';

import 'height_page_test.mocks.dart';

@GenerateMocks([RegisterViewModel])
void main() {
  late MockRegisterViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockRegisterViewModel();
    when(mockViewModel.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget createWidgetUnderTest(int savedHeight) {
    when(mockViewModel.state).thenReturn(
      RegisterState.init().copyWith(
        formData: RegisterFormData(height: savedHeight),
      ),
    );

    return MaterialApp(
      theme: DarkTheme().themeData,
      home: Scaffold(
        body: BlocProvider<RegisterViewModel>.value(
          value: mockViewModel,
          child: const HeightPage(),
        ),
      ),
    );
  }

  group('HeightPage Widget Tests', () {
    testWidgets('Should load initial height from state if it is not zero', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest(175));
      await tester.pumpAndSettle();

      final picker = tester.widget<CustomDataPicker>(
        find.byType(CustomDataPicker),
      );
      expect(picker.initialValue, 175);
    });

    testWidgets('Should use default height 180 if state height is zero', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest(0));
      await tester.pumpAndSettle();

      final picker = tester.widget<CustomDataPicker>(
        find.byType(CustomDataPicker),
      );
      expect(picker.initialValue, 180);
    });

    testWidgets('Should update height value when picker changes', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest(180));
      await tester.pumpAndSettle();

      final pickerFinder = find.byType(CustomDataPicker);
      final CustomDataPicker pickerWidget = tester.widget(pickerFinder);

      pickerWidget.onValueChanged(190);
      await tester.pump();

      // Trigger onNext to verify the updated value
      pickerWidget.onNext();

      verify(
        mockViewModel.doIntent(
          argThat(
            isA<SwitchViewToSelectGoal>().having(
              (i) => i.height,
              'height',
              190,
            ),
          ),
        ),
      ).called(1);
    });

    testWidgets(
      'Should trigger SwitchViewToSelectGoal intent with correct value on next',
      (tester) async {
        await tester.pumpWidget(createWidgetUnderTest(185));
        await tester.pumpAndSettle();

        final picker = tester.widget<CustomDataPicker>(
          find.byType(CustomDataPicker),
        );
        picker.onNext();

        verify(
          mockViewModel.doIntent(
            argThat(
              isA<SwitchViewToSelectGoal>().having(
                (i) => i.height,
                'height',
                185,
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
