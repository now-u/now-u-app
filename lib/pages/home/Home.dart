import 'package:app/assets/StyleFrom.dart';
import 'package:flutter/material.dart';

import 'package:app/pages/news/NewsPage.dart';
import 'package:app/pages/Tabs.dart';

import 'package:app/assets/components/selectionItem.dart';
import 'package:app/assets/components/darkButton.dart';
import 'package:app/assets/components/progress.dart';
import 'package:app/assets/components/viewCampaigns.dart';

import 'package:app/models/ViewModel.dart';
import 'package:app/models/State.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

const double BUTTON_PADDING = 10;

final double headerHeight = 240;

class Home extends StatelessWidget {
  final Function changePage;
  Home(this.changePage);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorFrom(
        Theme.of(context).primaryColor,
        opacity: 0.05,
      ),
      body: Container(
              child: ListView(
                  children: <Widget>[
                    ClipPath(
                      child: Container(
                        height: headerHeight,
                        child: Stack(
                          children: <Widget> [
                            ActionProgressData(
                              actionsHomeTileHeight: 170,
                              actionsHomeTilePadding: 15,
                              actionsHomeTileTextWidth: 0.5,
                            ),
                            Positioned(
                              right: -20,
                              //top: actionsHomeTilePadding,
                              bottom: 10,
                              child: Container(
                                height: 170,
                                width: MediaQuery.of(context).size.width * (0.5),
                                child: Image(
                                  image: AssetImage('assets/imgs/progress.png'),
                                )
                              )
                            ),
                          ],
                        ),
                        color: Theme.of(context).primaryColor
                      ),
                      clipper: BezierClipper(),
                    ),

                    sectionTitle("Actions", context),
                    HomeActionTile(changePage),

                    HomeDividor(),
                    sectionTitle("Highlights", context),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        child: VideoOTDTile(),
                      ),
                    ),
                    HomeButton(
                      text: "All news",
                      changePage: changePage,
                      page: TabPage.News

                    )
                    
                  ],
                  
                  )
            ),
    );
  }
}
 
Widget sectionTitle(String t, BuildContext context) {
  return Padding(
    padding: EdgeInsets.all(10),
    child:
      Text(t, style: 
        Theme.of(context).primaryTextTheme.headline3,
        textAlign: TextAlign.start,
      ),
  );
}

class HomeActionTile extends StatelessWidget {
  final Function changePage;
  HomeActionTile(this.changePage);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      },
      child: StoreConnector<AppState, ViewModel>(
        converter: (Store<AppState> store) => ViewModel.create(store),
        builder: (BuildContext context, ViewModel viewModel) {
          if (viewModel.getActiveSelectedCampaings().getActions().length == 0) {
            return Container(
              height: 200,
              child: ViewCampaigns(),
            );
          }
          else {
            return Column(
              children: <Widget>[
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: 
                    (BuildContext context, int index) => 
                      ActionSelectionItem(
                        action: viewModel.campaigns.getActiveCampaigns()[index].getActions()[index],
                        campaign: viewModel.campaigns.getActiveCampaigns()[index],
                        outerHpadding: 10,
                        backgroundColor: Colors.white,
                    ),
                ),
                HomeButton(
                  text: "All actions",
                  changePage: changePage,
                  page: TabPage.Actions,
                )
                //ActionItem(user.getFollowUpAction()),
                //TODO Work ou where follow up actions should be
              ]
            );
          }
        }
      )
            
    );
  }
}


class HomeButton extends StatelessWidget {
  final String text;
  final Function changePage;
  final TabPage page;

  HomeButton({
    @required this.text,
    @required this.changePage,
    this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(BUTTON_PADDING),
        child: 
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget> [
            DarkButton(
              text, 
              rightArrow: true,
              onPressed: () {
                changePage(
                  page ?? TabPage.Home
                );
              },
              style: DarkButtonStyles.Small,
            ),
          ],
        ),
      ),
    );
  }
}

class HomeDividor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, 
      height: 2,
      color: Color.fromRGBO(238,238,238, 1),
    );
  }
}

class BezierClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height - 40);

    var firstControlPoint = Offset(size.width / 4, size.height - 65);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 40);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height);
    var secondEndPoint = Offset(size.width, size.height - 35);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 20);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

