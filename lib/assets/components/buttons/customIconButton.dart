import 'package:flutter/material.dart';
import 'package:app/assets/StyleFrom.dart';

final double defaultBorderRadius = 8.0;
final double defaultPadding = 14.0;

enum IconButtonSize { XSmall, Small }

Map buttonStyleStyles = {
  IconButtonSize.XSmall: {
    'height': 8.0,
    'borderRadius': 8.0,
    'iconSize': 12.0,
  },
  IconButtonSize.Small: {
    'height': 32.0,
    'borderRadius': 8.0,
    'iconSize': 25.0,
  },
};

class CustomIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final IconButtonSize size;
  final Color? backgroundColor;
  final Color? iconColor;
  final bool isCircularButton;

  CustomIconButton({
    required this.onPressed,
    required this.icon,
    required this.size,
    required this.isCircularButton,
    this.iconColor,
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
        size: isCircularButton ? buttonStyleStyles[size]["iconSize"] - 10 : buttonStyleStyles[size]["iconSize"],
        color: iconColor ?? Colors.white,
      ),
    );
  }
}

class CircularIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  
  final Color? backgroundColor;
  final Color? iconColor;
  final double? height;
  final double? iconSize;

  CircularIconButton({
    required this.icon,
    required this.onPressed,
    this.iconColor,
    this.backgroundColor,
    this.height,
    this.iconSize
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: height,
      child: MaterialButton(
        height: height,
        elevation: 0,
        color: this.backgroundColor ?? Theme.of(context).primaryColor,
        disabledColor: colorFrom(
          Theme.of(context).primaryColor,
          opacity: 0.5,
        ),
        onPressed: onPressed,
        shape: CircleBorder(),
        padding: EdgeInsets.all(0),
        child: Icon(
          icon,
          size: iconSize, 
          color: iconColor ?? Colors.white,
        ),
      )
    );
  }
}
