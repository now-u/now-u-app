import 'package:flutter/material.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:app/models/Learning.dart';

import 'package:app/models/ViewModel.dart';
import 'package:app/models/State.dart';

import 'package:app/assets/components/customAppBar.dart';
import 'package:app/assets/components/selectionItem.dart';

class LearningCentrePage extends StatelessWidget {

  final int campaignId;
  LearningCentrePage(this.campaignId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, ViewModel>(
        converter: (Store<AppState> store) => ViewModel.create(store),
        builder: (BuildContext context, ViewModel viewModel) {
          return Column(
            children: <Widget>[
              FutureBuilder(
                future:  viewModel.api.getLearningCentre(campaignId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.getLearningTopics().length,
                        itemBuilder: (BuildContext context, int index) {
                          return LearningTopicSelectionItem(
                            topic: snapshot.data.getLearningTopics()[index],
                          );
                        }
                      ),
                    );
                  }
                  else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
              )
            ],
          );
        },
      )
    );
  }
}
