import 'package:flutter/material.dart';

import 'package:app/assets/components/header.dart';
import 'package:app/assets/components/campaignTile.dart';

import 'package:stacked/stacked.dart';
import 'package:app/viewmodels/campaigns_all_model.dart';

class AllCampaignsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CampaignsAllViewModel>.reactive(
        viewModelBuilder: () => CampaignsAllViewModel(),
        onModelReady: (model) => model.fetchAllCampaigns(),
        builder: (context, model, child) {
          return Scaffold(
              body: SafeArea(
                  child: ListView(children: <Widget>[
            PageHeader(
              backButton: true,
              title: "All Campaigns",
            ),

            SizedBox(height: 20),

            // New Campaigns
            _titleBuilder("New", context),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: model.currentCampaigns!.length,
              itemBuilder: (BuildContext context, int index) {
                return CampaignTile(model.currentCampaigns![index]);
              },
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Container(
                  height: 1,
                  width: double.infinity,
                  color: Color.fromRGBO(190, 193, 206, 1)),
            ),

            // Past
            _titleBuilder("Previous", context),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: model.pastCampaigns!.length,
              itemBuilder: (BuildContext context, int index) {
                return CampaignTile(model.pastCampaigns![index]);
              },
            ),

            SizedBox(height: 20),
          ])));
        });
  }

  Widget _titleBuilder(String text, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Text(
        text,
        style: Theme.of(context).primaryTextTheme.headline3,
      ),
    );
  }
}
