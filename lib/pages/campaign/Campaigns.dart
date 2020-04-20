import 'package:flutter/material.dart';

import 'package:app/pages/campaign/CampaignTile.dart';
import 'package:app/pages/campaign/SelectionComplete.dart';

import 'package:app/models/Campaign.dart';
import 'package:app/models/ViewModel.dart';

import 'package:app/assets/routes/customRoute.dart';
import 'package:app/assets/components/darkButton.dart';
import 'package:app/assets/components/customBottomNavBar.dart';
import 'package:app/assets/components/customFloatingActionButton.dart';
import 'package:app/assets/components/pageTitle.dart';

import 'package:flutter_redux/flutter_redux.dart';

import 'package:app/main.dart';

class Campaigns extends StatefulWidget {
  final ViewModel model;
  bool _selectionMode;
  List<Campaign> _campaigns;

  Campaigns(this.model, this._selectionMode) {
    _campaigns = model.campaigns.toList();
  }

  @override
  _CampaignsState createState() => _CampaignsState();
}

class _CampaignsState extends State<Campaigns> {
  List<Campaign> _campaigns;
  @override
  void initState() {
    _campaigns = widget.model.campaigns.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //var _campaigns = widget.model.campaigns.map((Campaign c) => c).toList();
    return Scaffold(
        body: SafeArea(
                child: Column(
                  children: <Widget>[
                    PageTitle("Campaigns"),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: Text(
                            widget._selectionMode ? "Tap to Select" : "Click to learn more...", 
                            style: Theme.of(context).primaryTextTheme.subtitle),
                    ),
                    Expanded(
                      child: ListView(
                        children: <Widget> [
                          CampaignTile(_campaigns[0], widget.model, selectionMode: widget._selectionMode),
                          CampaignTile(_campaigns[1], widget.model, selectionMode: widget._selectionMode),
                          CampaignTile(_campaigns[2], widget.model, selectionMode: widget._selectionMode),
                          Container(
                                height: 100,
                              )
                        ]
                      ),     
                    ),
                    //Padding (
                    //    padding: EdgeInsets.all(14),
                    //    child: DarkButton(
                    //      "Select Campaigns",
                    //      onPressed: () {
                    //        setState(() {
                    //           _selectionMode = !_selectionMode;
                    //         }); 
                    //      },
                    //    )
                    //),
                  ], 
                ),
              ),
        //floatingActionButton: CustomFloatingActionButton(text: "Select Campaigns", ),
        floatingActionButton: 
          !widget._selectionMode ?
          Padding (
              padding: EdgeInsets.all(14),
              child: DarkButton(
                "Select Campaigns",
                onPressed: () {
                  setState(() {
                     widget._selectionMode = true;
                   }); 
                },
              )
          )
          :
          Padding (
              padding: EdgeInsets.all(14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                     padding: EdgeInsets.only(right: 10),
                     child: 
                      DarkButton(
                        "Cancel",
                        onPressed: () {
                          setState(() {
                             widget._selectionMode = false;
                           }); 
                        },
                      ),
                  ),
                  Padding(
                     padding: EdgeInsets.only(left: 10),
                     child: 
                      DarkButton(
                        "Select",
                        onPressed: () {
                          setState(() {
                            widget._selectionMode = false;
                          });
                          widget.model.onSelectCampaigns(_campaigns);
                          Navigator.push(
                            context, 
                            CustomRoute(builder: (context) => SelectionComplete(widget.model))
                          );
                        },
                      ),
                  ),
                
                ],   
              ),
          )
          ,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    }
}
