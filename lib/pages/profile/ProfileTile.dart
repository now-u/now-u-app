import 'package:flutter/material.dart';

const double ICON_PADDING = 22;
const double ITEM_HORIZONTAL = 20;
const double ITEM_VERTICAL = 18;

class ProfileTile extends StatelessWidget {
  final IconData iconData;
  final String text;

  ProfileTile(this.text, this.iconData);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.fromLTRB(ITEM_HORIZONTAL, ITEM_VERTICAL,
                  ITEM_HORIZONTAL, ITEM_VERTICAL),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(right: ICON_PADDING),
                      child: Icon(
                        iconData,
                        size: 25,
                        color: Theme.of(context).primaryColor,
                      )),
                  Text(text,
                      style: Theme.of(context).primaryTextTheme.headline4),
                ],
              ),
            )));
  }
}
