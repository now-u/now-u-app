import 'package:flutter/material.dart';
import 'package:app/assets/StyleFrom.dart';

class JoinedIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.white,
              size: 20
            ),
            SizedBox(width: 3),
            Text(
              "Joined",
              style: textStyleFrom(
                Theme.of(context).primaryTextTheme.bodyText1,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 5),
          ],
        ),
      )
    );
  }
}
