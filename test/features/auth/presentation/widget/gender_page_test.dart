import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/features/auth/domain/entities/register_form_data.dart';
import 'package:super_fitness/features/auth/presentation/widget/gender_page.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_view_model.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_intent.dart';
import 'package:super_fitness/features/auth/domain/entities/user_gender.dart';
import 'package:super_fitness/core/theme/app_theme/dark_theme.dart';
import 'gender_page_test.mocks.dart';

@GenerateMocks([RegisterViewModel])
void main() {
  late MockRegisterViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockRegisterViewModel();
    when(mockViewModel.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget createWidgetUnderTest(String savedGender) {
    when(mockViewModel.state).thenReturn(
      RegisterState.init().copyWith(
        formData: RegisterFormData(gender: savedGender),
      ),
    );

    return MaterialApp(
      theme: DarkTheme().themeData,
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      home: Scaffold(
        body: BlocProvider<RegisterViewModel>.value(
          value: mockViewModel,
          child: const GenderPage(),
        ),
      ),
    );
  }

  group('GenderPage Widget Tests', () {
    testWidgets('Next button should be disabled when no gender is selected', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest(""));

      final nextButton = tester.widget<ElevatedButton>(
        find.byType(ElevatedButton),
      );
      expect(nextButton.onPressed, isNull);
    });

    testWidgets('Should select Male gender and enable Next button on tap', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest(""));

      await tester.tap(find.text('male'.tr()));
      await tester.pumpAndSettle();

      final nextButton = tester.widget<ElevatedButton>(
        find.byType(ElevatedButton),
      );
      expect(nextButton.onPressed, isNotNull);
    });

    testWidgets('Should display saved gender from ViewModel state', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest("female"));

      final nextButton = tester.widget<ElevatedButton>(
        find.byType(ElevatedButton),
      );
      expect(nextButton.onPressed, isNotNull);
    });

    testWidgets(
      'Should trigger SwitchViewToSelectWeight intent when Next is pressed',
      (tester) async {
        await tester.pumpWidget(createWidgetUnderTest("male"));

        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        verify(
          mockViewModel.doIntent(
            argThat(
              isA<SwitchViewToSelectWeight>().having(
                (i) => i.userGender,
                'userGender',
                UserGender.male,
              ),
            ),
          ),
        ).called(1);
      },
    );

    testWidgets(
      'Selection should switch when tapping from one gender to another',
      (tester) async {
        await tester.pumpWidget(createWidgetUnderTest(""));

        await tester.tap(find.text('male'.tr()));
        await tester.pumpAndSettle();

        await tester.tap(find.text('female'.tr()));
        await tester.pumpAndSettle();

        await tester.tap(find.byType(ElevatedButton));
        verify(
          mockViewModel.doIntent(
            argThat(
              isA<SwitchViewToSelectWeight>().having(
                (i) => i.userGender,
                'userGender',
                UserGender.female,
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
