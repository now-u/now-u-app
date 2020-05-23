import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String text;
  final double padding;

  SectionTitle(
    this.text, 
    {
      this.padding
    }
  );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding ?? 0, vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).primaryTextTheme.headline3,
      ),
    );
  }
}
