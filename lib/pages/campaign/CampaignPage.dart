import 'package:flutter/material.dart';

import 'package:app/models/Campaign.dart';
import 'package:app/models/Campaigns.dart';
import 'package:app/models/ViewModel.dart';
import 'package:app/models/User.dart';
import 'package:app/models/State.dart';

import 'package:app/routes.dart';

import 'package:app/assets/components/header.dart';
import 'package:app/assets/components/campaignTile.dart';
import 'package:app/assets/StyleFrom.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

class CampaignPage extends StatefulWidget {
  @override
  _CampaignPageState createState() => _CampaignPageState();
}

class _CampaignPageState extends State<CampaignPage> {
  List<Campaign> campaigns;
  Campaigns selectedCampaigns;
  User user;
  bool onlyJoined;

  @override
  void initState() {
    campaigns = [];
    onlyJoined = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // If given specific campaign, redirect to that page
    // Needs to be in future so happens after render of this page or something like that
    //var _campaigns = widget.model.campaigns.map((Campaign c) => c).toList();
    return Scaffold(
      body: StoreConnector<AppState, ViewModel>(
      onInit: (Store<AppState> store) {
        campaigns = store.state.campaigns.getActiveCampaigns();
        user = store.state.userState.user;
      },
      converter: (Store<AppState> store) => ViewModel.create(store),
      builder: (BuildContext context, ViewModel viewModel) {
        if (viewModel.loading) {
          return CircularProgressIndicator();
        }
        print("In page campaigns");
        print(viewModel.campaigns);
        print(viewModel.campaigns.getActiveCampaigns());
        print(viewModel.campaigns.getActiveCampaigns().toList()[0]);
        print(viewModel.campaigns.getActiveCampaigns().toList()[1]);
        print(viewModel.campaigns.getActiveCampaigns().toList()[2]);
        if (user == null) {
          Navigator.of(context).pushNamed('/');
          
        }
        return Stack(
          children: [
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
                  viewModel.getActiveSelectedCampaings().activeLength() == 0 &&
                          onlyJoined
                      ? Center(
                          child: Text("You havent selected any campaigns yet"),
                        )
                      : Container(),
                  Container(
                    child: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: campaigns.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CampaignTile(campaigns[index]);
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
                    style: textStyleFrom(Theme.of(context).primaryTextTheme.button,
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

          ]
        );
      },
    ));
  }
}
