import 'package:flutter/material.dart';
import 'package:nowu/assets/constants.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final Function onClick;
  final iconRight;
  final iconLeft;
  final double? fontSize;
  final Color? fontColor;
  final FontWeight? fontWeight;

  // Handy to make text wrap
  final double? width;

  CustomTextButton(
    this.text, {
    required this.onClick,
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
        onTap: onClick as void Function()?,
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
                  color: fontColor ?? CustomColors.brandColor,
                  fontFamily:
                      Theme.of(context).textTheme.labelLarge!.fontFamily,
                  fontWeight: fontWeight ??
                      Theme.of(context).textTheme.labelLarge!.fontWeight,
                  fontStyle: Theme.of(context).textTheme.labelLarge!.fontStyle,
                  fontSize: fontSize ?? 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            this.iconRight != null
                ? Icon(
                    Icons.chevron_right,
                    size: 25,
                    color: Theme.of(context).primaryColor,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
