import 'package:flutter/material.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:app/models/ViewModel.dart';
import 'package:app/models/State.dart';

class LearningCentrePage extends StatelessWidget {

  final int campaignId;
  LearningCentrePage(this.campaignId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, ViewModel>(
        converter: (Store<AppState> store) => ViewModel.create(store),
        builder: (BuildContext context, ViewModel viewModel) {
          print("Before splash screen user is");
          return FutureBuilder(
            //future:  viewModel.api.getLearningCentre(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container();
              }
              else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
          );
        },
      )
    );
  }
}
