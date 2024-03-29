import 'package:flutter/material.dart';

final double defaultBorderRadius = 8.0;
final double defaultPadding = 14.0;

enum ButtonSize { Small, Medium, Large }

enum ButtonStyle { Primary, Secondary, Outline }

Map buttonStyleStyles = {
  ButtonSize.Small: {
    'style': ButtonSize.Small,
    'height': 32.0,
    'borderRadius': 8.0,
    'fontSize': 14.0,
    'hPadding': 8,
    'vPadding': 8,
  },
  ButtonSize.Medium: {
    'style': ButtonSize.Medium,
    'height': 40.0,
    'borderRadius': 8.0,
    'fontSize': 17.0,
    'hPadding': 16.0,
    'vPadding': 8.0,
  },
  ButtonSize.Large: {
    'style': ButtonSize.Large,
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
  final IconData? rightIcon;
  final ButtonSize size;
  final double buttonWidthProportion;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;

  CustomWidthButton(
    this.text, {
    required this.onPressed,
    required this.size,
    required this.buttonWidthProportion,
    this.fontSize,
    this.rightIcon,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * buttonWidthProportion,
      child: MaterialButton(
        height: buttonStyleStyles[size]['height'],
        minWidth: buttonWidthProportion,
        elevation: 0,
        // TODO Why are these colors not coming from buttonTheme?
        // TODO Do we ever use background color?
        color: this.backgroundColor ?? Theme.of(context).colorScheme.primary,
        // disabledColor: colorFrom(
        //   Theme.of(context).primaryColor,
        //   opacity: 0.5,
        // ),
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(buttonStyleStyles[size]['borderRadius']),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: buttonStyleStyles[size]['vPadding'],
            horizontal: buttonStyleStyles[size]['hPadding'],
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: textColor ?? Colors.white,
                  fontSize: fontSize ?? buttonStyleStyles[size]['fontSize'],
                ),
          ),
        ),
      ),
    );
  }
}
