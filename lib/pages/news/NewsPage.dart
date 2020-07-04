import 'package:flutter/material.dart';

import 'package:app/assets/StyleFrom.dart';
import 'package:app/assets/components/header.dart';
import 'package:app/assets/components/customTile.dart';
import 'package:app/assets/components/selectionPill.dart';
import 'package:app/assets/routes/customLaunch.dart';

import 'package:app/pages/news/ArticlePage.dart';

import 'package:app/models/Article.dart';

import 'package:app/models/ViewModel.dart';
import 'package:app/models/State.dart';
import 'package:app/models/Campaigns.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

final double PAGE_PADDING = 15;
final Color HEADER_COLOR = Color.fromRGBO(247, 248, 252, 1);

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: EdgeInsets.all(0),
            // TODO do a test of a list of all articles
            child: StoreConnector<AppState, ViewModel>(
                converter: (Store<AppState> store) => ViewModel.create(store),
                builder: (BuildContext context, ViewModel model) {
                  return FutureBuilder(
                    future: model.api.getArticles(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return NewsList(snapshot.data);
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  );
                })));
  }
}

class NewsList extends StatefulWidget {
  final List<Article> articles;
  NewsList(this.articles);

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  TextEditingController editingController = TextEditingController();

  bool searching;
  List<Article> articles;
  String category;

  @override
  initState() {
    searching = false;
    category = null;
    articles = List<Article>();
    articles.addAll(widget.articles);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: colorFrom(
                  Colors.black, 
                  opacity: 0.08,
                ),
                offset: Offset(0, 1),
                blurRadius: 3,
              ),
            ]
          ),
          child: PageHeader(
            title: "News",
          ),
        ),
        Container(
            //color: Color.fromRGBO(247, 248, 252, 1),
            color: HEADER_COLOR,
            child: Column(children: <Widget>[

              StoreConnector<AppState, ViewModel>(
                  converter: (Store<AppState> store) => ViewModel.create(store),
                  builder: (BuildContext context, ViewModel model) {
                    return Container(
                        decoration: BoxDecoration(
                          color: colorFrom(
                            Colors.white,
                            opacity: 0.6,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: colorFrom(
                                Colors.black, 
                                opacity: 0.08,
                              ),
                              offset: Offset(0, 1),
                              blurRadius: 3,
                            )
                          ]
                        ),
                        height: 60,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: model.campaigns.activeLength(),
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                  padding: EdgeInsets.all(5),
                                  child: GestureDetector(
                                      onTap: () {
                                        print("Detecting");
                                        setState(() {
                                          print("Setting state");
                                          String indexCategory = index ==
                                                  model.campaigns.activeLength()
                                              ? "general"
                                              : model.campaigns
                                                  .getActiveCampaigns()[index]
                                                  .getShortName();
                                          print("Setting state 2");
                                          category = category == indexCategory
                                              ? null
                                              : indexCategory;

                                          print("The category is $category");
                                          articles.clear();
                                          articles.addAll(widget.articles);
                                          if (category != null) {
                                            articles.removeWhere((a) =>
                                                a.getCategory(
                                                    campaigns:
                                                        model.campaigns) !=
                                                category);
                                          }
                                          print("State set");
                                        });
                                      },
                                      child: 
                                          Padding(
                                            padding: EdgeInsets.symmetric(vertical: 5),
                                            child: SelectionPill(
                                              "#" +
                                                  model.campaigns
                                                      .getActiveCampaigns()[
                                                          index]
                                                      .getShortName(),
                                              getCategoryFromIndex( model.campaigns, index) == category,
                                              fontSize: 12,
                                              borderRadius: 25,
                                            ),
                                        )
                                    ));
                      }
                    )
                  );
                }
              ),

              SizedBox(
                height: PAGE_PADDING,
              ),

              SizedBox(height: 10),

              // News aritcles
              ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: articles.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                      padding: EdgeInsets.only(
                        left: PAGE_PADDING,
                        right: PAGE_PADDING,
                        bottom: 10,
                      ),
                      child: NewsTile(
                          article:
                              articles[index]));
                },
              ),
              SizedBox(width: 20),
            ],
          )
        ) 
      ]
    );
  }

  void filterArticlesList(String query) {
    if (query.isNotEmpty) {
      List<Article> tempList = List<Article>();
      widget.articles.forEach((article) {
        if (article.getTitle().toLowerCase().contains(query.toLowerCase())) {
          print("adding " + article.getTitle() + " to list");
          tempList.add(article);
        }
      });
      setState(() {
        print("Set searching to true");
        searching = true;
        articles.clear();
        articles.addAll(tempList);
      });
    } else {
      print("query is empty");
      setState(() {
        searching = false;
        articles.clear();
        print("Adding articles to articles list");
        print(widget.articles.length);
        articles.addAll(widget.articles);
        // SO articles.addAll(widget.articles) does not add all the articles from widget.articles to articles
        // TODO find out why articles becomes an empty list
        print(articles.length);
      });
    }
  }
}

class NewsTile extends StatelessWidget {
  final Article article;
  final double height = 80;

  NewsTile({@required this.article});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        customLaunch(
          context,
          article.getFullArticleLink()
        );
      },
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                color: colorFrom(
                  Colors.black,
                  opacity: 0.08,
                ),
                offset: Offset(0, 15),
                blurRadius: 25
              )
            ]
          ),
          child: Column(
            children: [
              Container(
                height: 160,
                width: double.infinity,
                child: Image.network(
                  article.getHeaderImage(),
                  fit: BoxFit.cover,
                )
              ),

              // Titile
              Padding(
                padding: EdgeInsets.all(12),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, 
                    children: [
                      Text(
                        article.getTitle(),
                        style: textStyleFrom(
                          Theme.of(context).primaryTextTheme.headline3,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          height: 0.97,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5),
                      Text(
                        article.getSubtitle(),
                        style: textStyleFrom(
                          Theme.of(context).primaryTextTheme.headline5,
                          color: Color.fromRGBO(109, 113,129, 1)
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5),
                      article.getReleaseDate() == null ? Container() :
                      Text(
                        DateFormat('d MMMM yyyy').format(article.getReleaseDate()),
                        style: textStyleFrom(
                          Theme.of(context).primaryTextTheme.bodyText1,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Source
              article.getSource() == null ? Container() :
              Container(
                color: Color.fromRGBO(247,248,252,1),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      article.getSource(),
                      style: textStyleFrom(
                        Theme.of(context).primaryTextTheme.bodyText1,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
      )
    );
  }
}

String getCategoryFromIndex(Campaigns campaigns, int index) {
  return index == campaigns.activeLength()
      ? "general"
      : campaigns.getActiveCampaigns()[index].getShortName();
}
