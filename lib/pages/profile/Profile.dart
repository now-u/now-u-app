import 'package:flutter/material.dart';
import 'package:app/pages/profile/ProfileTile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app/assets/components/pageTitle.dart';

var profileTiles = <ProfileTile> [
   ProfileTile("Details", FontAwesomeIcons.solidUser),
   ProfileTile("Progress", FontAwesomeIcons.spinner),
   ProfileTile("Network", FontAwesomeIcons.users),
   ProfileTile("Rewards", FontAwesomeIcons.ribbon),
   ProfileTile("Offers", FontAwesomeIcons.percent),
   ProfileTile("Feedback", FontAwesomeIcons.solidComment),
];


class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
            children: <Widget>[
              PageTitle("Your Profile"),
              Expanded(
                child:
                  ListView.separated(
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: profileTiles.length,
                    itemBuilder: (context, index) => profileTiles[index],
                  ),
              ),
            ]
          );
  }
}

Text sectionTitle(String t, BuildContext context) {
  return Text(t, style: Theme.of(context).primaryTextTheme.headline);
}
