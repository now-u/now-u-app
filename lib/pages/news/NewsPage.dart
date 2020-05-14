import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(20),
        // TODO do a test of a list of all articles
        child: ListView(
          children: <Widget>[
            FutureBuilder(

              NewsTile(
            )
              width: 1,
              height: 0.4,
            ) 
          ],
        ),
      )
    );
  }
}

class NewsTile extends StatelessWidget {
  final double width;
  final double height;
  final double article;

  NewsTile({
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
        Container(
          child: ArticleType.Video
        )
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
