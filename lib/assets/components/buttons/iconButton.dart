import 'package:app/assets/StyleFrom.dart';
import 'package:app/assets/components/customTile.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final double size;
  final double borderRadius;
  final Color backgroundColor;
  final Color iconColor;
  final bool isCircularButton;

  CustomIconButton({
    this.borderRadius,
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
      height: size,
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
        borderRadius: borderRadius ?? BorderRadius.circular(
            8),
      ),
      padding: isCircularButton
          ? EdgeInsets.all(0)
          : EdgeInsets.symmetric(horizontal: 60.0, vertical: 15.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          icon,
          size: isCircularButton ? 15 : 25,
          color: iconColor ?? Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}