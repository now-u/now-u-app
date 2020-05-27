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
          return FutureBuilder(
            future: viewModel.api.getLearningCentre(campaignId),
            builder: (context, snapshot) {
              return CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    backgroundColor: Colors.white,
                    expandedHeight: 300,
                    automaticallyImplyLeading: false,
                    flexibleSpace: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            height: 200,
                            width: 200,
                            child: Image.asset(
                              "assets/imgs/learning.png",
                              width: 200,
                              height: 200,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate ( (context, index) {
                      return LearningTopicSelectionItem(
                        topic: snapshot.data.getLearningTopics()[index],
                      );
                    }, childCount: snapshot.data.getLearningTopics().length ),
                  )
                ],
              );
            }
          );
        },
      )
    );
  }
}
