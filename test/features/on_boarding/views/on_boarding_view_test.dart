import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:super_fitness/core/theme/app_theme/dark_theme.dart';
import 'package:super_fitness/features/on_boarding/views/on_boarding_view.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
  });
  void testPage3() {
    expect(find.byType(OnBoardingView), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(PageView), findsOneWidget);
    expect(find.byType(SmoothPageIndicator), findsOneWidget);
    expect(find.byType(ElevatedButton), findsNWidgets(1));
    expect(find.byType(OutlinedButton), findsNWidgets(1));
    expect(find.byType(Text), findsNWidgets(4));
    expect(find.text("onboarding.back".tr()), findsOneWidget);
    expect(find.text("onboarding.doIt".tr()), findsOneWidget);
    expect(find.byType(Image), findsNWidgets(2));
    expect(
      find.widgetWithText(ElevatedButton, "onboarding.doIt".tr()),
      findsOneWidget,
    );
    expect(find.widgetWithText(Text, "onboarding.skip".tr()), findsNothing);
  }

  void testPage2() {
    expect(find.byType(OnBoardingView), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(PageView), findsOneWidget);
    expect(find.byType(SmoothPageIndicator), findsOneWidget);
    expect(find.byType(ElevatedButton), findsNWidgets(1));
    expect(find.byType(OutlinedButton), findsNWidgets(1));
    expect(find.byType(Text), findsNWidgets(5));
    expect(find.text("onboarding.back".tr()), findsOneWidget);
    expect(find.text("onboarding.next".tr()), findsOneWidget);
    expect(find.byType(Image), findsNWidgets(2));
  }

  void testPage1() {
    expect(find.byType(OnBoardingView), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(PageView), findsOneWidget);
    expect(find.byType(SmoothPageIndicator), findsOneWidget);
    expect(find.byType(ElevatedButton), findsNWidgets(1));
    expect(find.byType(Text), findsNWidgets(4));
    expect(find.text("onboarding.skip".tr()), findsOneWidget);
    expect(find.byType(Image), findsNWidgets(2));
  }

  testWidgets('ui testing on boarding view ', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Super Fitness',
        theme: DarkTheme().themeData,
        themeMode: ThemeMode.dark,
        home: OnBoardingView(),
      ),
    );
    testPage1();
    await tester.tap(
      find.widgetWithText(ElevatedButton, "onboarding.next".tr()),
    );
    await tester.pumpAndSettle();
    testPage2();
    await tester.tap(
      find.widgetWithText(ElevatedButton, "onboarding.next".tr()),
    );
    await tester.pumpAndSettle();
    testPage3();
    await tester.tap(
      find.widgetWithText(OutlinedButton, "onboarding.back".tr()),
    );
    await tester.pumpAndSettle();
    testPage2();
    await tester.tap(
      find.widgetWithText(OutlinedButton, "onboarding.back".tr()),
    );
    await tester.pumpAndSettle();
    testPage1();
    await tester.tap(
      find.widgetWithText(GestureDetector, "onboarding.skip".tr()),
    );
    await tester.pumpAndSettle();
    testPage3();
  });
}
