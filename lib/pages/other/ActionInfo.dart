import 'package:flutter/material.dart';

import 'package:app/models/Action.dart';
import 'package:app/models/Campaign.dart';

import 'package:app/assets/components/selectionItem.dart';
import 'package:app/assets/components/darkButton.dart';

class ActionInfo extends StatelessWidget {
  
  final CampaignAction action;

  // Action's parent campaign
  final Campaign campaign;
  
  ActionInfo(this.action, this.campaign);

  @override
  Widget build(BuildContext context) {
    print(action.getId());
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
                  title: Text(action.getTitle(), style: Theme.of(context).primaryTextTheme.display1,),
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
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: RichText(
                              text: TextSpan(text: action.getDescription(), style: Theme.of(context).primaryTextTheme.body1),
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
                },
              )
          )
        ,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
