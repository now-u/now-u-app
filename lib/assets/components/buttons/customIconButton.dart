import 'package:flutter/material.dart';
import 'package:app/assets/components/buttons/button_styles&sizes.dart';
import 'package:app/assets/StyleFrom.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final ButtonSize size;
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
      height: buttonStyleStyles[size]['height'],
      elevation: 0,
      color: this.backgroundColor ?? Theme.of(context).primaryColor,
      disabledColor: colorFrom(
        Theme.of(context).primaryColor,
        opacity: 0.5,
      ),
      onPressed: onPressed,
      shape: isCircularButton
          ? CircleBorder()
          : RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            buttonStyleStyles[size]['borderRadius']),
      ),
      padding: isCircularButton
          ? EdgeInsets.all(0)
          : EdgeInsets.symmetric(horizontal: 60.0, vertical: 15.0),
      child: Icon(
        icon,
        size: isCircularButton ? 15 : 25,
        color: iconColor ?? Colors.white,
      ),
    );
  }
}