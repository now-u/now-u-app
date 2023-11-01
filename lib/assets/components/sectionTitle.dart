import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String text;
  final double? padding;
  final double? vpadding;

  SectionTitle(this.text, {this.padding, this.vpadding});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: padding ?? 0,
        vertical: vpadding ?? 15,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}
