import 'package:flutter/material.dart';

class TextButton extends StatelessWidget {
  final String text;
  final Function onClick;
  final bool iconRight;
  final bool iconLeft;
  final double fontSize;

  TextButton(
    this.text, 
    {
    @required this.onClick,
    this.iconRight,
    this.iconLeft,
    this.fontSize,
    }

  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: onClick,
        child: Row(
          children: <Widget>[
            this.iconLeft != null ? 
              Icon(Icons.chevron_left, size: 25, color: Theme.of(context).primaryColor,)
            : Container(),
            Expanded (
              child: Text(
                text,
                style: TextStyle(
                  color: Theme.of(context).buttonColor,
                  fontFamily: Theme.of(context).primaryTextTheme.button.fontFamily,
                  fontWeight: Theme.of(context).primaryTextTheme.button.fontWeight,
                  fontStyle: Theme.of(context).primaryTextTheme.button.fontStyle,
                  fontSize: fontSize ?? 16,
                ),
              )
            ),
            this.iconRight != null ? 
              Icon(Icons.chevron_right, size: 25, color: Theme.of(context).primaryColor,)
            : Container(),

          ],
        ),
      )
    );
  }
}
