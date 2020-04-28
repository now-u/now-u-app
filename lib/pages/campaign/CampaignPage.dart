import 'package:flutter/material.dart';

import 'package:app/pages/campaign/CampaignTile.dart';
import 'package:app/pages/campaign/SelectionComplete.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/models/ViewModel.dart';
import 'package:app/models/User.dart';

import 'package:app/assets/routes/customRoute.dart';
import 'package:app/assets/components/darkButton.dart';
import 'package:app/assets/components/pageTitle.dart';

import 'package:flutter_redux/flutter_redux.dart';

import 'package:app/main.dart';

class CampaignPage extends StatefulWidget {
  final ViewModel model;
  final bool _selectionMode;

  CampaignPage(this.model, this._selectionMode);

  @override
  _CampaignPageState createState() => _CampaignPageState();
}

class _CampaignPageState extends State<CampaignPage> {
  List<Campaign> _campaigns;
  User _user;
  bool _selectionMode;
  ViewModel _model;
  @override
  void initState() {
    _campaigns = widget.model.campaigns.getActiveCampaigns().toList();
    _user = widget.model.user;
    _selectionMode = widget._selectionMode;
    _model = widget.model;
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
                            _selectionMode ? "Tap to Select" : "Click to learn more...", 
                            style: Theme.of(context).primaryTextTheme.subtitle),
                    ),
                    Expanded(
                      child: ListView(
                        children: <Widget> [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _campaigns.length,
                            itemBuilder: (BuildContext context, int index) {
                              return
                              _model.user.getSelectedCampaignsLength() <= 0  || _selectionMode ?
                              CampaignTile(_campaigns[index], _model, selectionMode: _selectionMode)
                              : 
                              _model.user.getSelectedCampaigns().contains(_campaigns[index].getId()) ?
                              CampaignTile(_campaigns[index], _model, selectionMode: _selectionMode)
                              : null;

                            },
                          ),
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
                             _selectionMode = false;
                             _model = widget.model;
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
                            _model.onSelectCampaigns(_user);
                          });
                          Navigator.push(
                            context, 
                            CustomRoute(builder: (context) => SelectionComplete(_model))
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
