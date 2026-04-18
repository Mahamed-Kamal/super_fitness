import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness/core/extensions/context_spacing_extension.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/core/theme/fonts/my_font_weight.dart';

class CustomRichText extends StatelessWidget {
  final String firstText;
  final TextStyle? firstStyle;
  final TextStyle? secondStyle;
  final String secondText;
  final VoidCallback? onClickSecond;
  final TextAlign? textAlign;
  const CustomRichText({
    super.key,
    required this.firstText,
    required this.secondText,
    this.textAlign,
    this.onClickSecond,
    this.firstStyle,
    this.secondStyle,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign ?? TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: firstText,
            style:
                firstStyle ??
                context.appTheme.regular14.copyWith(
                  color: Colors.white,
                  fontWeight: MyFontWeight.extraBold,
                ),
          ),
          WidgetSpan(child: context.w(2)),
          TextSpan(
            text: secondText,
            recognizer: TapGestureRecognizer()..onTap = onClickSecond,
            style:
                secondStyle ??
                context.appTheme.regular14.copyWith(
                  fontWeight: MyFontWeight.extraBold,
                  color: context.appTheme.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: context.appTheme.primary,
                ),
          ),
        ],
      ),
    );
  }
}
