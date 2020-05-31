import 'package:app/assets/StyleFrom.dart';
import 'package:flutter/material.dart';

import 'package:app/pages/news/NewsPage.dart';
import 'package:app/pages/Tabs.dart';

import 'package:app/assets/components/selectionItem.dart';
import 'package:app/assets/components/darkButton.dart';
import 'package:app/assets/components/progress.dart';

import 'package:app/models/ViewModel.dart';
import 'package:app/models/Campaigns.dart';
import 'package:app/models/Article.dart';
import 'package:app/models/State.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

const double BUTTON_PADDING = 10;

Article newsArticle = 
  Article(
    id: 1,
    title: "After 13 years in development, we have finally completed this very important thing!",
    body: "Magna ac nibh ultrices vehicula. Maecenas commodo facilisis lectus.  Praesent sed mi. Phasellus ipsum. Donec quis tellus id lectus faucibus molestie. Praesent vel ligula. Nam venenatis neque quis mauris. Proin felis. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur.",
    headerImage: "https://images.unsplash.com/photo-1526951521990-620dc14c214b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1267&q=80",
    linkedAction: 1,
    linkedCampaign: 1,
    fullArticleLink: "https://www.bbc.co.uk/news/uk-52439348",
  );

Article articleWithVideo = 
  Article(
    id: 2,
    title: "After 13 years in development, we have finally completed this very important thing!",
    body: "Magna ac nibh ultrices vehicula. Maecenas commodo facilisis lectus.  Praesent sed mi. Phasellus ipsum. Donec quis tellus id lectus faucibus molestie. Praesent vel ligula. Nam venenatis neque quis mauris. Proin felis. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur.",
    headerImage: "https://images.unsplash.com/photo-1526951521990-620dc14c214b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1267&q=80",
    linkedAction: 1,
    linkedCampaign: 1,
    fullArticleLink: "https://www.bbc.co.uk/news/uk-52439348",
    videoLink: "https://www.youtube.com/watch?v=ybn_SO990go",
  );

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
  Function changePage;
  HomeActionTile(this.changePage);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      },
      child: Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 5, 10),
          child: 
            StoreConnector<AppState, ViewModel>(
              converter: (Store<AppState> store) => ViewModel.create(store),
              builder: (BuildContext context, ViewModel viewModel) {
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
                            outerHpadding: 5,
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
            )
            
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

