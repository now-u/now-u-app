import 'package:app/assets/components/darkButton.dart';
import 'package:app/assets/routes/customRoute.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:app/pages/home/HomeTile.dart';
import 'package:app/pages/other/ArticlePage.dart';
import 'package:app/pages/profile/profilePages/RewardsPage.dart';
import 'package:app/pages/profile/Profile.dart';

import 'package:app/assets/components/pageTitle.dart';
import 'package:app/assets/components/selectionItem.dart';

import 'package:app/models/Campaign.dart';
import 'package:app/models/ViewModel.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/Campaigns.dart';
import 'package:app/models/Article.dart';

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

class Home extends StatelessWidget {
  ViewModel model;
  Function changePage;
  Home(this.model, this.changePage);
  
  @override
  Widget build(BuildContext context) {
    print(model.user.getName());
    return Scaffold(
      body: Container(
              color: Colors.white,
              child: ListView(
                  children: <Widget>[
                    PageTitle("Home"),
                    HomeTile(
                        Container(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    sectionTitle("Actions", context),
                                    ActionTile(model.campaigns, model, changePage),
                                  ],
                                  )
                            ),
                    ), 
                    HomeTile(
                        Container(
                              child: Column(
                                  children: <Widget>[
                                    sectionTitle("Congratulations", context),
                                    SelectionItem("You Completed 10 Actions"),
                                    sectionTitle("Other progress...", context),
                                    SelectionItem("Make 1 more donation to complete 'Make 5' donations"),
                                    Padding(
                                      padding: EdgeInsets.all(BUTTON_PADDING),
                                      child: DarkButton(
                                          "See More Rewards", 
                                          onPressed: () {
                                            changePage(2, subIndex: 4);
                                          },
                                      ),
                                    ),
                                    // TODO Progress Slider thing
                                  ],
                                  )
                            ),
                    ), 
                    // News
                    HomeTile(
                      Container(
                        child: Column(
                          children: <Widget>[
                            sectionTitle("News", context),
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Text(newsArticle.getTitle(), 
                                 style: Theme.of(context).primaryTextTheme.body1,),
                            ),
                            ArticleTile( newsArticle),
                          ],
                        ),
                      )
                    ),
                    // Video of the day
                    HomeTile(
                      Container(
                        child: Column(
                          children: <Widget>[
                            sectionTitle("Clip of the day", context),
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Text(articleWithVideo.getTitle(), 
                                 style: Theme.of(context).primaryTextTheme.body1,),
                            ),
                            ArticleTile( articleWithVideo),
                          ],
                        ),
                      )
                    )
                  ],
                  
                  )
            ),
    );
  }
}
 
Widget sectionTitle(String t, BuildContext context) {
  return 
      Padding(
        padding: EdgeInsets.all(10),
        child:
          Text(t, style: Theme.of(context).primaryTextTheme.headline, textAlign: TextAlign.start,),
      );
}

class ActionTile extends StatelessWidget {
  Campaigns campaigns;
  ViewModel model;
  Function changePage;
  ActionTile(this.campaigns, this.model, this.changePage);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      },
      child: Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 5, 10),
          child: 
            Column(
              children: <Widget>[
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: 
                    (BuildContext context, int index) => 
                      ActionSelectionItem(
                        action: campaigns.getActiveCampaigns()[index].getActions()[index],
                        model: model,
                        campaign: campaigns.getActiveCampaigns()[index],
                    ),
                ),
                Padding(
                  padding: EdgeInsets.all(BUTTON_PADDING),
                  child: DarkButton("See More Actions", onPressed: () {
                    changePage(0);
                  },),
                ),
                //ActionItem(user.getFollowUpAction()),
                //TODO Work ou where follow up actions should be
              ]
          )
      )
    );
  }
}
