import 'package:flutter/material.dart';

import 'package:app/routes.dart';

import 'package:app/assets/components/selectionItem.dart';
import 'package:app/assets/components/textButton.dart';

import 'package:stacked/stacked.dart';
import 'package:app/viewmodels/learning_center_model.dart';

const double CIRCLE_1_RADIUS = 150;
const double CIRCLE_2_RADIUS = 250;
const double HEADING_HEIGHT = 250;

class LearningCentrePage extends StatelessWidget {
  final int campaignId;
  LearningCentrePage(this.campaignId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ViewModelBuilder<LearningCenterViewModel>.reactive(
      viewModelBuilder: () => LearningCenterViewModel(),
      onModelReady: (model) {
        model.fetchLearningCentre(campaignId);
      },
      builder: (context, model, child) {
        return model.learningCenter == null
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextButton(
                                  "Back",
                                  onClick: () {
                                    Navigator.of(context).pop();
                                  },
                                  iconLeft: true,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  model.campaigns
                                          .map((c) => c.getId())
                                          .contains(campaignId)
                                      ? model.campaigns
                                          .firstWhere(
                                              (c) => c.getId() == campaignId)
                                          .getTitle()
                                      : "Learning centre",
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
                    itemCount: model.learningTopics.length,
                    itemBuilder: (context, index) {
                      return LearningTopicSelectionItem(
                        topic: model.learningTopics[index],
                      );
                    },
                  ),

                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: CustomTextButton(
                              "See campaign",
                              onClick: () {
                                Navigator.of(context).pushNamed(
                                    Routes.campaignInfo,
                                    arguments: campaignId);
                              },
                            )),
                      ])
                ],
              );
      },
    ));
  }
}
