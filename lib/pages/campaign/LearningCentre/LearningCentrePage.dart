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
                  : Column(
                      children: <Widget>[
                        // Header
                        Container(
                          color: Colors.white,
                          height: HEADING_HEIGHT,
                          child: Stack(
                            children: [
                              Positioned(
                                  top: -40,
                                  left:
                                      MediaQuery.of(context).size.width * 0.5 -
                                          40,
                                  child: Container(
                                    height: CIRCLE_1_RADIUS,
                                    width: CIRCLE_1_RADIUS,
                                    decoration: BoxDecoration(
                                      color: colorFrom(
                                        Theme.of(context).primaryColor,
                                        opacity: 0.2,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          CIRCLE_1_RADIUS / 2),
                                    ),
                                  )),
                              Positioned(
                                  top: 120,
                                  left: -80,
                                  child: Container(
                                    height: CIRCLE_2_RADIUS,
                                    width: CIRCLE_2_RADIUS,
                                    decoration: BoxDecoration(
                                      color: colorFrom(
                                        Theme.of(context).primaryColor,
                                        opacity: 0.2,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          CIRCLE_2_RADIUS / 2),
                                    ),
                                  )),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Image.asset(
                                  "assets/imgs/learning.png",
                                  height: 180,
                                ),
                              ),
                              SafeArea(
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
                                              "Menu",
                                              onClick: () {
                                                Navigator.of(context).pop();
                                              },
                                              iconLeft: true,
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              "Learning centre",
                                              style: Theme.of(context)
                                                  .primaryTextTheme
                                                  .headline2,
                                            )
                                          ],
                                        ),
                                      ))),
                            ],
                          ),
                        ),
                        // BODY
                        Expanded(
                            child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.getLearningTopics().length,
                          itemBuilder: (context, index) {
                            return LearningTopicSelectionItem(
                              topic: snapshot.data.getLearningTopics()[index],
                            );
                          },
                        ))
                      ],
                    );
            });
      },
    ));
  }
}
