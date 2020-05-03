import 'package:flutter/material.dart';

import 'package:app/models/Campaign.dart';
import 'package:app/models/ViewModel.dart';

import 'package:app/pages/other/ActionInfo.dart';

//import 'package:app/assets/components/videoPlayerFlutterSimple.dart';
//import 'package:youtube_player/youtube_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:app/assets/components/selectionItem.dart';
import 'package:app/assets/routes/customRoute.dart';

class CampaignInfo extends StatelessWidget {
  Campaign campaign;
  int campaignId;
  ViewModel model;
  //Future<Campaign> campaign;

  CampaignInfo({
    @required this.model, 
    this.campaign, 
    int campaignId
  }){ 
    if (campaign != null) {
      this.campaign = campaign;
    } else {
      var c = model.campaigns.getActiveCampaigns().firstWhere((camp) => camp.getId() == campaignId);
      if ( c != null ) {
        this.campaign = c;
      }
    }
    assert (campaign != null || campaignId != null);
  }

  @override
  Widget build(BuildContext context) {
    print("In widget");
    print(campaignId);
    YoutubePlayerController _controller = 
      campaign == null ?
      null
      :
      YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(campaign.getVideoLink()),
        flags: YoutubePlayerFlags(
            autoPlay: true,
            mute: false,
        ),
      );
    //print(campaign.getId());
    return Scaffold(
      body: 
        campaign == null ?
        Center(child: Text("The campaign is ${campaignId}"))
        :
        NestedScrollView(
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
                  centerTitle: true,
                  title: Text(campaign.getTitle(), style: Theme.of(context).primaryTextTheme.display1,),
                  background: Hero(
                    tag: "CampaignHeaderImage${campaign.getId()}",
                    child: Container(
                      decoration: BoxDecoration(
                        image: new DecorationImage(
                          image: new NetworkImage(campaign.getHeaderImage()),
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
                 padding: EdgeInsets.all(25),
                 child: 
                  Container(
                    child:
                      YoutubePlayer(
                        controller: _controller,
                        showVideoProgressIndicator: true,
                      ),
                    //child: Material(
                      //child: VideoPlayer(),  
                    //), 
                    )
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Text(campaign.getDescription(), style: Theme.of(context).primaryTextTheme.body1),
                      ),
                    ]
              ),
              Padding(
                padding: EdgeInsets.all(25),
                child: Text("Actions of the Week", style: Theme.of(context).primaryTextTheme.headline,),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: ActionSelectionItem(
                      campaign: campaign,
                      action: campaign.getActions()[index],
                      model: model,
                    ),
                  );
                },      
              )
            ], 
          ),
          
        )
    );
  }
}
