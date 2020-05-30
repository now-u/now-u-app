import 'package:flutter/material.dart';

import 'package:app/models/Action.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/models/ViewModel.dart';
import 'package:app/models/Reward.dart';
import 'package:app/models/State.dart';

import 'package:app/pages/campaign/CampaignInfo/CampaignInfo.dart';
import 'package:app/pages/other/RewardComplete.dart';

import 'package:app/assets/StyleFrom.dart';
import 'package:app/assets/components/detailScaffold.dart';
import 'package:app/assets/components/darkButton.dart';
import 'package:app/assets/components/textButton.dart';
import 'package:app/assets/components/customAppBar.dart';
import 'package:app/assets/routes/customRoute.dart';
import 'package:app/assets/components/pointsNotifier.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ActionInfo extends StatefulWidget {
  final CampaignAction action;
  // Action's parent campaign
  final Campaign campaign;
  
  ActionInfo(this.action, this.campaign);
  @override
  _ActionInfoState createState() => _ActionInfoState();
}

class _ActionInfoState extends State<ActionInfo> {
  final double expandedHeight = 400.0;

  CampaignAction _action;
  // Action's parent campaign
  Campaign _campaign;
  @override
  void initState() {
    _campaign = widget.campaign;
    _action = widget.action;
    super.initState();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          text: "Action",
          backButtonText: "Home",
          context: context,
        ),
        key: scaffoldKey,
          // This is the body for the nested scroll view
         body: DetailScaffold(
            expandedHeight: expandedHeight,
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: expandedHeight,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                        image: new DecorationImage(
                          image: new NetworkImage(_campaign.getHeaderImage()),
                          fit: BoxFit.cover,
                        ),
                      ),
                  ),
                ),
              ),
              StoreConnector<AppState, ViewModel>(
                  converter: (Store<AppState> store) => ViewModel.create(store),
                  builder: (BuildContext context, ViewModel viewModel) {
                    return 
                      SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        sliver: 
                          SliverList(
                            delegate: SliverChildListDelegate(
                              [
                                // Title 
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    _action.getTitle(),
                                    style: Theme.of(context).primaryTextTheme.headline1,
                                    textAlign: TextAlign.left
                                  ),
                                ),
                                
                                // Name of campaign // TODO if campaign not parsed go find it (current campaign is @required)
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                  child: TextButton(
                                    _campaign.getTitle(),
                                    width: MediaQuery.of(context).size.width * 0.8,
                                    fontSize: 11,
                                    onClick: () {
                                      Navigator.push(
                                       context,
                                       CustomRoute(builder: (context) => CampaignInfo(campaign: _campaign))
                                      );
                                    },
                                  )
                                ),

                                SizedBox(height: 20),

                                // Completion message
                                viewModel.userModel.user.isCompleted(_action) ?
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        height: MediaQuery.of(context).size.width * 0.1 ,
                                        //child: Image(image: AssetImage('assets/imgs/partypopperemoji.png'),),
                                      ),
                                      Text("You have completed this action!")
                                       
                                    ],     
                                  ),
                                )
                                :
                                Container(height: 0),

                                // Text
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("What should I do?", style: Theme.of(context).primaryTextTheme.headline3),
                                    SizedBox(height: 10),
                                    Text(_action.getWhatDescription() ?? "", style: Theme.of(context).primaryTextTheme.bodyText1),
                                    
                                    SizedBox(height: 30),

                                    Text("Why is this useful?", style: Theme.of(context).primaryTextTheme.headline3),
                                    SizedBox(height: 10),
                                    Text(_action.getWhyDescription() ?? "", style: Theme.of(context).primaryTextTheme.bodyText1),
                                  ],
                                ),

                                // Buttons
                                Padding(
                                  padding: EdgeInsets.only(top: 30, bottom: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      DarkButton(
                                        "Mark as done",
                                        inverted: true,
                                        onPressed: () {
                                          print("Getting newlyCompletedRewards");
                                          //List<Reward> newlyCompletedRewards = viewModel.userModel.user.newlyCompletedRewards(_action);
                                          setState(() {
                                            completeAction(viewModel, context, _action);
                                            // TODO Somehow somewhere navigate to completed reward page if reward completed
                                            //print("Completing action");
                                            //viewModel.onCompleteAction(_action, (int points, int nextBadgePoints) {
                                            //  pointsNotifier(viewModel.userModel.user.getPoints(), points, nextBadgePoints, context)..show(context);
                                            //});
                                            //if (newlyCompletedRewards.length > 0) {
                                            //  Navigator.push(
                                            //    context, 
                                            //    CustomRoute(builder: (context) => RewardCompletePage(viewModel, newlyCompletedRewards))
                                            //  );
                                            //} else {
                                            //  scaffoldKey.currentState.showBottomSheet(
                                            //    (context) =>
                                            //      Container(
                                            //          decoration: BoxDecoration(
                                            //            color: Color.fromRGBO(243, 183, 0, 1),
                                            //            borderRadius: BorderRadius.vertical(top: Radius.circular(10))
                                            //          ),
                                            //          child: Column(
                                            //            mainAxisSize: MainAxisSize.min,
                                            //            children: <Widget>[
                                            //              Padding(
                                            //                padding: EdgeInsets.only(top: 20),
                                            //                child: Row(
                                            //                  mainAxisAlignment: MainAxisAlignment.center,
                                            //                  children: <Widget>[
                                            //                    Padding(
                                            //                      padding: EdgeInsets.only(right: 10.0),
                                            //                      child: Icon(
                                            //                        Icons.check_circle,
                                            //                        color: Colors.white,
                                            //                        size: 36.0,
                                            //                      ),
                                            //                    ),
                                            //                    Text(
                                            //                      "Nice Job",
                                            //                      style: textStyleFrom(
                                            //                        Theme.of(context).primaryTextTheme.headline2,
                                            //                        color: Colors.white,
                                            //                      )
                                            //                    ),
                                            //                  ],
                                            //                ),
                                            //              ),
                                            //              Padding(
                                            //                padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 25),
                                            //                child: Container(
                                            //                  child: Text(
                                            //                    "Congratulations for completing this action! For that we are really proud of you!",
                                            //                    textAlign: TextAlign.center,
                                            //                    style: textStyleFrom(
                                            //                      Theme.of(context).primaryTextTheme.headline4,
                                            //                      color: Colors.white
                                            //                    ),

                                            //                  ),
                                            //                )
                                            //              ),

                                            //            ],
                                            //          )
                                            //        )
                                            //  );
                                            //}
                                          });
                                        },
                                      ),
                                    ],

                                  )
                                )
                              ],
                            )
                          )
                        ,
                      );
                  },
              )


            ],
          ),
    );
  }
}
