import 'package:flutter/material.dart';

TextStyle textStyleFrom(
  TextStyle style,
  {
    FontWeight fontWeight,
    String fontFamily,
    FontStyle fontStyle,
    double fontSize,
    Color color,
    double letterSpacing,
  }
) {
  return TextStyle(
    fontStyle: fontStyle ?? style.fontStyle,
    fontWeight: fontWeight ?? style.fontWeight,
    fontFamily: fontFamily ?? style.fontFamily,
    color: color ?? style.color,
    fontSize: fontSize ?? style.fontSize,
    letterSpacing: letterSpacing ?? style.letterSpacing,
  );
}
