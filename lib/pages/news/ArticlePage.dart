import 'package:app/assets/components/darkButton.dart';
import 'package:flutter/material.dart';

import 'package:app/models/Article.dart';

import 'package:app/models/ViewModel.dart';
import 'package:app/models/State.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:app/assets/components/detailScaffold.dart';
import 'package:app/assets/components/textButton.dart';
import 'package:app/assets/components/customAppBar.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticlePage extends StatelessWidget {
  final Article article;

  ArticlePage(this.article);

  final double expandedHeight = 400.0;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: "Article",
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
            sliver: SliverList(
                delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(article.getTitle(),
                      style: Theme.of(context).primaryTextTheme.headline2,
                      textAlign: TextAlign.left),
                ),
                StoreConnector<AppState, ViewModel>(
                    converter: (Store<AppState> store) =>
                        ViewModel.create(store),
                    builder: (BuildContext context, ViewModel viewModel) {
                      return Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                          child: TextButton(
                            article.getCategory(campaigns: viewModel.campaigns),
                            onClick: () {
                              // TODO link to news page with category search/filter
                              //Navigator.push(
                              // context,
                              // CustomRoute(builder: (context) => CampaignInfo(campaign: _campaign, model: _model))
                              //);
                            },
                          ));
                    }),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(article.getSubtitle(),
                      style: Theme.of(context).primaryTextTheme.headline3,
                      textAlign: TextAlign.left),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                              text: article.getBody(),
                              style:
                                  Theme.of(context).primaryTextTheme.bodyText1),
                        ),
                      )
                    ]),
                SizedBox(
                  height: 25,
                ),
                DarkButton(article.getLinkText(), inverted: true,
                    onPressed: () {
                  launch(
                    article.getFullArticleLink(),
                  );
                }),
                SizedBox(
                  height: 20,
                )
              ],
            )),
          ),
        ],
      ),
    );
  }
}
