import 'package:flutter/material.dart';

import 'package:app/assets/routes/customRoute.dart';

import 'package:app/pages/other/ArticlePage.dart';

import 'package:app/models/Article.dart';

import 'package:app/models/ViewModel.dart';
import 'package:app/models/State.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(20),
        // TODO do a test of a list of all articles
        child: StoreConnector<AppState, ViewModel>(
          converter: (Store<AppState> store) => ViewModel.create(store),
          builder: (BuildContext context, ViewModel model) {
            return FutureBuilder(
              future: model.api.getArticles(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return 
                  Column(
                    children: <Widget>[
                        Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return NewsTextTile(
                              article: snapshot.data[index],
                            );
                          },
                        )
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
  final double width;
  final double height;
  final Article article;

  NewsImageTile({
    @required this.height,
    @required this.width,
    @required this.article
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * MediaQuery.of(context).size.height,  
      width: width * MediaQuery.of(context).size.width,  
      color: Colors.red,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget> [
          Container(
            color: Colors.red,
            child: Text(article.getTitle()),
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
              flex: 5,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [
                    Text("Category"),
                    Text(
                      article.getTitle(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ]
                )
              ),
            ),
            SizedBox(width: 10,),
            Flexible(
              flex: 2,
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
      padding: EdgeInsets.symmetric(vertical: 5),
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
