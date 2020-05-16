import 'package:flutter/material.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:app/models/Campaign.dart';
import 'package:app/models/ViewModel.dart';

import 'package:app/services/api.dart';
import 'package:app/locator.dart';

//import 'package:app/assets/components/videoPlayerFlutterSimple.dart';
//import 'package:youtube_player/youtube_player.dart';
import 'package:app/assets/components/selectionItem.dart';
import 'package:app/assets/components/organisationTile.dart';
import 'package:app/assets/routes/customRoute.dart';
import 'package:app/assets/StyleFrom.dart';
import 'package:app/assets/components/customAppBar.dart';
import 'package:app/assets/components/darkButton.dart';
import 'package:app/assets/components/detailScaffold.dart';

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

  Campaign campaign;
  ViewModel model;
  double top;
  double currentExtent;

  bool _isPlayerReady = false;
  YoutubePlayerController _controller;

  @override
  initState() {
    model = widget.model;
    campaign = widget.campaign;
    top = 0.0;
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
      body: Container(
        child: ListView( 
          children: [

            // Image header
            Container(
              height: 200,
              child: 
                Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(campaign.getHeaderImage()),
                          fit: BoxFit.cover,
                        )
                      ),
                    ),
                    Container(
                      color: colorFrom(
                        Theme.of(context).primaryColorDark,
                        opacity: 0.5,
                      )
                    ),
                    Align( 
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: DarkButton(
                          "Join Now",
                          style: DarkButtonStyles.Small,
                          inverted: true,
                          onPressed: () {
                            if (!model.user.getSelectedCampaigns().contains(campaign.getId())) {
                              setState(() {
                                model.user.addSelectedCamaping(campaign.getId());
                                model.onSelectCampaigns(model.user);
                              });
                            }
                          }
                        ),
                      ),
                    )
                  ],
                ),
            ),

            // Title section
            Container(
              color: Color.fromRGBO(238,238,238,1),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        campaign.getTitle(),
                        style: Theme.of(context).primaryTextTheme.headline3,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.people,
                          color: Color.fromRGBO(69,69,69,1),
                          size: 16,
                        ),
                        SizedBox(width: 2),
                        Text(
                          campaign.getNumberOfCampaigners().toString() + " people have joined",
                          style: textStyleFrom(
                            Theme.of(context).primaryTextTheme.headline5,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(69,69,69,1),
                          )
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Youtube player
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

            // Description
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

            // Actions
            SectionTitle("Actions of the week"),
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
            ),

            // Organisation
            SectionTitle("Organisation"),
            Container(
              height: 140,
              //child: Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: campaign.getOrgnaisations().length,
                  itemBuilder: (BuildContext context, int index) {
                    return 
                    Expanded(

                    child: Container(
                      width: 100,
                      //height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0,0,0,0.16),
                            offset: Offset(0,3),
                            blurRadius: 6
                          )
                        ]
                      ),
                      child: 
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              //height: 80, width: 100,
                                //width: 20,
                                height: 60,
                                child: Image.network(
                                  campaign.getOrgnaisations()[index].getLogoLink(),
                                  fit: BoxFit.contain,
                              )
                            ),
                            SizedBox(height: 10,),
                            Text(
                              campaign.getOrgnaisations()[index].getName(),
                              style: Theme.of(context).primaryTextTheme.bodyText1,
                              maxLines: 2,
                              textAlign: TextAlign.center
                            )
                          ],
                        )
                      ),
                      )
                    );
                  },      
               // )
              )
            ),

            // Buttons
            //Padding(
            //  padding: EdgeInsets.all(10),
            //  child: Row(
            //    mainAxisAlignment: MainAxisAlignment.end,
            //    children: <Widget>[
            //    ],
            //  ),
            //),
          ], 
        )
      )
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String text;
  SectionTitle(this.text);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(25),
      child: Text(text, style: Theme.of(context).primaryTextTheme.headline,),
    );
  }
}
