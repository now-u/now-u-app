import 'package:flutter/material.dart';

import 'package:app/pages/campaign/CampaignTile.dart';
import 'package:app/pages/campaign/SelectionComplete.dart';

import 'package:app/models/Campaign.dart';

import 'package:app/assets/routes/customRoute.dart';
import 'package:app/assets/components/darkButton.dart';
import 'package:app/assets/components/customBottomNavBar.dart';
import 'package:app/assets/components/customFloatingActionButton.dart';
import 'package:app/assets/components/pageTitle.dart';

var campaigns = <Campaign> [
  Campaign(1, "Refugees", "Help with the things", 270, "https://cdn.pixabay.com/photo/2013/04/16/14/23/eritrea-105081_960_720.jpg", false),
  Campaign(2, "Other Thing", "Help with the things", 170, "https://cdn.pixabay.com/photo/2013/04/16/14/23/eritrea-105081_960_720.jpg", false),
  Campaign(3, "Other2", "Help with the things", 320, "https://cdn.pixabay.com/photo/2013/04/16/14/23/eritrea-105081_960_720.jpg", false),

];

bool _selectionMode = false;

class Campaigns extends StatefulWidget {
  @override
  _CampaignsState createState() => _CampaignsState();
}

class _CampaignsState extends State<Campaigns> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
                child: Column(
                  children: <Widget>[
                    PageTitle("Campaigns"),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: Text(
                            _selectionMode ? "Tap to Select" : "Click to learn more...", 
                            style: Theme.of(context).primaryTextTheme.subtitle),
                    ),
                    Expanded(
                      child: ListView(
                        children: <Widget> [
                          CampaignTile(campaigns[0], selectionMode: _selectionMode),
                          CampaignTile(campaigns[1], selectionMode: _selectionMode),
                          CampaignTile(campaigns[2], selectionMode: _selectionMode),
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
          !_selectionMode ?
          Padding (
              padding: EdgeInsets.all(14),
              child: DarkButton(
                "Select Campaigns",
                onPressed: () {
                  setState(() {
                     _selectionMode = true;
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
                             _selectionMode = !_selectionMode;
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
                            _selectionMode = false;
                          });
                          var _selectedCamapings = campaigns.where((c) => c.isSelected()).toList();
                          Navigator.push(
                            context, 
                            CustomRoute(builder: (context) => SelectionComplete(_selectedCamapings))
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
