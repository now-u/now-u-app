import 'package:flutter/material.dart';

import 'package:app/assets/routes/customRoute.dart';
import 'package:app/assets/StyleFrom.dart';
import 'package:app/assets/components/header.dart';
import 'package:app/assets/components/searchBar.dart';

import 'package:app/pages/news/ArticlePage.dart';

import 'package:app/models/Article.dart';

import 'package:app/models/ViewModel.dart';
import 'package:app/models/State.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

final double PAGE_PADDING = 15;

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
                }
                else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          }
        )
      )
    );
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
          color: Color.fromRGBO(247,248,252,1),
          child: Column(
            children: <Widget> [
              searching ? Container() :
              PageHeader(
                title: "News", 
                onTap: (){
                  setState(() {
                    searching = true;
                  });
                },
                icon: Icons.search,
              ),
              
              !searching ? Container() :
              SizedBox(height: PAGE_PADDING),
              !searching ? Container() :
              Padding(
                padding: EdgeInsets.symmetric(horizontal: PAGE_PADDING),
                child: SearchBar(
                  (value){
                    filterArticlesList(value);
                  },
                  editingController,
                  autofocus: true,
                ),
              ),

              // Video of the day
              searching ? Container() :
              Padding(
                padding: EdgeInsets.all(0),
                child: Container(
                  child: VideoOTDTile(
                    borderRadius: 0,
                    elevated: false,
                    textPadding: 15,
                    // TODO need to do actual request for video of the day
                  )
                ),
              ),
            ]
          )
        ),
          
        SizedBox(height: PAGE_PADDING,),
        
          searching ? Container() :
          Padding(
            padding: EdgeInsets.symmetric(horizontal: PAGE_PADDING),
            child: Text(
              "Recent News",
              style: textStyleFrom(
                Theme.of(context).primaryTextTheme.headline4,
                fontWeight: FontWeight.w600,
              )
            ),
          ),
          SizedBox(height: 10),
          // Featured news articles
          //articles.length >= 2 && !searching ?
          //Padding(
          //  padding: EdgeInsets.all(PAGE_PADDING),
          //  child: Row(
          //    mainAxisAlignment: MainAxisAlignment.start,
          //    crossAxisAlignment: CrossAxisAlignment.start,
          //    children: <Widget>[
          //      Expanded(
          //        child: Padding(
          //            padding: EdgeInsets.only(right: PAGE_PADDING/2),
          //            child: NewsImageTile(
          //              article: articles[0],
          //            ),
          //          )
          //      ),
          //      Expanded(
          //        child: Padding(
          //          padding: EdgeInsets.only(left: PAGE_PADDING/2),
          //          child: NewsImageTile(
          //            article: articles[1],
          //          ),
          //        )
          //      ),
          //    ],
          //  ),
          //)
          //: Container(),
          // List of other news articles 
          ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            //itemCount: articles.length < 2 ? articles.length : articles.length - 2,
            itemCount: articles.length,
            itemBuilder: (BuildContext context, int index) {
              return 
              Padding(
                padding: EdgeInsets.only(
                  left: PAGE_PADDING, right: PAGE_PADDING,
                  bottom: PAGE_PADDING/2,
                ),
                child: NewsTextTile(
                  article: 
                    //articles.length < 2 ? articles[index] : articles[index + 2],
                    articles[index]
                )
              );
            },
          )
      ],
    );
  }

  void filterArticlesList(String query) {
    if(query.isNotEmpty) {
      List<Article> tempList = List<Article>();
      widget.articles.forEach((article) {
        if (article.getTitle().toLowerCase().contains(query.toLowerCase())) {
          print ("adding " + article.getTitle() + " to list");
          tempList.add(article);
        }
      });
      setState(() {
        print("Set searching to true");
        searching = true;
        articles.clear();
        articles.addAll(tempList);
      });
    }
    else {
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

// Video of the day
class VideoOTDTile extends StatelessWidget {
  final double borderRadius;
  final bool elevated;
  final double textPadding;

  VideoOTDTile({
    this.borderRadius,
    this.elevated,
    this.textPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StoreConnector<AppState, ViewModel>(
        converter: (Store<AppState> store) => ViewModel.create(store),
        builder: (BuildContext context, ViewModel model) {
          return FutureBuilder(
            future: model.api.getVideoOfTheDay(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisSize: MainAxisSize.min,
                  children: <Widget> [
                    Container(
                      width: double.infinity,
                      child: NewsGraphic(
                        video: snapshot.data.getVideoLink(),
                        height: 185,
                        borderRadius: borderRadius,
                        elevated: elevated,
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: textPadding ?? 0),
                      child: Text(
                        "Clip of the day",
                        textAlign: TextAlign.left,
                        style: textStyleFrom(
                          Theme.of(context).primaryTextTheme.headline5,
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                          color: Theme.of(context).primaryColor
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: textPadding ?? 0),
                      child: Text(
                        snapshot.data.getTitle(),
                        textAlign: TextAlign.left,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textStyleFrom(
                          Theme.of(context).primaryTextTheme.headline5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: textPadding),
                  ],
                );
              }
              else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
          );
        }
      )
    );
  }
}

class NewsImageTile extends StatelessWidget {
  final Article article;

  NewsImageTile({
    @required this.article
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisSize: MainAxisSize.min,
        children: <Widget> [
          Container(
            //width: double.infinity,
            width: MediaQuery.of(context).size.width * 0.3,
            child: NewsGraphic(
              image: article.getHeaderImage(),
              height: 100,
            ),
          ),
          // TODO This should probably link to the catergory as well (ie search for the category)
          SizedBox(height: 5),
          Text(
            article.getCategory(),
            textAlign: TextAlign.left,
            style: textStyleFrom(
              Theme.of(context).primaryTextTheme.headline5,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
          SizedBox(height: 2),
          Text(
            article.getTitle(),
            textAlign: TextAlign.left,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: textStyleFrom(
              Theme.of(context).primaryTextTheme.headline5,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

class NewsTextTile extends StatelessWidget {
  final Article article;
  final double height = 80;

  NewsTextTile({
    @required this.article
  });

  @override
  Widget build(BuildContext context) {
    return 
    GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CustomRoute( 
            builder: (context) => ArticlePage(article)
          )
        );
      }, 
      child: Container(
        height: height,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: NewsGraphic(
                image: article.getHeaderImage(), 
                height: height
              )
            ),
            SizedBox(width: 15,),
            Flexible(
              flex: 2,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [
                    Container(
                      child: Text(
                        article.getCategory(),
                        style: textStyleFrom(
                          Theme.of(context).primaryTextTheme.headline5,
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      article.getTitle(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textStyleFrom(
                        Theme.of(context).primaryTextTheme.headline5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ]
                )
              ),
            ),
            SizedBox(width: 10,),
          ],
        ),
      ),
    );
  }
}

class NewsGraphic extends StatelessWidget {
  final double defaultBorderRadius = 10;

  final String image;
  final String video;
  final double height;
  final double borderRadius;
  final bool elevated;

  YoutubePlayerController controller;

  NewsGraphic({
    this.image, 
    this.video, 
    this.height,
    this.borderRadius,
    this.elevated,
  }):assert(image != null || video != null);

  @override
  Widget build(BuildContext context) {
    if (video != null) {
      controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(video),
        flags: YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
        ),
      );
    }

    return 
    Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? defaultBorderRadius)),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0,0,0,elevated ?? true ? 0.16 : 0),
              offset: Offset(0, 4.0),
              blurRadius: 6
            )
          ]
        ),
        height: height ?? 150,
        width: MediaQuery.of(context).size.width * 0.3,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? defaultBorderRadius)),
          child: 
          image != null ?
          Image.network(
            image,
            fit: BoxFit.cover,
          )
          :
          YoutubePlayer(
            controller: controller,
            showVideoProgressIndicator: true,
          ),
        )
      )
    );
  }
}

class NewsDividor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
      Padding(
        padding: EdgeInsets.symmetric(horizontal: PAGE_PADDING),
        child: Container(
          width: double.infinity, 
          height: 1,
          color: Color.fromRGBO(221, 221, 221, 1),
        )
      );
  }
}

