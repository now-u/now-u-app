import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  final Function onTap;
  final String title;
  final IconData icon;
  PageHeader({
    this.onTap,
    this.title,
    this.icon,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          child: Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: onTap,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(
                    icon,
                    color: Theme.of(context).primaryColor,  
                  ),
                ),
              ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Container(
            width: double.infinity,
            child: Text(
              title,
              textAlign: TextAlign.left,
              style: Theme.of(context).primaryTextTheme.headline2,
            ),
          ),
        ),
      ], 
    );
  }
}
