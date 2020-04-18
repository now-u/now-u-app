import 'package:flutter/material.dart';

const double ICON_PADDING = 60;
const double ITEM_HORIZONTAL = 30;
const double ITEM_VERTICAL = 30;

class ProfileTile extends StatelessWidget {
  IconData _iconData;
  String _text;

  ProfileTile(text, iconData) {
    _text = text; 
    _iconData = iconData;
  }
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
              child: Icon(_iconData, size: 50,)
          ),
          Text(_text, style: Theme.of(context).primaryTextTheme.headline),
        ],
      ),
    );
  }
}
