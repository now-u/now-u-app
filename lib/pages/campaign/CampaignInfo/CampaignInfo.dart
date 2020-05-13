import 'package:app/assets/StyleFrom.dart';
import 'package:app/assets/components/customAppBar.dart';
import 'package:app/assets/components/detailScaffold.dart';
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

class _CampaignInfoState extends State<CampaignInfo> with WidgetsBindingObserver {
  Api api = locator<Api>();
  Future<Campaign> futureCampaign;
  Campaign campaign;

  void didChangeAppLifecycleState(AppLifecycleState state) {
    //setState(() { _notification = state });
    print("The state is");
    print(state);
  }

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

class CampaignInfoContent extends StatefulWidget {
  final Campaign campaign;
  final ViewModel model;
  CampaignInfoContent({
    @required this.campaign, 
    @required this.model, 
  }); 
  
  @override
  _CampaignInfoContentState createState() => _CampaignInfoContentState();
}

class _CampaignInfoContentState extends State<CampaignInfoContent> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final double expandedHeight = 0.4;

  Campaign campaign;
  ViewModel model;
  double top;
  double currentExtent;
  double expandedSize;

  bool _isPlayerReady = false;
  YoutubePlayerController _controller;

  @override
  initState() {
    model = widget.model;
    campaign = widget.campaign;
    top = 0.0;
    expandedSize = 1-expandedHeight;
    currentExtent = expandedSize;
    _controller = 
      YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(campaign.getVideoLink()),
        flags: YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
        ),
      );
    super.initState();
  }

  //void listener() {
  //  if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
  //    setState(() {
  //      _playerState = _controller.value.playerState;
  //      _videoMetaData = _controller.metadata;
  //    });
  //  }
  //}

  @override
  Widget build(BuildContext context) {
    //TODO add ios support https://pub.dev/packages/youtube_player_flutter
    //print(campaign.getId());
    return Scaffold(
      appBar: CustomAppBar(
        text: "Campaign",
        context: context,
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: top,
            child: Container(
              height: (MediaQuery.of(context).size.height + 200) * expandedHeight,
              child: Container(
                child: Image.network( 
                  campaign.getHeaderImage(),
                  fit: BoxFit.cover,
                ),
              )
            ),
          ),
          NotificationListener( 
            onNotification: (v) {
              if (v is DraggableScrollableNotification) {
                print(v);
                print("Current extend");
                print(v.extent);
                print("Old");
                print(currentExtent);
                setState(() {
                  double scroll = v.extent - currentExtent;
                  top -= scroll * MediaQuery.of(context).size.height * expandedSize / 2;
                  currentExtent = v.extent;
                  print(top);
                });
              }
              return true;
            },
            child:
            DraggableScrollableSheet(
              initialChildSize: expandedSize,
              minChildSize: expandedSize,
              maxChildSize: 1.0,
              builder: (context, controller) =>
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32)
                    )
                  ),
                  child:
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: ListView( 
                        controller: controller,
                        children: [
                          Container(
                            child: Text(
                              campaign.getTitle(),
                              style: Theme.of(context).primaryTextTheme.headline2,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.people,
                                color: Color.fromRGBO(69,69,69,1),
                              ),
                              Text(
                                campaign.getNumberOfCampaigners().toString() + " people have joined",
                                style: textStyleFrom(
                                  Theme.of(context).primaryTextTheme.headline4,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(69,69,69,1),
                                )
                              )
                            ],
                          ),
                          // TODO fix upades to youtube player not showing until scroll (some kind of setstate issue)
                          Padding(
                             padding: EdgeInsets.all(10),
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
                                Expanded(
                                  child: Text(
                                    campaign.getDescription(), 
                                    style: Theme.of(context).primaryTextTheme.bodyText1,
                                  ),
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
                                  extraOnTap: (){
                                    _controller.pause();
                                  }
                                ),
                              );
                            },      
                          )
                        ], 
                      )
                    )
              )
            ),
        )
        ],
      )
        );
  }
}
