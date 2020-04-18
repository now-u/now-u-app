import 'package:flutter/material.dart';

const double ICON_PADDING = 30;
const double ITEM_HORIZONTAL = 20;
const double ITEM_VERTICAL = 30;

class ProfileTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(ITEM_HORIZONTAL, ITEM_VERTICAL, ITEM_HORIZONTAL, ITEM_VERTICAL),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding( 
              padding: EdgeInsets.only(right: ICON_PADDING),
              child: Icon(Icons.person, size: 60,)
          ),
          Text("Hello", style: Theme.of(context).primaryTextTheme.title),
        ],
      ),
    );
  }
}
