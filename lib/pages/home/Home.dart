import 'package:flutter/material.dart';

import 'package:app/pages/news/NewsPage.dart';
import 'package:app/pages/Tabs.dart';

import 'package:app/assets/components/selectionItem.dart';
import 'package:app/assets/StyleFrom.dart';
import 'package:app/assets/components/darkButton.dart';
import 'package:app/assets/components/progress.dart';

import 'package:app/models/ViewModel.dart';
import 'package:app/models/Article.dart';
import 'package:app/models/State.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

const double BUTTON_PADDING = 10;

Article newsArticle = 
  Article(
    id: 1,
    title: 'After 13 years in development, we have finally completed this very important thing!',
    body: 'Magna ac nibh ultrices vehicula. Maecenas commodo facilisis lectus.  Praesent sed mi. Phasellus ipsum. Donec quis tellus id lectus faucibus molestie. Praesent vel ligula. Nam venenatis neque quis mauris. Proin felis. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur.',
    headerImage: 'https://images.unsplash.com/photo-1526951521990-620dc14c214b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1267&q=80',
    linkedAction: 1,
    linkedCampaign: 1,
    fullArticleLink: 'https://www.bbc.co.uk/news/uk-52439348',
  );

Article articleWithVideo = 
  Article(
    id: 2,
    title: 'After 13 years in development, we have finally completed this very important thing!',
    body: 'Magna ac nibh ultrices vehicula. Maecenas commodo facilisis lectus.  Praesent sed mi. Phasellus ipsum. Donec quis tellus id lectus faucibus molestie. Praesent vel ligula. Nam venenatis neque quis mauris. Proin felis. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur.',
    headerImage: 'https://images.unsplash.com/photo-1526951521990-620dc14c214b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1267&q=80',
    linkedAction: 1,
    linkedCampaign: 1,
    fullArticleLink: 'https://www.bbc.co.uk/news/uk-52439348',
    videoLink: 'https://www.youtube.com/watch?v=ybn_SO990go',
  );

class Home extends StatelessWidget {
  Function changePage;
  Home(this.changePage);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home', style: Theme.of(context).primaryTextTheme.headline3),
        centerTitle: true,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 3.0,
      ),
      body: Container(
              color: Colors.white,
              child: ListView(
                  children: <Widget>[
                    ActionProgressTile(),
                    //ActionProgressTile(model.user.getCompletedActions().length, model.campaigns.getCampaignsFromIds(model.user.getSelectedCampaigns()).getActions().length),

                    HomeDividor(),
                    sectionTitle("Actions", context),
                    HomeActionTile(changePage),

                    HomeDividor(),
                    sectionTitle('Highlights', context),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        child: VideoOTDTile(),
                      ),
                    ),
                    HomeButton(
                      text: 'All news',
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
  return 
    Center(
      child: Padding(
        padding: EdgeInsets.all(10),
        child:
          Text(t, style: 
            Theme.of(context).primaryTextTheme.headline3,
            textAlign: TextAlign.start,
          ),
      )
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

class ActionProgressTile extends StatelessWidget {

  final double actionsHomeTileTextWidth = 0.6;
  final double actionsHomeTileHeight = 170;
  final double actionsHomeTilePadding = 15;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
        converter: (Store<AppState> store) => ViewModel.create(store),
        builder: (BuildContext context, ViewModel viewModel) {
          final int numberOfCompletedAction = viewModel.user.getCompletedActions().length;
          final int numberOfSelectedActions = viewModel.campaigns.getActions().length;
          return 
           Container(
             child: Stack(
               children: <Widget>[
                 Padding(
                   padding: EdgeInsets.all(actionsHomeTilePadding),
                   child: Container(
                     width: double.infinity,
                     height: actionsHomeTileHeight,
                     decoration: BoxDecoration(
                       color: Theme.of(context).primaryColor,
                       borderRadius: BorderRadius.all(Radius.circular(20)),
                     ),
                     child: 
                       Padding(
                         padding: EdgeInsets.all(20),
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           mainAxisSize: MainAxisSize.max,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: <Widget>[
                             Text(
                               (numberOfSelectedActions - numberOfCompletedAction).toString()
                               + " actions left",
                               style: textStyleFrom(
                                 Theme.of(context).primaryTextTheme.headline3,
                                 color: Colors.white,
                               ),
                               textAlign: TextAlign.left,
                             ),
                             ProgressBar(
                               progress: numberOfCompletedAction/numberOfSelectedActions,
                               width: MediaQuery.of(context).size.width * (actionsHomeTileTextWidth - 0.12),
                               height: 15,
                             ),
                             SizedBox(height: 15,),
                             // TODO need to get user active campiangs not all active campaigns
                             Container(
                               width: MediaQuery.of(context).size.width * actionsHomeTileTextWidth - 5,
                               child: Text(
                                 "You have completed " + numberOfCompletedAction.toString() + " of " + numberOfSelectedActions.toString() + " total actions from your active campaigns. Way to go!",
                                 textAlign: TextAlign.left,
                                 style: textStyleFrom(
                                   Theme.of(context).primaryTextTheme.bodyText1,
                                   color: Colors.white,
                                   fontWeight: FontWeight.w500,
                                   height: 1.0
                                 ),
                               ),
                             ),
                           ],
                         ),
                       )
                   ),
                 ),
                 Positioned(
                   left: MediaQuery.of(context).size.width * (actionsHomeTileTextWidth),
                   top: actionsHomeTilePadding,
                   child: Container(
                     height: actionsHomeTileHeight,
                     width: MediaQuery.of(context).size.width * (1-actionsHomeTileTextWidth),
                     child: Image(
                       image: AssetImage('assets/imgs/intro/il-reward@4x.png'),
                     )
                   )
                 ),
               ],
             )
           );
         }
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

