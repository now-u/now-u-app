import 'package:flutter/material.dart';

import 'package:app/assets/StyleFrom.dart';

import 'package:app/models/State.dart';
import 'package:app/models/ViewModel.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ProgressBar extends StatelessWidget {
  final double width;
  final double widthAsDecimal;
  final double height;
  final double progress;
  final Color doneColor;
  final Color toDoColor;

  final BorderRadius _borderRadius = BorderRadius.all(Radius.circular(15));

  ProgressBar({
    @required this.progress,
    this.width, 
    this.widthAsDecimal, 
    this.height,
    this.doneColor,
    this.toDoColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            width: width ?? MediaQuery.of(context).size.width * (widthAsDecimal ?? 1),
            height: height ?? 20,
            decoration: BoxDecoration(
              color: toDoColor ?? Color.fromRGBO(255, 255, 255, 0.2),
              borderRadius: _borderRadius,
            ),
          ),
          Container(
            width: (width ?? MediaQuery.of(context).size.width) * progress * (widthAsDecimal ?? 1),
            height: height ?? 20,
            decoration: BoxDecoration(
              color: doneColor ?? Theme.of(context).accentColor,
              borderRadius: _borderRadius,
            ),
          ),
        ],
      )
    );
  }
}

class ActionProgressTile extends StatelessWidget {
  final double actionsHomeTileTextWidth = 0.5;
  final double actionsHomeTileHeight = 170;
  final double actionsHomeTilePadding = 15;

  @override
  Widget build(BuildContext context) {
    return 
     Container(
       child: Stack(
         children: <Widget>[
              ActionProgressData(
                actionsHomeTileHeight: actionsHomeTileHeight,
                actionsHomeTilePadding: actionsHomeTilePadding,
                actionsHomeTileTextWidth: actionsHomeTileTextWidth,
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * (actionsHomeTileTextWidth) + 20,
                //top: actionsHomeTilePadding,
                top: 0,
                child: Container(
                  height: actionsHomeTileHeight,
                  width: MediaQuery.of(context).size.width * (1-actionsHomeTileTextWidth),
                  child: Image(
                    image: AssetImage('assets/imgs/progress.png'),
                  )
                )
              ),
         ],
        )
      );
  }
}

class ActionProgressData extends StatelessWidget {
  final double actionsHomeTileTextWidth;
  final double actionsHomeTileHeight;
  final double actionsHomeTilePadding;

  ActionProgressData({
    @required this.actionsHomeTilePadding,
    @required this.actionsHomeTileHeight,
    @required this.actionsHomeTileTextWidth,
  });

  @override
  Widget build(BuildContext context) {
            return StoreConnector<AppState, ViewModel>(
                converter: (Store<AppState> store) => ViewModel.create(store),
                builder: (BuildContext context, ViewModel viewModel) {
                  final int numberOfCompletedAction = viewModel.userModel.user.getCompletedActions().length;
                  final int numberOfSelectedActions = viewModel.campaigns.getActions().length;
                return Padding(
                  padding: EdgeInsets.all(actionsHomeTilePadding),
                  child: Container(
                    width: double.infinity,
                    height: actionsHomeTileHeight,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: 
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              (numberOfSelectedActions - numberOfCompletedAction).toString()
                              + " actions left",
                              style: textStyleFrom(
                                Theme.of(context).primaryTextTheme.headline3,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            ProgressBar(
                              progress: numberOfCompletedAction/numberOfSelectedActions,
                              width: MediaQuery.of(context).size.width * (actionsHomeTileTextWidth - 0.12) + 20,
                              height: 15,
                            ),
                            SizedBox(height: 15,),
                            // TODO need to get user active campiangs not all active campaigns
                            Container(
                              width: MediaQuery.of(context).size.width * actionsHomeTileTextWidth - 5,
                              child: Text(
                                "You have completed " + numberOfCompletedAction.toString() + " of " + numberOfSelectedActions.toString() + " total actions from your active campaigns. Way to go!",
                                textAlign: TextAlign.left,
                                style: textStyleFrom(
                                  Theme.of(context).primaryTextTheme.bodyText1,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  height: 1.0,
                                  fontSize: 13
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ),
                  );
                }
              ); 
  }
}

