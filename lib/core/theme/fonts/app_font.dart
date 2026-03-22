import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppFont {
  AppFont._();

  static TextStyle get _style => GoogleFonts.balooThambi2();

  // Headlines

  static TextStyle get semiBold24 =>
      _style.copyWith(fontSize: 24, fontWeight: FontWeight.w600);

  static TextStyle get medium20 =>
      _style.copyWith(fontSize: 20, fontWeight: FontWeight.w500);

  // Titles

  static TextStyle get semiBold18 =>
      _style.copyWith(fontSize: 18, fontWeight: FontWeight.w600);

  static TextStyle get semiBold16 =>
      _style.copyWith(fontSize: 16, fontWeight: FontWeight.w600);

  static TextStyle get medium16 =>
      _style.copyWith(fontSize: 16, fontWeight: FontWeight.w500);

  static TextStyle get medium13 =>
      _style.copyWith(fontSize: 13, fontWeight: FontWeight.w500);

  // Body

  static TextStyle get regular16 =>
      _style.copyWith(fontSize: 16, fontWeight: FontWeight.w400);

  static TextStyle get regular14 =>
      _style.copyWith(fontSize: 14, fontWeight: FontWeight.w400);

  static TextStyle get regular12 =>
      _style.copyWith(fontSize: 12, fontWeight: FontWeight.w400);

  // Labels

  static TextStyle get semiBold12 =>
      _style.copyWith(fontSize: 12, fontWeight: FontWeight.w600);
}
