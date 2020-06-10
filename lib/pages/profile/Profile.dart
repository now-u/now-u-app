import 'package:app/assets/StyleFrom.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:app/assets/components/pageTitle.dart';
import 'package:app/assets/components/customAppBar.dart';
import 'package:app/assets/routes/customRoute.dart';

import 'package:app/models/User.dart';
import 'package:app/models/ViewModel.dart';
import 'package:app/models/State.dart';

import 'package:app/pages/profile/ProfileTile.dart';
import 'package:app/pages/Tabs.dart';
import 'package:app/routes.dart';

import 'package:app/pages/profile/profilePages/DetailsPage.dart';
import 'package:app/pages/profile/profilePages/AboutPage.dart';
import 'package:app/pages/profile/profilePages/PartnersPage.dart';
import 'package:app/pages/profile/profilePages/ProfilePage.dart';
import 'package:app/pages/profile/profilePages/ProgressPage.dart';
import 'package:app/pages/profile/profilePages/RewardsPage.dart';
import 'package:app/pages/profile/profilePages/OffersPage.dart';
import 'package:app/pages/profile/profilePages/FeedbackPage.dart';
import 'package:app/pages/profile/profilePages/SupportPage.dart';
import 'package:app/pages/other/quiz/quizStart.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  final int currentPage;
  final Function changeTabPage;
  Profile({
    this.currentPage,
    @required this.changeTabPage,
  });

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User user;
  var _currentPage;
  @override
  void initState() {
    print(widget.currentPage);
    _currentPage = widget.currentPage ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: (Store<AppState> store) => ViewModel.create(store),
      builder: (BuildContext context, ViewModel viewModel) {
        var profileTiles = <Map>[
          {
            'profileTile': ProfileTile("Profile", FontAwesomeIcons.solidUserCircle),
            'page': Routes.profile,
          },
          {
            'profileTile': ProfileTile("Propose an action or campaign", FontAwesomeIcons.bullhorn),
            'link': "https://docs.google.com/forms/d/e/1FAIpQLSfPKOVlzOOV2Bsb1zcdECCuZfjHAlrX6ZZMuK1Kv8eqF85hIA/viewform",
          },
          {
            'profileTile': ProfileTile("Give feedback on the app", Icons.speaker_notes),
            'link': "https://docs.google.com/forms/d/e/1FAIpQLSflMOarmyXRv7DRbDQPWRayCpE5X4d8afOpQ1hjXfdvzbnzQQ/viewform",
          },
          {
            'profileTile':
                ProfileTile("Rate us on App Store", FontAwesomeIcons.solidStar),
            'link': ""
          },
          {
            'profileTile': ProfileTile("FAQ", FontAwesomeIcons.newspaper),
            'page': Routes.faq,
          },
          {
            'profileTile': ProfileTile("Our Partners", FontAwesomeIcons.building),
            'page': Routes.parteners,
          },
          {
            'profileTile':
                ProfileTile("Send us a message", FontAwesomeIcons.facebookMessenger),
            'link': "http://m.me/nowufb"
          },
          {
            'profileTile':
                ProfileTile("Send us an email", FontAwesomeIcons.solidEnvelope),
            'link': "mailto:hello@now-u.com?subject=Hi there"
          },
          //{
          //  'profileTile': ProfileTile("Partners", FontAwesomeIcons.building),
          //  'page': PartnersPage(),
          //},
          //{
          //  'profileTile': ProfileTile("About", FontAwesomeIcons.infoCircle),
          //  'page': AboutPage(),
          //},

          // Old Pages
          //{  'profileTile': ProfileTile("Details", FontAwesomeIcons.solidUser) , 'page': DetailsPage(goBack: goBack, ), },
          //{  'profileTile': ProfileTile("Progress", FontAwesomeIcons.spinner), 'page':ProgressPage(goBack, viewModel)},
          //{  'profileTile': ProfileTile("Network", FontAwesomeIcons.users) },
          //{  'profileTile': ProfileTile("Rewards", FontAwesomeIcons.ribbon), 'page' : RewardsPage(goBack, viewModel) },
          //{  'profileTile': ProfileTile("Offers", FontAwesomeIcons.percent), 'page': OffersPage(goBack) },
          //{  'profileTile': ProfileTile("Feedback", FontAwesomeIcons.solidComment), 'page': FeedbackPage(goBack) },
          //{  'profileTile': ProfileTile("Support", FontAwesomeIcons.question), 'page':SupportPage(goBack) },
        ];
        user = viewModel.userModel.user;
        return Scaffold(
            body: Container(
                color: Colors.white,
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 45),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        "More",
                        style: textStyleFrom(
                          Theme.of(context).primaryTextTheme.headline2,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      //separatorBuilder: (context, index) => ProfileDividor(),
                      itemCount: profileTiles.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => setState(() {
                          print("Tapping"); 
                          if (profileTiles[index]["page"] != null) {
                            print("Pushing page"); 
                            Navigator.pushNamed(
                              context,
                              profileTiles[index]["page"]
                            );
                          } else if (profileTiles[index]["link"] != null) {
                            launch(profileTiles[index]["link"]);
                          } else {
                          }
                        }),
                        child: profileTiles[index]["profileTile"],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "Follow us on social media",
                        style: Theme.of(context).primaryTextTheme.bodyText1,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SocialButton(
                          icon: FontAwesomeIcons.instagram,
                          link: "https://www.instagram.com/now_u_app/",
                        ), 
                        SocialButton(
                          icon: FontAwesomeIcons.facebookF,
                          link: "https://www.facebook.com/nowufb",
                        ), 
                        SocialButton(
                          icon: FontAwesomeIcons.twitter,
                          link: "https://twitter.com/now_u_app",
                        ) 
                      ],
                    ),
                    GestureDetector(
                      child: ProfileTile("Dev Tools", FontAwesomeIcons.code),
                      onTap: () {
                        Navigator.push(
                            context,
                            CustomRoute(
                                builder: (context) => QuizStartPage(0)));
                      },
                    ),
                  ],
                )));
      },
    );
  }
}

Text sectionTitle(String t, BuildContext context) {
  return Text(t, style: Theme.of(context).primaryTextTheme.headline);
}

class ProfileDividor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1,
      color: Color.fromRGBO(187, 187, 187, 1),
    );
  }
}

class SocialButton extends StatelessWidget {
  final double size = 50;
  final IconData icon;
  final String link;

  SocialButton({
    this.icon, 
    this.link,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {launch(link);},
      child: Container(
        height: size, 
        width: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size/2),
          color: Theme.of(context).primaryColor,
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      )
    );
  }
}
