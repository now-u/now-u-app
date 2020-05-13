import 'package:app/assets/StyleFrom.dart';
import 'package:flutter/material.dart';

final double defaultBorderRadius = 8.0;
final double defaultPadding = 14.0;

class DarkButton extends StatelessWidget {

  VoidCallback onPressed;
  String text;
  bool inverted;
  double borderRadius;
  double padding;


  DarkButton( 
    String text, 
   {
    @required VoidCallback onPressed,
    bool inverted,
    double padding,
    double borderRadius,
   } ) {
    this.onPressed = onPressed;
    this.text = text;
    this.inverted = inverted ?? false;
    this.padding = padding ?? defaultPadding;
    this.borderRadius = borderRadius ?? defaultBorderRadius;
  }

  @override
  Widget build(BuildContext context) {
    return 
        !inverted ? 
          PrimaryButton(text, onPressed: onPressed, padding: padding, borderRadius: borderRadius) 
        : SecondaryButton(text, onPressed: onPressed, padding:padding, borderRadius: borderRadius);
  }
}

class SecondaryButton extends StatelessWidget {

  VoidCallback onPressed;
  String text;
  double borderRadius;
  double padding;

  SecondaryButton( 
   this.text, 
   {
   @required this.onPressed,
   @required this.borderRadius,
   @required this.padding,
   } 
  );
  
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 0,
      color: Colors.white,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: BorderSide(
          color: Theme.of(context).buttonColor,
          width: 3.0
        ),
      ),
      child: Padding(
            padding: EdgeInsets.all(padding),
            child: Text(
              text,
              style: textStyleFrom(
                Theme.of(context).primaryTextTheme.button,
                color: Theme.of(context).buttonColor,
              ),
            ),
          ),

    );
  }
}

class PrimaryButton extends StatelessWidget {

  VoidCallback onPressed;
  String text;
  double borderRadius;
  double padding;

  PrimaryButton( 
   this.text, 
   {
   @required this.onPressed,
   @required this.borderRadius,
   @required this.padding,
   } 
  );
  
  @override
  Widget build(BuildContext context) {
    return RaisedButton(

      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Padding(
            padding: EdgeInsets.all(padding),
            child: Text(
              text,
              style: textStyleFrom(
                Theme.of(context).primaryTextTheme.button,
                color: Colors.white,
              ),
            ),
          ),

    );
  }
}

