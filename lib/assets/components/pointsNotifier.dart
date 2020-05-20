import 'package:flutter/material.dart';

import 'package:app/models/ViewModel.dart';
import 'package:app/models/State.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';


class PointsNotifier extends StatelessWidget {
  PointsNotifier({
    @required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: (store) => ViewModel.create(store),
      builder: (context, vm) => child,
      onWillChange: (state, viewModel) {
        Scaffold.of(context).showSnackBar();
      },
      distinct: true,
    );
  }
}
