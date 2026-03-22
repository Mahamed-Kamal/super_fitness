import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/core/widgets/glass_container.dart';

import 'pump_app.dart';

void main() {
  testWidgets('renders child inside glass container', (tester) async {
    await tester.pumpWidget(
      pumpWithDarkTheme(const GlassContainer(child: Text('inside'))),
    );

    expect(find.text('inside'), findsOneWidget);
    expect(find.byType(BackdropFilter), findsOneWidget);
  });

  testWidgets('applies custom corner radii', (tester) async {
    await tester.pumpWidget(
      pumpWithDarkTheme(
        GlassContainer(
          topLeft: const Radius.circular(0),
          topRight: const Radius.circular(0),
          bottomLeft: const Radius.circular(8),
          bottomRight: const Radius.circular(8),
          child: const SizedBox(width: 10, height: 10),
        ),
      ),
    );

    final clip = tester.widget<ClipRRect>(find.byType(ClipRRect));
    expect(
      clip.borderRadius,
      const BorderRadius.only(
        topLeft: Radius.zero,
        topRight: Radius.zero,
        bottomLeft: Radius.circular(8),
        bottomRight: Radius.circular(8),
      ),
    );
  });
}
