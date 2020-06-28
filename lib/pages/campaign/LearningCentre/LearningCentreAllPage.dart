import 'package:app/assets/components/header.dart';
import 'package:flutter/material.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:app/models/Learning.dart';

import 'package:app/models/ViewModel.dart';
import 'package:app/models/State.dart';

import 'package:app/assets/components/customAppBar.dart';
import 'package:app/assets/components/selectionItem.dart';
import 'package:app/assets/StyleFrom.dart';
import 'package:app/assets/components/textButton.dart';
import 'package:app/assets/components/customScrollableSheet.dart';

const double CIRCLE_1_RADIUS = 150;
const double CIRCLE_2_RADIUS = 250;
const double HEADING_HEIGHT = 250;

class LearningCentreAllPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StoreConnector<AppState, ViewModel>(
      converter: (Store<AppState> store) => ViewModel.create(store),
      builder: (BuildContext context, ViewModel viewModel) {
        return ScrollableSheetPage(
            shadow: Shadow(color: Colors.transparent),
            // Header
            header: 
              Container(
                color: Colors.white,
                height: HEADING_HEIGHT,
                child: Stack(
                  children: [
                    Positioned(
                      right: -30,
                      bottom: -10,
                      child: Image.asset(
                        "assets/imgs/graphics/ilstr_learning@3x.png",
                        height: 220,
                      ),
                    ),
                    PageHeader(
                      title: "Learning",
                    )
                  ],
                ),
              ),
            // BODY
            children: [
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: viewModel.campaigns.activeLength(),
                itemBuilder: (context, index) {
                  return LearningCentreCampaignSelectionItem(
                      campaign: viewModel.campaigns.getActiveCampaigns()[index]);
                },
              )
            ]
        );
      },
    ));
  }
}
