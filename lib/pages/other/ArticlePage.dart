import 'package:flutter/material.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:app/models/Article.dart';
//import 'package:app/models/ViewModel.dart';

import 'package:app/pages/other/ActionInfo.dart';

//import 'package:app/assets/components/videoPlayerFlutterSimple.dart';
import 'package:app/assets/components/selectionItem.dart';
import 'package:app/assets/routes/customRoute.dart';

class ArticlePage extends StatelessWidget {
  final Article article;

  ArticlePage(this.article,);

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController ytcontroller = 
      YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(article.getVideoLink()),
        flags: YoutubePlayerFlags(
            autoPlay: true,
            mute: false,
      ),
    );
    return Scaffold(
      body: NestedScrollView(
         headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget> [
              // Header
              SliverAppBar(

              bottom: 
                PreferredSize(
                  preferredSize: Size.fromHeight(18),  
                  child: Text(''),
                ), 
              expandedHeight: 400.0,
              floating: false,
              pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  //centerTitle: true,
                  //title: Text("News"), 
                  background: Hero(
                    tag: "ArticleHeaderImage${article.getId()}",
                    child: Container(
                      decoration: BoxDecoration(
                        image: new DecorationImage(
                          image: new NetworkImage(article.getHeaderImage()),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ];
         }, 
          // This is the body for the nested scroll view
         body: 
          ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 35, vertical: 0),
                child: Text(
                  article.getTitle(),
                  style: Theme.of(context).primaryTextTheme.headline,
                ),
              ),
              Padding(
                 padding: EdgeInsets.all(25),
                 child: 
                  article.getVideoLink() == null 
                  ?
                  null 
                  :
                  Container(
                    child:
                      YoutubePlayer(
                        controller: ytcontroller,
                        showVideoProgressIndicator: true,
                      ),
                    ) 
                  ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Text(article.getBody(), style: Theme.of(context).primaryTextTheme.body1),
                      ),
                    ]
              ),
            ], 
          ),
          
        )
    );
  }
}

class ArticleTile extends StatelessWidget {
  final Article article;

  ArticleTile(this.article,);

  @override
  Widget build(BuildContext context) {
    
    GestureTapCallback _onTapMoreInfo =  () {
      Navigator.push(
        context, 
        CustomRoute(builder: (context) => ArticlePage(article),)
      );
    };

    return Container(
       height: 300,
       child: GestureDetector(
           onTap: _onTapMoreInfo,
           child: Stack(
              children: <Widget> [
                Padding(
                   padding: EdgeInsets.all(20), 
                   child: Stack(
                      children: <Widget>[
                        // Image
                        Container(
                            //tag: "CampaignHeaderImage${widget._campaign.getId()}",
                            child: 
                              Container(decoration: BoxDecoration(
                                image: DecorationImage( 
                                           image: NetworkImage(article.getHeaderImage()), 
                                           fit: BoxFit.cover, 
                                       ),
                                )
                              ),
                        ),
                        // Gradient
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [const Color.fromRGBO(0, 0,0, 0), Color.fromRGBO(0, 0,0, 0.4)],
                              )
                          ),
                        ),
                        // Text
                      ], 
                   ),
                 ),
                 Center(
                     child:
                 Padding(
                      padding: EdgeInsets.all(15),
                      child: 
                        article.getVideoLink() == null
                        ?
                        null 
                        : 
                        Container(
                          width: 60,
                          height: 60,
                          child: 
                            Icon(
                              Icons.play_circle_outline, 
                              size: 80,
                              color: Colors.white,
                            ),
                        ),
                     )
                  )
             ],
            )
          )
    );
  }
}
