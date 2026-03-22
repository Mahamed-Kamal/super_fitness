import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/core/utils/assets_manager/assets_manager.dart';
import 'package:super_fitness/core/widgets/custom_image_view.dart';

import 'pump_app.dart';

void main() {
  group('ImageTypeExtension', () {
    test('network when http or https', () {
      expect('http://a.com/x'.imageType, ImageType.network);
      expect('https://a.com/x'.imageType, ImageType.network);
    });

    test('svg when path ends with .svg', () {
      expect('assets/x.svg'.imageType, ImageType.svg);
    });

    test('file for file scheme or legacy path', () {
      expect('file:///tmp/x.png'.imageType, ImageType.file);
      expect('com.inlighty.app.inlighty/foo'.imageType, ImageType.file);
    });

    test('png default for other asset paths', () {
      expect('assets/images/x.png'.imageType, ImageType.png);
    });
  });

  testWidgets('null imagePath renders no raster or svg image', (tester) async {
    await tester.pumpWidget(pumpWithDarkTheme(CustomImageView()));

    expect(find.byType(Image), findsNothing);
    expect(find.byType(SvgPicture), findsNothing);
  });

  testWidgets('svg asset renders SvgPicture', (tester) async {
    await tester.pumpWidget(
      pumpWithDarkTheme(
        CustomImageView(
          imagePath: AssetsManager.appLogoSvg,
          width: 48,
          height: 48,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(SvgPicture), findsOneWidget);
  });

  testWidgets('onTap is wired through InkWell', (tester) async {
    var tapped = false;

    await tester.pumpWidget(
      pumpWithDarkTheme(
        CustomImageView(
          imagePath: AssetsManager.appLogoSvg,
          width: 32,
          height: 32,
          onTap: () => tapped = true,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(InkWell));
    await tester.pump();

    expect(tapped, isTrue);
  });
}
