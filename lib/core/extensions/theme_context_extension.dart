import 'package:flutter/material.dart';

import 'theme_extension.dart';

extension ThemeContextExtension on BuildContext {
  AppThemeExtension get appTheme {
    final ext = Theme.of(this).extension<AppThemeExtension>();
    if (ext == null) {
      throw FlutterError(
        'AppThemeExtension not found in ThemeData.extensions.\n'
        'Make sure you pass [appThemeExtension] inside ThemeData(extensions: [...]).',
      );
    }
    return ext;
  }
}
