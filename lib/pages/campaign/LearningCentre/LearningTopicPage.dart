import 'package:app/assets/StyleFrom.dart';
import 'package:flutter/material.dart';

import 'package:app/assets/components/customAppBar.dart';
import 'package:app/assets/components/selectionItem.dart';

import 'package:app/models/ViewModel.dart';
import 'package:app/models/State.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:app/models/Learning.dart';

class LearningTopicPage extends StatelessWidget {
  final LearningTopic topic;
  LearningTopicPage(this.topic);
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: (Store<AppState> store) => ViewModel.create(store),
      builder: (BuildContext context, ViewModel viewModel) {
        return Scaffold(
          appBar: CustomAppBar(
            backButtonText: "Back",
            context: context,
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                  child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  // Header
                  Container(
                    width: double.infinity,
                    height: 180,
                    child: Image.network(topic.getImageLink(), fit: BoxFit.cover),
                  ),

                  SizedBox(height: 20),

                  // Body

                  // Title
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      topic.getTitle(),
                      style: textStyleFrom(
                        Theme.of(context).primaryTextTheme.headline3,
                      ),
                    ),
                  ),

                  // Our answer
                  SizedBox(height: 15),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      topic.getOurAnswer(),
                      style: textStyleFrom(
                        Theme.of(context).primaryTextTheme.headline5,
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  // Actions
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: topic.getResources().length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: LearningResouceSelectionItem(
                          resource: topic.getResources()[index],
                          extraOnClick: () {viewModel.onCompleteLearningResource(topic.getResources()[index]);},
                          completed: viewModel.userModel.user.getCompletedLearningResources().contains(topic.getResources()[index].getId())
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 20),
                ],
              ))
            ],
          ),
        );
      }
    );
  }
}
