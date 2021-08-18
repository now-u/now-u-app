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


class CustomIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final DarkButtonSize size;
  final Color backgroundColor;
  final Color iconColor;
  final bool isCircularButton;

  CustomIconButton({
    @required this.onPressed,
    @required this.icon,
    this.iconColor,
    @required this.size,
    @required this.isCircularButton,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: darkButtonStyleStyles[size]['height'],
      elevation: 0,
      color: this.backgroundColor ?? Colors.white,
      disabledColor: colorFrom(
        Theme.of(context).primaryColor,
        opacity: 0.5,
      ),
      onPressed: onPressed,
      shape: isCircularButton
          ? CircleBorder()
          : RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            darkButtonStyleStyles[size]['borderRadius']),
      ),
      padding: isCircularButton
          ? EdgeInsets.all(0)
          : EdgeInsets.symmetric(horizontal: 60.0, vertical: 15.0),
      child: Padding(
        padding: isCircularButton ? const EdgeInsets.all(5) : EdgeInsets.all(0),
        child: Icon(
          icon,
          size: isCircularButton ? 15 : 25,
          color: iconColor ?? Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}