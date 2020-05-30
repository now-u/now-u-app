import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:app/models/Campaign.dart';
import 'package:app/models/Organisation.dart';
import 'package:app/models/SDG.dart';
import 'package:app/models/Badge.dart';
import 'package:app/models/ViewModel.dart';
import 'package:app/models/State.dart';

import 'package:app/pages/campaign/LearningCentre/LearningCentrePage.dart';

import 'package:app/services/api.dart';
import 'package:app/locator.dart';

import 'package:app/assets/components/selectionItem.dart';
import 'package:app/assets/StyleFrom.dart';
import 'package:app/assets/components/customAppBar.dart';
import 'package:app/assets/components/darkButton.dart';
import 'package:app/assets/components/pointsNotifier.dart';
import 'package:app/assets/components/sectionTitle.dart';
import 'package:app/assets/routes/customRoute.dart';
import 'package:app/assets/components/organisationTile.dart';
import 'package:app/assets/components/textButton.dart';


import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

const double H_PADDING = 20;

class CampaignInfo extends StatelessWidget {
  final Campaign campaign;
  final int campaignId;
  
  CampaignInfo({
    this.campaign, 
    this.campaignId
  }):assert(campaign != null || campaignId != null);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
        converter: (Store<AppState> store) => ViewModel.create(store),
        builder: (BuildContext context, ViewModel viewModel) {
          return CampaignModelInfo(campaign: campaign, campaignId: campaignId, model: viewModel);
        }
    );
  }
}

class CampaignModelInfo extends StatefulWidget {
  final Campaign campaign;
  final int campaignId;
  final ViewModel model;
  
  CampaignModelInfo({
    @required this.model, 
    this.campaign, 
    this.campaignId
  }):assert(campaign != null || campaignId != null);

  @override
  _CampaignInfoModelState createState() => _CampaignInfoModelState();
}

class _CampaignInfoModelState extends State<CampaignModelInfo> with WidgetsBindingObserver {
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
          print("ConnectionState is waiting");
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

  //bool _isPlayerReady = false;
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
  //void joinCampaign(ViewModel viewModel, BuildContext context) {
  //    if (!viewModel.userModel.user.getSelectedCampaigns().contains(campaign.getId())) {
  //      setState(() {
  //        viewModel.userModel.user.addSelectedCamaping(campaign.getId());
  //        viewModel.onSelectCampaigns(viewModel.userModel.user, (int points, int nextBadgePoints, bool newBadge) {
  //          if (!newBadge) {
  //            pointsNotifier(viewModel.userModel.user.getPoints(), points, nextBadgePoints, context)..show(context);
  //          }
  //          else {
  //            gotBadgeNotifier(
  //              badge: getNextBadgeFromInt(viewModel.userModel.user.getPoints()),
  //              context: context,
  //            );
  //          }
  //        });
  //      });
  //    }   
  //}

  @override
  Widget build(BuildContext context) {
    //TODO add ios support https://pub.dev/packages/youtube_player_flutter
    //print(campaign.getId());
    return Scaffold(
      appBar: CustomAppBar(
        text: "Campaign",
        context: context,
        actions: [
          IconButton(
            icon: Icon(
              Icons.book,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              Navigator.push(
                context, 
                CustomRoute(builder: (context) => LearningCentrePage(campaign.getId()))
              );
            },
          )
        ]
      ),
      key: scaffoldKey,
      body: Stack(
        children: [
          ListView( 
            children: [

              // Image header
              Container(
                height: 200,
              // Youtube player
                child: Padding(
                   padding: EdgeInsets.all(0),
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


              ),

              // Title section
              Container(
                color: Color.fromRGBO(222,224,232,1),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
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
                              color: Color.fromRGBO(63,61,86,1),
                            )
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 18),
              // Campaign
              Padding(
                padding: EdgeInsets.symmetric(horizontal: H_PADDING,),
                child: Text(
                  "Campaign",
                  style: textStyleFrom(
                    Theme.of(context).primaryTextTheme.bodyText1,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              //Title
              Padding(
                padding: EdgeInsets.symmetric(horizontal: H_PADDING,),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    campaign.getTitle(),
                    style: textStyleFrom(
                      Theme.of(context).primaryTextTheme.headline3,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ),
              ),
              SizedBox(height: 18),

              SectionTitle("What is this about?", padding: H_PADDING, vpadding: 0),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: H_PADDING,),
                child: Container(
                  child: Text(
                    campaign.getDescription(), 
                    style: Theme.of(context).primaryTextTheme.bodyText1,
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Actions
              SectionTitle("What can I do?", padding: H_PADDING),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: H_PADDING,),
                child: Container(
                  child: Text(
                    "Complete our weekly actions to help us tackle this challenge.", 
                    style: Theme.of(context).primaryTextTheme.bodyText1,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      child: ActionSelectionItem(
                        campaign: campaign,
                        action: campaign.getActions()[index],
                        extraOnTap: (){
                          _controller.pause();
                        },
                      ),
                    );
                  },      
                ),
              ),

              // Organisation
              SizedBox(height: 10),
              SectionTitle("Campaign Partners", padding: H_PADDING, vpadding: 0),
              OrganisationReel(campaign.getCampaignPartners()),
              
              SizedBox(height: 10),
              SectionTitle("General Partners", padding: H_PADDING, vpadding: 0),
              OrganisationReel(campaign.getGeneralPartners()),

              SizedBox(height: 10),

              // SDGs
              SizedBox(height: 10),
              SectionTitle("UN Sustainable Developemnt Goals focus", padding: H_PADDING, vpadding: 0),
              SDGReel(campaign.getSDGs()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: H_PADDING),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Go to ",
                        style: Theme.of(context).primaryTextTheme.bodyText1
                      ),
                      TextSpan(
                        text: "sustainabledevelopment.un.org ",
                        style: textStyleFrom(
                          Theme.of(context).primaryTextTheme.bodyText1,
                          color: Theme.of(context).buttonColor,
                        ),
                      recognizer: TapGestureRecognizer()..onTap = () {
                        launch("sustainabledevelopment.un.org");
                      }
                        
                      ),
                      TextSpan(
                        text: "to find out more",
                        style: Theme.of(context).primaryTextTheme.bodyText1
                      ),
                    ]
                  ),
                ),
              ),


              // Buttons
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    DarkButton(
                      "Learn more",
                      onPressed: () {
                        Navigator.push(
                          context, 
                          CustomRoute(builder: (context) => LearningCentrePage(campaign.getId()))
                        );
                      },
                      inverted: true,
                      fontSize: 14,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 45)
            ], 
          ),
              Positioned(
                bottom: 0,
                left: 0,
                child: FlatButton(
                    padding: EdgeInsets.all(0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    child: 
                      Center(
                        child: Text(
                        "Join now",
                        style: textStyleFrom(
                          Theme.of(context).primaryTextTheme.button,
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: Colors.white
                        ),
                      )
                    ),
                  ),
                  onPressed: () {
                    joinCampaign(widget.model, context, campaign);
                  },
                  color: Theme.of(context).primaryColor,
                ),
              )
        ]
      ),
    );
  }
}

class OrganisationReel extends StatelessWidget {
  final List<Organisation> organisations;
  OrganisationReel(this.organisations);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      //child: Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: organisations.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.all(8),
              child: OrganisationTile(organisations[index]),
            );
          },      
       // )
      )
    );
  }
}

class SDGReel extends StatelessWidget {
  final List<SDG> sdgs;
  SDGReel(this.sdgs);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      //child: Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: sdgs.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.all(8),
              child: SDGTile(sdgs[index]),
            );
          },      
       // )
      )
    );
  }
}

class SDGTile extends StatelessWidget {
  final SDG sdg;
  SDGTile(this.sdg);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launch(sdg.getLink());
      },
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(0),
          child: Image.asset(
            sdg.getImage(),
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0,0,0,0.16),
              offset: Offset(0,3),
              blurRadius: 6
            )
          ]
        ),
      ),
    );
  }
}
