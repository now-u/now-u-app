import 'package:app/assets/StyleFrom.dart';
import 'package:app/assets/components/customTile.dart';
import 'package:flutter/material.dart';

final double defaultBorderRadius = 8.0;
final double defaultPadding = 14.0;

enum DarkButtonSize { Small, Medium, Large }
enum DarkButtonStyle { Primary, Secondary, Outline }

Map darkButtonStyleStyles = {
  DarkButtonSize.Small: {
    'style': DarkButtonSize.Small,
    'height': 32.0,
    'borderRadius': 8.0,
    'fontSize': 14.0,
    'hPadding': 8,
    'vPadding': 8,
  },
  DarkButtonSize.Medium: {
    'style': DarkButtonSize.Medium,
    'height': 40.0,
    'borderRadius': 8.0,
    'fontSize': 17.0,
    'hPadding': 16.0,
    'vPadding': 8.0,
  },
  DarkButtonSize.Large: {
    'style': DarkButtonSize.Large,
    'height': 48.0,
    'borderRadius': 8.0,
    'fontSize': 17.0,
    'hPadding': 16.0,
    'vPadding': 8.0,
  },
};

class CustomWidthButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData rightIcon;
  final DarkButtonSize size;
  final double fontSize;
  final double buttonWidthProportion;
  final Color backgroundColor;
  final Color textColor;

  CustomWidthButton(this.text,
      {@required this.onPressed,
        this.rightIcon,
        @required this.size,
        @required this.fontSize,
        @required this.buttonWidthProportion,
        this.backgroundColor,
        this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * buttonWidthProportion,
        child: MaterialButton(
          height: darkButtonStyleStyles[size]['height'],
          minWidth: buttonWidthProportion,
          elevation: 0,
          color: this.backgroundColor ?? Colors.white,
          disabledColor: colorFrom(
            Theme.of(context).primaryColor,
            opacity: 0.5,
          ),
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                darkButtonStyleStyles[size]['borderRadius']),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: darkButtonStyleStyles[size]['vPadding'],
              horizontal: darkButtonStyleStyles[size]['hPadding'],
            ),
            child: Text(
              text,
              style: textStyleFrom(
                Theme.of(context).primaryTextTheme.button,
                color: textColor ?? Colors.white,
                fontSize: fontSize ?? darkButtonStyleStyles[size]['fontSize'],
              ),
            ),
          ),
        ));
  }
}