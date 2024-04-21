import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle googleFontStyle({
  String font = 'Dosis',
  double? fontSize,
  Color? fontColor,
  FontWeight? fontWeight = FontWeight.normal,
  FontStyle? fontStyle,
}) =>
    GoogleFonts.getFont(
      font,
      color: fontColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
    );
