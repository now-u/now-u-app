import 'package:flutter/material.dart';

IconData _iconData;
String _text;
Icon _icon;

// TODO this doesnt actually do anything
const double TB_PADDING = 80;

class CustomFloatingActionButton extends StatelessWidget {
  CustomFloatingActionButton({icon, text}) {
    _iconData = icon;
    _text = text;
  }

  @override
  Widget build(BuildContext context) {
    if (_iconData == null) {
      _icon = null;
    } else {
      _icon = Icon(_iconData, size: 30);
    }
    return Padding(
      padding: EdgeInsets.all(14),
      child: FloatingActionButton.extended(
        label: Padding(
          padding: EdgeInsets.fromLTRB(10, TB_PADDING, 20, TB_PADDING),
          child: Text(_text, style: Theme.of(context).primaryTextTheme.button),
        ),
        icon: Padding(
          padding: EdgeInsets.fromLTRB(20, TB_PADDING, 0, TB_PADDING),
          child: _icon,
        ),
        backgroundColor: Theme.of(context).primaryColorDark,
        onPressed: ((){}),
      ),
    );
  }
}
