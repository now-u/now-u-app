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
        child: Text(
          text,
          style: TextStyle(
            color: Theme.of(context).buttonColor,
            fontFamily: Theme.of(context).primaryTextTheme.button.fontFamily,
            fontWeight: Theme.of(context).primaryTextTheme.button.fontWeight,
            fontSize: 16,
          ),
        ),
      )
    );
  }
}
