import 'package:flutter/material.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/assets/components/videoPlayer.dart';

class CampaignInfo extends StatelessWidget {
  Campaign _campaign;

  CampaignInfo(campaign) {
    _campaign = campaign;
  }

  @override
  Widget build(BuildContext context) {
    print(_campaign.getId());
    return Scaffold(
      body: NestedScrollView(
         headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget> [
              // Header
              SliverAppBar(
                  bottom: PreferredSize(
                       preferredSize: Size.fromHeight(18),  
                       child: Text(''),
                      ), 
              expandedHeight: 400.0,
              floating: false,
              pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: SafeArea( 
                      child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(_campaign.getTitle(), style: Theme.of(context).primaryTextTheme.display1,)
                          )
                      ),
                  background: Hero(
                    tag: "CampaignHeaderImage${_campaign.getId()}",
                    child: Container(
                      decoration: BoxDecoration(
                        image: new DecorationImage(
                          image: new NetworkImage(_campaign.getHeaderImage()),
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
          Column(
            children: <Widget>[
              Container(
                child: Container(
                   child: VideoPlayer(),  
                ), 
              ) 
            ], 
          ),
          
        )
    );
  }
}
