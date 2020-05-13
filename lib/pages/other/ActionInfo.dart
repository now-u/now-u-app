import 'package:flutter/material.dart';

import 'package:app/models/Action.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/models/ViewModel.dart';
import 'package:app/models/Reward.dart';

import 'package:app/pages/campaign/CampaignInfo/CampaignInfo.dart';
import 'package:app/pages/other/RewardComplete.dart';

import 'package:app/assets/StyleFrom.dart';
import 'package:app/assets/components/selectionItem.dart';
import 'package:app/assets/components/detailScaffold.dart';
import 'package:app/assets/components/darkButton.dart';
import 'package:app/assets/components/textButton.dart';
import 'package:app/assets/components/customAppBar.dart';
import 'package:app/assets/routes/customRoute.dart';
import 'package:app/assets/components/textButton.dart';

class ActionInfo extends StatefulWidget {
  final CampaignAction action;
  // Action's parent campaign
  final Campaign campaign;
  final ViewModel model;
  
  ActionInfo(this.action, this.campaign, this.model);
  @override
  _ActionInfoState createState() => _ActionInfoState();
}

class _ActionInfoState extends State<ActionInfo> {
  final double expandedHeight = 400.0;

  CampaignAction _action;
  // Action's parent campaign
  Campaign _campaign;
  ViewModel _model;
  @override
  void initState() {
    _campaign = widget.campaign;
    _model = widget.model;
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
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                sliver: 
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            _action.getTitle(),
                            style: Theme.of(context).primaryTextTheme.headline1,
                            textAlign: TextAlign.left
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                          child: TextButton(
                            _campaign.getTitle(),
                            onClick: () {
                              Navigator.push(
                               context,
                               CustomRoute(builder: (context) => CampaignInfo(campaign: _campaign, model: _model))
                              );
                            },
                          )
                        ),
                        Container(height: 20),
                        _model.user.isCompleted(_action) ?
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
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                  Expanded(
                                    child: RichText(
                                        text: TextSpan(text: _action.getDescription(), style: Theme.of(context).primaryTextTheme.bodyText1),
                                        ),
                                  )
                              ]
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              DarkButton(
                                "Mark as done",
                                inverted: true,
                                onPressed: () {
                                  scaffoldKey.currentState.showBottomSheet(
                                    (context) =>
                                      Container(
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(243, 183, 0, 1),
                                            borderRadius: BorderRadius.vertical(top: Radius.circular(10))
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.only(top: 20),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: EdgeInsets.only(right: 10.0),
                                                      child: Icon(
                                                        Icons.check_circle,
                                                        color: Colors.white,
                                                        size: 36.0,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Nice Job",
                                                      style: textStyleFrom(
                                                        Theme.of(context).primaryTextTheme.headline2,
                                                        color: Colors.white,
                                                      )
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 25),
                                                child: Container(
                                                  child: Text(
                                                    "Congratulations for completing this action! For that we are really proud of you!",
                                                    textAlign: TextAlign.center,
                                                    style: textStyleFrom(
                                                      Theme.of(context).primaryTextTheme.headline4,
                                                      color: Colors.white
                                                    ),

                                                  ),
                                                )
                                              ),

                                            ],
                                          )
                                        )
                                  );
                                  setState(() {
                                    // TODO Somehow somewhere navigate to completed reward page if reward completed
                                    List<Reward> newlyCompletedRewards = widget.model.user.newlyCompletedRewards(_action);
                                    _model.onCompleteAction(_action, );
                                    if (newlyCompletedRewards.length > 0) {
                                      Navigator.push(
                                        context, 
                                        CustomRoute(builder: (context) => RewardCompletePage(widget.model, newlyCompletedRewards))
                                      );
                                    }
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
              ),

            ],
          ),
    );
  }
}
