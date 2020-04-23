import 'package:flutter/material.dart';
import 'dart:math' as math;

class SelectionItem extends StatelessWidget {
  final String t;
  final GestureTapCallback onClick;
  SelectionItem(this.t, {this.onClick});
  @override
  Widget build(BuildContext context) {
    return 
    GestureDetector(
     onTap: this.onClick,
     child: 
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(5),
            child: Text(t, style: Theme.of(context).primaryTextTheme.body1,),
          ),
          Transform.rotate(
            angle: 180 * math.pi / 180,
            child: Icon(Icons.chevron_left, size: 25), 
          ),
        ],
      ),   
    );
  }
}

