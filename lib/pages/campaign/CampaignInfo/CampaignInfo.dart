import 'package:flutter/material.dart';

import 'package:app/models/Campaign.dart';
import 'package:app/models/ViewModel.dart';

import 'package:app/services/api.dart';
import 'package:app/locator.dart';

import 'package:app/pages/other/ActionInfo.dart';

//import 'package:app/assets/components/videoPlayerFlutterSimple.dart';
//import 'package:youtube_player/youtube_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:app/assets/components/selectionItem.dart';
import 'package:app/assets/routes/customRoute.dart';

class CampaignInfo extends StatefulWidget {
  final Campaign campaign;
  final int campaignId;
  final ViewModel model;
  
  CampaignInfo({
    @required this.model, 
    this.campaign, 
    this.campaignId
  }):assert(campaign != null || campaignId != null);

  @override
  _CampaignInfoState createState() => _CampaignInfoState();
}

class _CampaignInfoState extends State<CampaignInfo> {
  Api api = locator<Api>();
  Future<Campaign> futureCampaign;
  Campaign campaign;

  void initState() {
    // if give campaing use that
    if (widget.campaign != null) {
      print("Campaign does not equal null");
      this.campaign = widget.campaign;
    } 
    // check if we already have the campaign id they want
    else {
      Campaign c = widget.model.campaigns.getActiveCampaigns().firstWhere((camp) => camp.getId() == widget.campaignId, orElse: () => null);
      // if so use that
      if ( c != null ) {
        print("We have the campaign");
        this.campaign = c;
      }
      // otherwise have a look online
      else {
        print("Were gonna go have a look online");
        //this.futureCampaign = api.getCampaign(widget.campaignId);
        //// If that doesnt work then show the campaign not found page
        //if (this.futureCampaign == null) {
        //  // TODO implement campaign not found page
        //}
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Building Info Page");
    print(this.campaign);
    return
    this.campaign != null ?
    CampaignInfoContent(campaign: this.campaign, model: widget.model,)
    :
    FutureBuilder<Campaign>(
      //future: this.futureCampaign,
      future: api.getCampaign(widget.campaignId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            print("has data!");
            return CampaignInfoContent(campaign: snapshot.data, model: widget.model);
          }
          else if (snapshot.hasError) {
            // TODO implement campaign not found page
            print("There was an error with get campaign request");
            return null;
          }
        }
        else if (snapshot.connectionState == ConnectionState.none && snapshot.data == null) {
          print("ConnectionState is super none");
        }
        else if (snapshot.connectionState == ConnectionState.none) {
          print("ConnectionState is none");
        }
        else if (snapshot.connectionState == ConnectionState.waiting) {
          print("ConnectionState is wiaitng");
        }
        return 
          Scaffold(
            body:
              Center(
                child: CircularProgressIndicator()
              )
            ,
          );
      }
    );
  }
}

class CampaignInfoContent extends StatelessWidget {
  final Campaign campaign;
  final ViewModel model;

  CampaignInfoContent({
    @required this.campaign, 
    @required this.model, 
  }); 

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _controller = 
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
