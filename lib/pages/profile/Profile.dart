import 'package:flutter/material.dart';
import 'package:app/pages/profile/ProfileTile.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              SafeArea(
                child: Text("Your Profile", style: Theme.of(context).primaryTextTheme.title),
                  ),
              Expanded(
                child:
                  ListView(
                    children: <Widget>[
                      ProfileTile(),
                      ProfileTile(),
                      ProfileTile(),
                    ], 
                  ),
              ),
            ]
          )
        );
  }
}

Text sectionTitle(String t, BuildContext context) {
  return Text(t, style: Theme.of(context).primaryTextTheme.headline);
}
