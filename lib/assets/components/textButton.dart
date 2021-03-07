import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final Function onClick;
  final iconRight;
  final iconLeft;
  final double fontSize;
  final Color fontColor;
  final FontWeight fontWeight;

  // Handy to make text wrap
  final double width;

  CustomTextButton(
    this.text, {
    @required this.onClick,
    this.iconRight,
    this.iconLeft,
    this.fontSize,
    this.width,
    this.fontColor,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GestureDetector(
      onTap: onClick,
      child: Row(
        children: <Widget>[
          this.iconLeft != null
              ? Icon(
                  Icons.chevron_left,
                  size: 25,
                  color: Theme.of(context).primaryColor,
                )
              : Container(),
          Container(
              width: width,
              child: Text(
                text,
                style: TextStyle(
                  color: fontColor ?? Theme.of(context).buttonColor,
                  fontFamily:
                      Theme.of(context).primaryTextTheme.button.fontFamily,
                  fontWeight: fontWeight ??
                      Theme.of(context).primaryTextTheme.button.fontWeight,
                  fontStyle:
                      Theme.of(context).primaryTextTheme.button.fontStyle,
                  fontSize: fontSize ?? 16,
                ),
                textAlign: TextAlign.center,
              )),
          this.iconRight != null
              ? Icon(
                  Icons.chevron_right,
                  size: 25,
                  color: Theme.of(context).primaryColor,
                )
              : Container(),
        ],
      ),
    ));
  }
}
