import 'package:app/assets/StyleFrom.dart';
import 'package:flutter/material.dart';

import 'package:app/assets/components/customAppBar.dart';
import 'package:app/assets/components/selectionItem.dart';
import 'package:app/assets/components/custom_network_image.dart';

import 'package:stacked/stacked.dart';
import 'package:app/viewmodels/learning_topic_model.dart';

import 'package:app/models/Learning.dart';

class LearningTopicPage extends StatelessWidget {
  final LearningTopic topic;
  LearningTopicPage(this.topic);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LearningTopicViewModel>.reactive(
        viewModelBuilder: () => LearningTopicViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: customAppBar(
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
                      child: CustomNetworkImage(topic.imageLink,
                          fit: BoxFit.cover),
                    ),

                    SizedBox(height: 20),

                    // Body

                    // Title
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        topic.title,
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
                        topic.ourAnswer,
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
                      itemCount: topic.resources.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: LearningResouceSelectionItem(
                              resource: topic.resources[index],
                              extraOnClick: () {
                                model.completeLearningResource(
                                    topic.resources[index].id);
                              },
                              completed: model.learningResourceIsCompleted(
                                  topic.resources[index].id)),
                        );
                      },
                    ),

                    SizedBox(height: 20),
                  ],
                ))
              ],
            ),
          );
        });
  }
}
