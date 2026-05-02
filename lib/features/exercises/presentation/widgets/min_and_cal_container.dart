import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';

class MinAndCalContainer extends StatelessWidget {
  const MinAndCalContainer({
    super.key,
    required this.text,
    required this.color,
  });
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(right: 7, left: 7),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: context.appTheme.surfaceOverlayLow.withAlpha(0),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: context.appTheme.textMuted),
      ),
      child: Text(text, style: GoogleFonts.poppins(color: color)),
    );
  }
}
