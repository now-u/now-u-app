import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:app/assets/components/customAppBar.dart';
import 'package:app/assets/routes/customRoute.dart';

import 'package:app/models/User.dart';
import 'package:app/models/ViewModel.dart';
import 'package:app/models/State.dart';

import 'package:app/pages/profile/ProfileTile.dart';
import 'package:app/pages/Tabs.dart';

import 'package:app/pages/profile/profilePages/DetailsPage.dart';
import 'package:app/pages/profile/profilePages/AboutPage.dart';
import 'package:app/pages/other/quiz/quizStart.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

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
            'profileTile': ProfileTile('Home', FontAwesomeIcons.home),
            'tabPage': TabPage.Home,
          },
          {
            'profileTile': ProfileTile('Profile', FontAwesomeIcons.userCircle),
            'page': DetailsPage(),
          },
          {
            'profileTile': ProfileTile('Campaigns', FontAwesomeIcons.bullhorn),
            'tabPage': TabPage.Campaigns,
          },
          {
            'profileTile':
                ProfileTile('Actions', FontAwesomeIcons.clipboardCheck),
            'tabPage': TabPage.Actions,
          },
          {
            'profileTile': ProfileTile('News', FontAwesomeIcons.newspaper),
            'tabPage': TabPage.News,
          },
          {
            'profileTile': ProfileTile('Partners', FontAwesomeIcons.building),
            'page': null,
          },
          {
            'profileTile': ProfileTile('About', FontAwesomeIcons.infoCircle),
            'page': AboutPage(),
          },

          // Old Pages
          //{  'profileTile': ProfileTile('Details', FontAwesomeIcons.solidUser) , 'page': DetailsPage(goBack: goBack, ), },
          //{  'profileTile': ProfileTile('Progress', FontAwesomeIcons.spinner), 'page':ProgressPage(goBack, viewModel)},
          //{  'profileTile': ProfileTile('Network', FontAwesomeIcons.users) },
          //{  'profileTile': ProfileTile('Rewards', FontAwesomeIcons.ribbon), 'page' : RewardsPage(goBack, viewModel) },
          //{  'profileTile': ProfileTile('Offers', FontAwesomeIcons.percent), 'page': OffersPage(goBack) },
          //{  'profileTile': ProfileTile('Feedback', FontAwesomeIcons.solidComment), 'page': FeedbackPage(goBack) },
          //{  'profileTile': ProfileTile('Support', FontAwesomeIcons.question), 'page':SupportPage(goBack) },
        ];
        user = viewModel.user;
        return Scaffold(
            appBar: CustomAppBar(
              text: 'Menu',
              hasBackButton: false,
              context: context,
            ),
            body: Container(
                color: Color.fromRGBO(238, 238, 238, 1),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => ProfileDividor(),
                        itemCount: profileTiles.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () => setState(() {
                            if (profileTiles[index]['page'] == null) {
                              // TODO might switch to this style as it seems to rebuild anyway
                              // TODO fix the fact that it rebuilds stuff when switching page
                              //Navigator.push(
                              // context,
                              // CustomRoute(builder: (context) => changePage(profileTiles[index]['index']))
                              //);
                              //Navigator.of(context).push(
                              //  CustomRoute(builder: (BuildContext context) {
                              //    return TabsPage(currentPage: TabPage.Home);
                              //  })
                              //);
                              //Navigator.pushNamed(context, '/home');
                              widget.changeTabPage(
                                  profileTiles[index]['tabPage']);
                            } else {
                              Navigator.push(
                                  context,
                                  CustomRoute(
                                      builder: (context) =>
                                          profileTiles[index]['page']));
                            }
                          }),
                          child: profileTiles[index]['profileTile'],
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: ProfileTile('Dev Tools', FontAwesomeIcons.code),
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
