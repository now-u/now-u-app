import 'package:app/assets/StyleFrom.dart';
import 'package:flutter/material.dart';

import 'package:app/assets/routes/customRoute.dart';

import 'package:app/pages/news/ArticlePage.dart';

import 'package:app/models/Article.dart';

import 'package:app/models/ViewModel.dart';
import 'package:app/models/State.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

final double PAGE_PADDING = 15;

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(0),
        // TODO do a test of a list of all articles
        child: StoreConnector<AppState, ViewModel>(
          converter: (Store<AppState> store) => ViewModel.create(store),
          builder: (BuildContext context, ViewModel model) {
            return FutureBuilder(
              future: model.api.getArticles(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return 
                  ListView(
                    children: <Widget>[
                        NewsDividor(),
                        Text("Recent News"),
                        // Featured news articles
                        Padding(
                          padding: EdgeInsets.all(PAGE_PADDING),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                    padding: EdgeInsets.only(right: PAGE_PADDING/2),
                                    child: NewsImageTile(
                                      article: snapshot.data[0],
                                    ),
                                  )
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: PAGE_PADDING/2),
                                  child: NewsImageTile(
                                    article: snapshot.data[1],
                                  ),
                                )
                              ),
                            ],
                          ),
                        ),
                        // List of other news articles 
                        ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: snapshot.data.length <= 2 ? 0 : snapshot.data.length - 2,
                          itemBuilder: (BuildContext context, int index) {
                            return 
                            Padding(
                              padding: EdgeInsets.only(
                                left: PAGE_PADDING, right: PAGE_PADDING,
                                bottom: PAGE_PADDING/2,
                              ),
                              child: NewsTextTile(
                                article: snapshot.data[index + 2],
                              )
                            );
                          },
                        )
                    ],
                  );
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
            width: double.infinity,
            child: NewsGraphic(
              article.getHeaderImage(),
              120,
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
              flex: 2,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [
                    Text(
                      article.getCategory(),
                      style: textStyleFrom(
                        Theme.of(context).primaryTextTheme.headline5,
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
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
            Flexible(
              flex: 1,
              child: NewsGraphic(article.getHeaderImage(), height)
            )
          ],
        ),
      ),
    );
  }
}

class NewsDividor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, 
      height: 1.5,
      color: Colors.grey,
    );
  }
}

class NewsGraphic extends StatelessWidget {

  final String image;
  final double height;
  final double borderRadius = 10;

  NewsGraphic(this.image, this.height);

  @override
  Widget build(BuildContext context) {
    return 
    Padding(
      padding: EdgeInsets.symmetric(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0,0,0,0.16),
              offset: Offset(0, 4.0),
              blurRadius: 6
            )
          ]
        ),
        height: height,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          child: Image.network(
            image,
            fit: BoxFit.cover,
          )
        )
      )
    );
  }
}
