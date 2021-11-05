import 'package:app/assets/StyleFrom.dart';
import 'package:app/assets/components/customTile.dart';
import 'package:flutter/material.dart';

class SelectionPill extends StatelessWidget {
  final String text;
  final bool selected;
  final double? borderRadius;
  final double? fontSize;

  SelectionPill(
    this.text,
    this.selected, {
    this.borderRadius,
    this.fontSize,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
            decoration: selected
                ? BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      customTileBoxShadow(false),
                    ],
                    borderRadius: borderRadius != null
                        ? BorderRadius.all(Radius.circular(borderRadius!))
                        : tileBorderRadius(),
                  )
                : BoxDecoration(
                    color: Color.fromRGBO(222, 224, 232, 1),
                    borderRadius: borderRadius != null
                        ? BorderRadius.all(Radius.circular(borderRadius!))
                        : tileBorderRadius(),
                  ),
            child: Center(
                child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: fontSize ?? 20 / 2, vertical: fontSize ?? 20 / 4),
              child: Text(
                text,
                style: textStyleFrom(
                  Theme.of(context).primaryTextTheme.bodyText1,
                  fontWeight: selected ? FontWeight.w800 : FontWeight.w500,
                  color: selected
                      ? Theme.of(context).primaryColor
                      : Color.fromRGBO(55, 58, 74, 1),
                  fontSize: fontSize ?? 20,
                ),
              ),
            ))));
  }
}
