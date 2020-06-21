import 'package:flutter/material.dart';

import 'package:app/models/Action.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/models/ViewModel.dart';
import 'package:app/models/Reward.dart';
import 'package:app/models/State.dart';
import 'package:app/routes.dart';

import 'package:app/pages/campaign/CampaignInfo/CampaignInfo.dart';
import 'package:app/pages/other/RewardComplete.dart';

import 'package:app/assets/StyleFrom.dart';
import 'package:app/assets/components/selectionItem.dart';
import 'package:app/assets/components/darkButton.dart';
import 'package:app/assets/components/textButton.dart';
import 'package:app/assets/components/customAppBar.dart';
import 'package:app/assets/routes/customRoute.dart';
import 'package:app/assets/components/pointsNotifier.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:url_launcher/url_launcher.dart';

final double HEADER_HEIGHT = 200;
final double H_PADDING = 10;

class ActionInfo extends StatefulWidget {
  final CampaignAction action;
  // Action's parent campaign
  final Campaign campaign;

  ActionInfo(this.action, this.campaign);
  @override
  _ActionInfoState createState() => _ActionInfoState();
}

class _ActionInfoState extends State<ActionInfo> with WidgetsBindingObserver {
  final double expandedHeight = 400.0;

  CampaignAction _action;
  // Action's parent campaign
  Campaign _campaign;
  @override
  void initState() {
    _campaign = widget.campaign;
    _action = widget.action;
    super.initState();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          text: "Action",
          backButtonText: "Home",
          context: context,
        ),
        key: scaffoldKey,
        body: StoreConnector<AppState, ViewModel>(
          converter: (Store<AppState> store) => ViewModel.create(store),
          builder: (BuildContext context, ViewModel viewModel) {
            bool completed = viewModel.userModel.user
                .getCompletedActions()
                .contains(_action.getId());
            return Stack(
              children: [
                ListView(
                  children: [
                    Container(
                      height: HEADER_HEIGHT,
                      width: double.infinity,
                      child: Stack(children: <Widget>[
                        Container(
                          height: HEADER_HEIGHT,
                          width: double.infinity,
                          child: Image.network(
                            _campaign.getHeaderImage(),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          height: HEADER_HEIGHT,
                          width: double.infinity,
                          color: Color.fromRGBO(0, 0, 0, 0.2),
                        ),
                        Container(
                          height: HEADER_HEIGHT,
                          child: Center(
                            child: Icon(
                              _action.getActionIconMap()['icon'],
                              size: 80,
                              color: _action.getActionIconMap()['iconColor'],
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: 10,
                            right: 10,
                            child: TextButton("See the Campaign",
                                iconRight: true,
                                fontColor: Colors.white, onClick: () {
                              Navigator.push(
                                  context,
                                  CustomRoute(
                                      builder: (context) =>
                                          CampaignInfo(campaign: _campaign)));
                            })),
                      ]),
                    ),
                    Container(
                      height: 10,
                      color: _action.getActionIconMap()['iconColor'],
                    ),
                    !completed
                        ? Container()
                        : Container(
                            width: double.infinity,
                            color: Color.fromRGBO(189, 192, 205, 1),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "Completed",
                                    style: textStyleFrom(
                                      Theme.of(context)
                                          .primaryTextTheme
                                          .headline5,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            )),

                    // Title
                    Padding(
                      padding: EdgeInsets.only(
                          top: 10, left: H_PADDING, right: H_PADDING),
                      child: Text(
                        _action.getTitle(),
                        style: textStyleFrom(
                          Theme.of(context).primaryTextTheme.headline3,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    // Time
                    Padding(
                      padding: EdgeInsets.only(
                          top: 10, left: H_PADDING, right: H_PADDING),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.access_time,
                            size: 15,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(_action.getTimeText(),
                              style: textStyleFrom(
                                Theme.of(context).primaryTextTheme.bodyText1,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor,
                                fontSize: 11,
                              )),
                        ],
                      ),
                    ),

                    SizedBox(height: 15),

                    // Completion message
                    viewModel.userModel.user.isCompleted(_action)
                        ? Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height:
                                      MediaQuery.of(context).size.width * 0.1,
                                  //child: Image(image: AssetImage('assets/imgs/partypopperemoji.png'),),
                                ),
                                Text("You have completed this action!")
                              ],
                            ),
                          )
                        : Container(height: 0),

                    // Text
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: H_PADDING, vertical: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("What should I do?",
                              style:
                                  Theme.of(context).primaryTextTheme.headline4),
                          SizedBox(height: 10),
                          Text(_action.getWhatDescription() ?? "",
                              style:
                                  Theme.of(context).primaryTextTheme.bodyText1),
                          SizedBox(height: 30),
                          Text("Why is this useful?",
                              style:
                                  Theme.of(context).primaryTextTheme.headline4),
                          SizedBox(height: 10),
                          Text(_action.getWhyDescription() ?? "",
                              style:
                                  Theme.of(context).primaryTextTheme.bodyText1),
                        ],
                      ),
                    ),

                    // Button
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.topCenter,
                      child: DarkButton("Take action",
                          style: DarkButtonStyles.Large,
                          inverted: true, onPressed: () {
                        launch(_action.getLink());
                      }),
                    ),
                    SizedBox(height: 20),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          TextButton("This action is not for me", fontSize: 14,
                              onClick: () {
                            showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (_) =>
                                  RejectDialogue(_action, viewModel),
                            );
                          }),
                        ]),
                    SizedBox(
                      height: 65,
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: FlatButton(
                    padding: EdgeInsets.all(0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      child: Center(
                          child: Text(
                        "Mark as done",
                        style: textStyleFrom(
                            Theme.of(context).primaryTextTheme.button,
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            color: Colors.white),
                      )),
                    ),
                    onPressed: () {
                      setState(() {
                        print("Print button pressed");
                        //completeAction(viewModel, context, _action);
                        viewModel.onCompleteAction(_action, context);
                      });
                    },
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ],
            );
          },
        ));
  }
}

class RejectDialogue extends StatefulWidget {
  final CampaignAction action;
  final ViewModel model;
  RejectDialogue(this.action, this.model);
  @override
  _RejectDialougeState createState() => _RejectDialougeState();
}

class _RejectDialougeState extends State<RejectDialogue> {
  String selectedReason = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
        content: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    padding: EdgeInsets.all(10),
                    icon: Icon(
                      Icons.close,
                      color: Color.fromRGBO(136, 136, 136, 1),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
              Container(
                  child: Text("Let us know why this action is not for you")),
              Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: rejectionReasons.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CheckboxSelectionItem(
                          title: rejectionReasons[index],
                          onChanged: (_) {
                            setState(() {
                              selectedReason = rejectionReasons[index];
                            });
                          },
                          value: selectedReason == rejectionReasons[index]);
                    }),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: DarkButton(
                  "Hide action",
                  onPressed: selectedReason == ""
                      ? null
                      : () {
                          widget.model
                              .onRejectAction(widget.action, selectedReason);
                          Navigator.of(context).pushNamed(Routes.actions);
                        },
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ));
  }
}
