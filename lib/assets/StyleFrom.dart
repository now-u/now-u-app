import 'package:flutter/material.dart';

TextStyle textStyleFrom(
  TextStyle style, {
  FontWeight fontWeight,
  String fontFamily,
  FontStyle fontStyle,
  double fontSize,
  Color color,
  double letterSpacing,
  double height,
}) {
  return TextStyle(
    fontStyle: fontStyle ?? style.fontStyle,
    fontWeight: fontWeight ?? style.fontWeight,
    fontFamily: fontFamily ?? style.fontFamily,
    color: color ?? style.color,
    fontSize: fontSize ?? style.fontSize,
    letterSpacing: letterSpacing ?? style.letterSpacing,
    height: height ?? style.height,
  );
}

Color colorFrom(
  Color color, {
  double opacity,
}) {
  return Color.fromRGBO(
      color.red, color.green, color.blue, opacity ?? color.opacity);
}
