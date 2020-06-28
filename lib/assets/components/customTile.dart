import 'package:flutter/material.dart';

final Color shadowWhiteColor = Color.fromRGBO(0,45,96,0.08);
final Color shadowColor = Color.fromRGBO(0,0,0,0.08);
final double shadowBlurRadius = 20;
final Offset shadowOffset = Offset(0, 3);

BoxShadow customTileBoxShadow(bool onWhiteBackground) => BoxShadow(
  color: onWhiteBackground ?? false ? shadowWhiteColor : shadowColor,
  offset: shadowOffset,
  blurRadius: shadowBlurRadius,
);

BorderRadius tileBorderRadius({double borderRadius}) => BorderRadius.all(Radius.circular(borderRadius ?? 8));

class CustomTile extends StatelessWidget {
  final Widget child;
  final bool onWhiteBackground;
  final Color color;
  final double borderRadius;
  CustomTile({
    this.child,
    this.onWhiteBackground,
    this.color,
    this.borderRadius,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: tileBorderRadius(borderRadius: borderRadius),
        boxShadow: [
          customTileBoxShadow(
            onWhiteBackground ?? false
          ),
        ]
      ),
      child: ClipRRect(
        borderRadius: tileBorderRadius(borderRadius: borderRadius),
        child: child, 
      ),
    );
  }
}
