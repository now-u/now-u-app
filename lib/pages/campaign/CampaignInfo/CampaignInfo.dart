import 'package:flutter/material.dart';

import 'package:app/models/Campaign.dart';
import 'package:app/models/ViewModel.dart';

import 'package:app/pages/other/ActionInfo.dart';

//import 'package:app/assets/components/videoPlayerFlutterSimple.dart';
import 'package:app/assets/components/selectionItem.dart';
import 'package:app/assets/routes/customRoute.dart';

class CampaignInfo extends StatelessWidget {
  Campaign _campaign;
  ViewModel model;

  CampaignInfo(campaign, this.model) {
    _campaign = campaign;
  }

  @override
  Widget build(BuildContext context) {
    print(_campaign.getId());
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
                  title: Text(_campaign.getTitle(), style: Theme.of(context).primaryTextTheme.display1,),
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
              Padding(
                 padding: EdgeInsets.all(25),
                 child: 
                  Container(
                    height: 300,
                    color: Colors.red,
                    //child: Material(
                      //child: VideoPlayer(),  
                    //), 
                    ) 
                  ),
              Row(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(25),
                        child: Text(_campaign.getDescription(), style: Theme.of(context).primaryTextTheme.body1),
                      ),
                    ]
              ),
              Padding(
                padding: EdgeInsets.all(25),
                child: Text("Actions of the Week", style: Theme.of(context).primaryTextTheme.headline,),
              ),
              //Padding(
              //  padding: EdgeInsets.symmetric(horizontal: 20),
              //  child: ActionSelectionItem(
              //    campaign: _campaign,
              //    action: _campaign.getActions()[0],
              //    model: model,
              //  ),
              //),
              //Padding(
              //  padding: EdgeInsets.symmetric(horizontal: 20),
              //  child: SelectionItem(_campaign.getActions()[1].getTitle()),
              //),
              //Padding(
              //  padding: EdgeInsets.symmetric(horizontal: 20),
              //  child: SelectionItem(_campaign.getActions()[2].getTitle()),
              //),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: ActionSelectionItem(
                      campaign: _campaign,
                      action: _campaign.getActions()[index],
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
