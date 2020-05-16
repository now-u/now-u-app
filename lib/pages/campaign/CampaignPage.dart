import 'package:flutter/material.dart';

import 'package:app/pages/campaign/CampaignTile.dart';
import 'package:app/pages/campaign/CampaignInfo/CampaignInfo.dart';
import 'package:app/pages/campaign/SelectionComplete.dart';

import 'package:app/models/Campaign.dart';
import 'package:app/models/Campaigns.dart';
import 'package:app/models/ViewModel.dart';
import 'package:app/models/User.dart';
import 'package:app/models/State.dart';

import 'package:app/assets/routes/customRoute.dart';
import 'package:app/assets/components/darkButton.dart';
import 'package:app/assets/components/customAppBar.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

class CampaignPage extends StatelessWidget {
  final bool selectionMode;
  final int campaignId;

  CampaignPage(this.selectionMode, {this.campaignId});
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
        converter: (Store<AppState> store) => ViewModel.create(store),
        builder: (BuildContext context, ViewModel viewModel) {
          print("Before splash screen user is");
          print(viewModel.user.getName());
          return CampaignPageBody(viewModel ,selectionMode, campaignId: campaignId);
        },
    );
  }
}

class CampaignPageBody extends StatefulWidget {
  final bool selectionMode;
  final int campaignId;
  final ViewModel model;

  CampaignPageBody(this.model, this.selectionMode, {this.campaignId});

  @override
  _CampaignPageBodyState createState() => _CampaignPageBodyState();
}

class _CampaignPageBodyState extends State<CampaignPageBody> {
  List<Campaign> campaigns;
  Campaigns selectedCampaigns;
  User user;
  ViewModel model;
  bool onlyJoined;

  @override
  void initState() {
    campaigns = widget.model.campaigns.getActiveCampaigns().toList();
    user = widget.model.user;
    model = widget.model;
    onlyJoined = false;
    if (widget.campaignId != null) {
      Future (() {
          Navigator.push(
            context, 
            CustomRoute(builder: (context) => CampaignInfo(campaignId: widget.campaignId, model: widget.model))
          );
      });
    } else {
      super.initState();
    }
  }

  @override
  Widget build(BuildContext context) {
    // If given specific campaign, redirect to that page
    // Needs to be in future so happens after render of this page or something like that
    //var _campaigns = widget.model.campaigns.map((Campaign c) => c).toList();
    return 
      Scaffold(
        appBar: CustomAppBar(
          text: "Active Campaigns",
          context: context,
          hasBackButton: false,
        ), 
        body: SafeArea(
                child: ListView(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Switch(
                          value: onlyJoined,
                          onChanged: (value) {
                            setState(() {
                              onlyJoined = value;                              
                            });
                          },
                          materialTapTargetSize: MaterialTapTargetSize.padded,
                        )
                      ],
                    ),
                    model.user.getSelectedCampaigns().length == 0 && onlyJoined ?
                    Text("You havent selecetd any campaigns yet")
                    :
                    Container(),
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: <Widget> [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: campaigns.length,
                            itemBuilder: (BuildContext context, int index) {
                              return
                              !onlyJoined ? // Then return everything
                              CampaignTile(campaigns[index], model)
                              :  // Otherwise only return selected campaigns
                              model.user.getSelectedCampaigns().contains(campaigns[index].getId()) ? 
                              CampaignTile(campaigns[index], model)
                              : null;

                            },
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ]
                      ),     
                    ),
                  ], 
                ),
              ),
      );
    }
}
