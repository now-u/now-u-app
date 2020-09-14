import 'package:flutter/material.dart';

import 'package:app/routes.dart';

import 'package:app/assets/components/header.dart';
import 'package:app/assets/components/campaignTile.dart';
import 'package:app/assets/StyleFrom.dart';

import 'package:stacked/stacked.dart';
import 'package:app/viewmodels/base_campaign_model.dart';

class CampaignPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // If given specific campaign, redirect to that page
    // Needs to be in future so happens after render of this page or something like that
    //var _campaigns = widget.model.campaigns.map((Campaign c) => c).toList();
    return Scaffold(
        body: ViewModelBuilder<BaseCampaignWriteViewModel>.reactive(
      viewModelBuilder: () => BaseCampaignWriteViewModel(),
      onModelReady: (model) => model.fetchCampaigns(),
      builder: (context, model, child) {
        return Stack(children: [
          SafeArea(
            child: ListView(
              children: <Widget>[
                PageHeader(
                  backButton: true,
                  title: "Join a campaign",
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Choose one or more of our campaigns for this month that you wish to support",
                    style: Theme.of(context).primaryTextTheme.bodyText1,
                  ),
                ),
                Container(
                  child: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: model.campaigns.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CampaignTileWithJoinButtons(
                              campaign: model.campaigns[index],
                              isJoined: model
                                  .isJoined(model.campaigns[index].getId()),
                              joinCampaign: model.joinCampaign,
                              leaveCampaign: model.leaveCampaign,
                            );
                          },
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ]),
                ),
                SizedBox(height: 60),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: FlatButton(
              padding: EdgeInsets.all(0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 55,
                child: Center(
                    child: Text(
                  "Done",
                  style: textStyleFrom(
                      Theme.of(context).primaryTextTheme.button,
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: Colors.white),
                )),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.home);
              },
              color: Theme.of(context).primaryColor,
            ),
          )
        ]);
      },
    ));
  }
}
