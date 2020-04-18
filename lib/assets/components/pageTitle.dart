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
              padding: EdgeInsets.all(25),
              child: 
                Text(_title, style: Theme.of(context).primaryTextTheme.title), 
            )
        
      );
  }
}
