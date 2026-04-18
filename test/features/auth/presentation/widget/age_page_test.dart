import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:super_fitness/features/auth/domain/entities/register_form_data.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_view_model.dart';
import 'package:super_fitness/core/theme/app_theme/dark_theme.dart';
import 'package:super_fitness/features/auth/presentation/widget/age_page.dart';
import 'package:super_fitness/features/auth/presentation/widget/custom_data_packer.dart';

@GenerateMocks([RegisterViewModel])
import 'age_page_test.mocks.dart';

void main() {
  late MockRegisterViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockRegisterViewModel();
    when(mockViewModel.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget createWidgetUnderTest(int initialAgeInState) {
    when(mockViewModel.state).thenReturn(
      RegisterState.init().copyWith(
        formData: RegisterFormData(age: initialAgeInState),
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
          child: const AgePage(),
        ),
      ),
    );
  }

  group('AgePage Widget Tests', () {
    testWidgets('Should display default age 24 when saved age in state is 0', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest(0));
      expect(find.text('24'), findsOneWidget);
    });

    testWidgets('Should display initial age from ViewModel when it is not 0', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest(35));
      expect(find.text('35'), findsOneWidget);
    });

    testWidgets('Should render all essential components', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(24));
      expect(find.byType(CustomDataPicker), findsOneWidget);
      expect(find.byType(NumberPicker), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets(
      'Should trigger SwitchViewToSelectAge intent when Next is pressed',
      (tester) async {
        await tester.pumpWidget(createWidgetUnderTest(24));

        final nextButton = find.byType(ElevatedButton);
        await tester.tap(nextButton);
        await tester.pumpAndSettle();

        verify(mockViewModel.doIntent(any)).called(1);
      },
    );

    testWidgets('Should update age when NumberPicker changes', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(24));
      final numberPicker = find.byType(NumberPicker);

      await tester.drag(numberPicker, const Offset(-100, 0));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(ElevatedButton));
      verify(mockViewModel.doIntent(any)).called(1);
    });
  });
}
