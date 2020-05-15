import 'package:flutter/material.dart';

import 'package:app/models/Action.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/models/ViewModel.dart';
import 'package:app/models/Reward.dart';
import 'package:app/models/Article.dart';

import 'package:app/pages/campaign/CampaignInfo/CampaignInfo.dart';
import 'package:app/pages/other/RewardComplete.dart';

import 'package:app/assets/StyleFrom.dart';
import 'package:app/assets/components/selectionItem.dart';
import 'package:app/assets/components/detailScaffold.dart';
import 'package:app/assets/components/darkButton.dart';
import 'package:app/assets/components/textButton.dart';
import 'package:app/assets/components/customAppBar.dart';
import 'package:app/assets/routes/customRoute.dart';
import 'package:app/assets/components/textButton.dart';

class ArticlePage extends StatelessWidget {
  
  final Article article;

  ArticlePage(this.article);
  
  
  final double expandedHeight = 400.0;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          text: "Action",
          backButtonText: "Home",
          context: context,
        ),
        key: scaffoldKey,
          // This is the body for the nested scroll view
         body: DetailScaffold(
            expandedHeight: expandedHeight,
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: expandedHeight,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                        image: new DecorationImage(
                          image: new NetworkImage(article.getHeaderImage()),
                          fit: BoxFit.cover,
                        ),
                      ),
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                sliver: 
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            article.getTitle(),
                            style: Theme.of(context).primaryTextTheme.headline1,
                            textAlign: TextAlign.left
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                          child: TextButton(
                            article.getCategory(),
                            onClick: () {
                              // TODO link to news page with category search/filter
                              //Navigator.push(
                              // context,
                              // CustomRoute(builder: (context) => CampaignInfo(campaign: _campaign, model: _model))
                              //);
                            },
                          )
                        ),
                        SizedBox(height: 20),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                  Expanded(
                                    child: RichText(
                                        text: TextSpan(text: article.getBody(), style: Theme.of(context).primaryTextTheme.bodyText1),
                                        ),
                                  )
                              ]
                        ),
                      ],
                    )
                  )
                ,
              ),

            ],
          ),
    );
  }
}
