import 'package:flutter/material.dart';

class TextButton extends StatelessWidget {
  final String text;
  final Function onClick;
  final IconData icon;

  TextButton(
    this.text, 
    {
    @required this.onClick,
    this.icon,
    }

  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: onClick,
        child: Row(
          children: <Widget>[
            this.icon != null ? 
              Icon(Icons.chevron_left, size: 25, color: Theme.of(context).primaryColor,)
            : Container(),
            Text(
              text,
              style: TextStyle(
                color: Theme.of(context).buttonColor,
                fontFamily: Theme.of(context).primaryTextTheme.button.fontFamily,
                fontWeight: Theme.of(context).primaryTextTheme.button.fontWeight,
                fontStyle: Theme.of(context).primaryTextTheme.button.fontStyle,
                fontSize: 16,
              ),
            ),

          ],
        ),
      )
    );
  }
}
