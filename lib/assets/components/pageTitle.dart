import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  String _title;
  PageTitle (title) {
    _title = title; 
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
              child: 
                Text(_title, style: Theme.of(context).primaryTextTheme.title), 
            )
        
      );
  }
}
