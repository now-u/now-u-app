import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double width;
  final double height;
  final double progress;
  final Color doneColor;
  final Color toDoColor;

  final BorderRadius _borderRadius = BorderRadius.all(Radius.circular(15));

  ProgressBar({
    @required this.progress,
    this.width, 
    this.height,
    this.doneColor,
    this.toDoColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            width: width ?? double.infinity,
            height: height ?? 20,
            decoration: BoxDecoration(
              color: toDoColor ?? Colors.yellow,
              borderRadius: _borderRadius,
            ),
          ),
          Container(
            width: (width ?? double.infinity) * progress,
            height: height ?? 20,
            decoration: BoxDecoration(
              color: doneColor ?? Colors.red,
              borderRadius: _borderRadius,
            ),
          ),
        ],
      )
    );
  }
}
