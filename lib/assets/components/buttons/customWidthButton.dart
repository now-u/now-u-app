import 'package:flutter/material.dart';
import 'package:app/assets/components/buttons/button_styles&sizes.dart';
import 'package:app/assets/StyleFrom.dart';

class CustomWidthButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData rightIcon;
  final ButtonSize size;
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
          height: buttonStyleStyles[size]['height'],
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
                buttonStyleStyles[size]['borderRadius']),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: buttonStyleStyles[size]['vPadding'],
              horizontal: buttonStyleStyles[size]['hPadding'],
            ),
            child: Text(
              text,
              style: textStyleFrom(
                Theme.of(context).primaryTextTheme.button,
                color: textColor ?? Colors.white,
                fontSize: fontSize ?? buttonStyleStyles[size]['fontSize'],
              ),
            ),
          ),
        ));
  }
}