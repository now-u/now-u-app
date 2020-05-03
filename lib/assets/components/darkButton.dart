import 'package:flutter/material.dart';

class DarkButton extends StatelessWidget {

  VoidCallback _onPressed;
  String _text;

  DarkButton( 
    String text, 
   {
    @required VoidCallback onPressed,
   } ) {
    _onPressed = onPressed;
    _text = text;
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: _onPressed,
      shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36.0),
          ),
      child: Padding(
            padding: EdgeInsets.all(14),
            child: Text(
              _text,
              style: Theme.of(context).primaryTextTheme.button,
            ),
          ),

    );
  }
}