import 'package:app/assets/components/textButton.dart';
import 'package:flutter/material.dart';

import 'package:app/models/Action.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/models/ViewModel.dart';
import 'package:app/models/Reward.dart';

import 'package:app/pages/campaign/CampaignInfo/CampaignInfo.dart';
import 'package:app/pages/other/RewardComplete.dart';

import 'package:app/assets/components/selectionItem.dart';
import 'package:app/assets/components/detailScaffold.dart';
import 'package:app/assets/components/darkButton.dart';
import 'package:app/assets/routes/customRoute.dart';

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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(_action.getTitle()),
        ),
          // This is the body for the nested scroll view
         body: DetailScaffold(
            expandedHeight: expandedHeight,
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: expandedHeight,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    color: Colors.purple
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                sliver: 
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        // Button to campaign
                        //Center(
                        //  child: Padding(
                        //    padding: EdgeInsets.only(
                        //      bottom: 20,
                        //    ),
                        //    child: DarkButton(
                        //      "View full campaign",
                        //      onPressed: () {
                        //        Navigator.push(
                        //         context,
                        //         CustomRoute(builder: (context) => CampaignInfo(campaign: _campaign, model: _model))
                        //        );
                        //      },
                        //    )
                        //  ),
                        //),
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
                                  child: Image(image: AssetImage('assets/imgs/partypopperemoji.png'),),
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
                                        text: TextSpan(text: _action.getDescription(), style: Theme.of(context).primaryTextTheme.body1),
                                        ),
                                  )
                              ]
                        ),
                      ],
                    )
                  )
                ,
              ),

            ],
          ),
          //floatingActionButton:
          //Padding (
          //    padding: EdgeInsets.all(14),
          //    child: DarkButton(
          //      "Complete Action",
          //      onPressed: () {
          //        setState(() {
          //          // TODO Somehow somewhere navigate to completed reward page if reward completed
          //          List<Reward> newlyCompletedRewards = widget.model.user.newlyCompletedRewards(_action);
          //          _model.onCompleteAction(_action, );
          //          if (newlyCompletedRewards.length > 0) {
          //            Navigator.push(
          //              context, 
          //              CustomRoute(builder: (context) => RewardCompletePage(widget.model, newlyCompletedRewards))
          //            );
          //          }
          //        });
          //      },
          //    )
          //)
          //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
