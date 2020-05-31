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
import 'package:app/assets/components/inputs.dart';
import 'package:app/assets/StyleFrom.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

//class CampaignPage extends StatelessWidget {
//
//  CampaignPage();
//  @override
//  Widget build(BuildContext context) {
//    return StoreConnector<AppState, ViewModel>(
//        converter: (Store<AppState> store) => ViewModel.create(store),
//        builder: (BuildContext context, ViewModel viewModel) {
//          print("Before splash screen user is");
//          return CampaignPageBody(viewModel);
//        },
//    );
//  }
//}

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
    onlyJoined = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // If given specific campaign, redirect to that page
    // Needs to be in future so happens after render of this page or something like that
    //var _campaigns = widget.model.campaigns.map((Campaign c) => c).toList();
    return 
      Scaffold(
        body: 
          StoreConnector<AppState, ViewModel>(
            converter: (Store<AppState> store) => ViewModel.create(store),
            builder: (BuildContext context, ViewModel viewModel) {
              print("In page campaigns");
              print(viewModel.campaigns);
              print(viewModel.campaigns.getActiveCampaigns());
              print(viewModel.campaigns.getActiveCampaigns().toList()[0]);
              print(viewModel.campaigns.getActiveCampaigns().toList()[1]);
              print(viewModel.campaigns.getActiveCampaigns().toList()[2]);
              campaigns = viewModel.campaigns.getActiveCampaigns().toList();
              user = viewModel.userModel.user;
              return  SafeArea(
                child: ListView(
                  children: <Widget>[
                    SafeArea(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                          },
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(
                                Icons.book,
                                color: Theme.of(context).primaryColor,  
                              ),
                            ),
                          ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Container(
                        width: double.infinity,
                        child: Text(
                          "Active Campaigns",
                          textAlign: TextAlign.left,
                          style: Theme.of(context).primaryTextTheme.headline2,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "Show joined campaigns only",
                              style: textStyleFrom(
                                Theme.of(context).primaryTextTheme.bodyText1,
                                color: Color.fromRGBO(63,61,86, 1),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          CustomSwitch(
                            value: onlyJoined,
                            onChanged: (value) {
                              setState(() {
                                onlyJoined = value;                              
                              });
                            },
                            activeColor: Theme.of(context).primaryColor,
                            inactiveColor: Color.fromRGBO(221,221,221,1)
                          )
                        ],
                      )
                    ),
                    viewModel.userModel.user.getSelectedCampaigns().length == 0 && onlyJoined ?
                    Text("You havent selecetd any campaigns yet")
                    :
                    Container(),
                    Container(
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
                              CampaignTile(campaigns[index])
                              :  // Otherwise only return selected campaigns
                              viewModel.userModel.user.getSelectedCampaigns().contains(campaigns[index].getId()) ? 
                              CampaignTile(campaigns[index])
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
              );
            },
          )
      );
    }
}
