import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:app/assets/components/pageTitle.dart';
import 'package:app/assets/routes/customRoute.dart';

import 'package:app/models/User.dart';
import 'package:app/models/ViewModel.dart';

import 'package:app/pages/profile/ProfileTile.dart';

import 'package:app/pages/profile/profilePages/DetailsPage.dart';
import 'package:app/pages/profile/profilePages/ProgressPage.dart';
import 'package:app/pages/profile/profilePages/NetworkPage.dart';
import 'package:app/pages/profile/profilePages/RewardsPage.dart';
import 'package:app/pages/profile/profilePages/OffersPage.dart';
import 'package:app/pages/profile/profilePages/FeedbackPage.dart';
import 'package:app/pages/profile/profilePages/SupportPage.dart';

import 'package:app/pages/other/quiz/quizStart.dart';



class Profile extends StatefulWidget {
  final ViewModel model;
  final int currentPage;
  Profile(
   this.model,
   {
   this.currentPage,
   }
  );

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User user;
  ViewModel model;
  var _currentPage;
  @override
  void initState() {
    model = widget.model;
    user = widget.model.user;
    print(widget.currentPage);
    _currentPage = widget.currentPage ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  GestureTapCallback goBack = () {
    setState(() {
      _currentPage = 0;  
    });
  };

  var profileTiles = <Map> [
      {  'profileTile': ProfileTile("Details", FontAwesomeIcons.solidUser) , 'page': DetailsPage(goBack: goBack, model: model, ), },
      {  'profileTile': ProfileTile("Progress", FontAwesomeIcons.spinner), 'page':ProgressPage(goBack, widget.model)},
      {  'profileTile': ProfileTile("Network", FontAwesomeIcons.users) },
      {  'profileTile': ProfileTile("Rewards", FontAwesomeIcons.ribbon), 'page' : RewardsPage(goBack, widget.model) },
      {  'profileTile': ProfileTile("Offers", FontAwesomeIcons.percent), 'page': OffersPage(goBack) },
      {  'profileTile': ProfileTile("Feedback", FontAwesomeIcons.solidComment) },
      {  'profileTile': ProfileTile("Support", FontAwesomeIcons.question), 'page':SupportPage(goBack) },
  ];

    return _currentPage == 0 ? 
        Column(
            children: <Widget>[
              PageTitle("Your Profile"),
              Expanded(
                child:
                  ListView.separated(
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: profileTiles.length,
                    itemBuilder: (context, index) => 
                      GestureDetector(
                        onTap: () => setState(() {
                          _currentPage = index + 1;
                        }),
                        child: profileTiles[index]["profileTile"],
                      ),
                  ),
              ),
              GestureDetector(
                child: ProfileTile("Dev Tools", FontAwesomeIcons.code),
                onTap: () {
                  Navigator.push(
                   context,
                   CustomRoute(builder: (context) => QuizStartPage(0))
                  );
                },
              ),
            ],
          )
        : profileTiles[_currentPage - 1]["page"]
        ;
  }
}

Text sectionTitle(String t, BuildContext context) {
  return Text(t, style: Theme.of(context).primaryTextTheme.headline);
}
