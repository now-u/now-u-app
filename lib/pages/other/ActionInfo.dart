import 'package:flutter/material.dart';

import 'package:app/models/Action.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/models/ViewModel.dart';
import 'package:app/models/Reward.dart';

import 'package:app/pages/campaign/CampaignInfo/CampaignInfo.dart';
import 'package:app/pages/other/RewardComplete.dart';

import 'package:app/assets/components/selectionItem.dart';
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
                  centerTitle: true,
                  title: Text("Action", style: Theme.of(context).primaryTextTheme.display1,),
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
          ListView(
            children: <Widget>[
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: 20,
                  ),
                  child: DarkButton(
                    "View full campaign",
                    onPressed: () {
                      Navigator.push(
                       context,
                       CustomRoute(builder: (context) => CampaignInfo(campaign: _campaign, model: _model))
                      );
                    },
                  )
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                child: Text(
                  _action.getTitle(),
                  style: Theme.of(context).primaryTextTheme.headline,
                ),
              ),
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
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: RichText(
                              text: TextSpan(text: _action.getDescription(), style: Theme.of(context).primaryTextTheme.body1),
                              ),
                        )
                    ]
              ),
            ], 
          ),
          
        ),
        floatingActionButton:
          Padding (
              padding: EdgeInsets.all(14),
              child: DarkButton(
                "Complete Action",
                onPressed: () {
                  setState(() {
                    // TODO Somehow somewhere navigate to completed reward page if reward completed
                    _model.onCompleteAction(_action, );
                  });
                },
              )
          )
        ,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
