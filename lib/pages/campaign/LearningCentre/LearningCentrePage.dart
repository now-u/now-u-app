import 'package:flutter/material.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:app/models/Learning.dart';
import 'package:app/routes.dart';

import 'package:app/models/ViewModel.dart';
import 'package:app/models/State.dart';

import 'package:app/assets/components/customAppBar.dart';
import 'package:app/assets/components/selectionItem.dart';
import 'package:app/assets/StyleFrom.dart';
import 'package:app/assets/components/textButton.dart';

const double CIRCLE_1_RADIUS = 150;
const double CIRCLE_2_RADIUS = 250;
const double HEADING_HEIGHT = 250;

class LearningCentrePage extends StatelessWidget {
  final int campaignId;
  LearningCentrePage(this.campaignId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StoreConnector<AppState, ViewModel>(
      converter: (Store<AppState> store) => ViewModel.create(store),
      builder: (BuildContext context, ViewModel viewModel) {
        return FutureBuilder(
            future: viewModel.api.getLearningCentre(campaignId),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? Center(child: CircularProgressIndicator())
                  : ListView(
                      children: <Widget>[
                        // Header
                        Container(
                              child: SafeArea(
                                  child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextButton(
                                              "Back",
                                              onClick: () {
                                                Navigator.of(context).pop();
                                              },
                                              iconLeft: true,
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              viewModel.campaigns.getActiveCampaigns().map((c) => c.getId()).contains(campaignId) ? 
                                              viewModel.campaigns.getActiveCampaigns().firstWhere((c) => c.getId() == campaignId).getTitle() 
                                              :
                                              "Learning centre",
                                              style: Theme.of(context)
                                                  .primaryTextTheme
                                                  .headline2,
                                            )
                                          ],
                                        ),
                                      )),
                          ),
                        ),
                        // BODY
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data.getLearningTopics().length,
                          itemBuilder: (context, index) {
                            return LearningTopicSelectionItem(
                              topic: snapshot.data.getLearningTopics()[index],
                            );
                          },
                        ),

                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: TextButton(
                                "See campaign",
                                onClick: () {
                                  Navigator.of(context).pushNamed(Routes.campaignInfo, arguments: campaignId);
                                },
                              )
                            ),
                          ]
                        )
                      ],
                    );
            });
      },
    ));
  }
}
