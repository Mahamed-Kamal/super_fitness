import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_fitness/core/theme/fonts/my_font_weight.dart';

abstract final class AppFont {
  AppFont._();

  static TextStyle get _style => GoogleFonts.balooThambi2();

  // Headlines

  static TextStyle get semiBold24 =>
      _style.copyWith(fontSize: 24, fontWeight: MyFontWeight.semiBold);

  static TextStyle get medium20 =>
      _style.copyWith(fontSize: 20, fontWeight: MyFontWeight.medium);

  // Titles

  static TextStyle get semiBold18 =>
      _style.copyWith(fontSize: 18, fontWeight: MyFontWeight.semiBold);

  static TextStyle get semiBold16 =>
      _style.copyWith(fontSize: 16, fontWeight: MyFontWeight.semiBold);

  static TextStyle get medium16 =>
      _style.copyWith(fontSize: 16, fontWeight: MyFontWeight.medium);

  static TextStyle get medium13 =>
      _style.copyWith(fontSize: 13, fontWeight: MyFontWeight.medium);

  // Body

  static TextStyle get regular16 =>
      _style.copyWith(fontSize: 16, fontWeight: MyFontWeight.regular);

  static TextStyle get regular14 =>
      _style.copyWith(fontSize: 14, fontWeight: MyFontWeight.regular);

  static TextStyle get regular12 =>
      _style.copyWith(fontSize: 12, fontWeight: MyFontWeight.regular);

  // Labels

  static TextStyle get semiBold12 =>
      _style.copyWith(fontSize: 12, fontWeight: MyFontWeight.semiBold);
}
