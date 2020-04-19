import 'package:flutter/material.dart';

const double ICON_SIZE = 65;
const double TOP_PADDING = 30;
const double BOTTOM_PADDING = 20;

class PageTitle extends StatelessWidget {
  String _title;
  bool _hasBackButton = false;
  GestureTapCallback _onClickBackButton;

  PageTitle (title, { hasBackButton, onClickBackButton} ) {
    _title = title; 
    _hasBackButton = hasBackButton != null ? hasBackButton : false;
    _onClickBackButton = onClickBackButton;
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: TOP_PADDING,),
          child: GestureDetector(
            onTap: _onClickBackButton,
            child:Icon(Icons.chevron_left, size: _hasBackButton ? ICON_SIZE : 0,), 
          )
        ),
        SafeArea(
            child: Padding(
                padding: EdgeInsets.fromLTRB(0, TOP_PADDING, 0, BOTTOM_PADDING),
                child: 
                  Text(_title, style: Theme.of(context).primaryTextTheme.title), 
            ),
        ),
        Container(width: _hasBackButton ? ICON_SIZE : 0, height: 0,)
      ], 
    );
  }
}
