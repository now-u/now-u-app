import 'package:nowu/assets/StyleFrom.dart';
import 'package:nowu/assets/components/customAppBar.dart';
import 'package:nowu/assets/components/buttons/darkButton.dart';
import 'package:nowu/assets/components/textButton.dart';
import 'package:nowu/assets/icons/customIcons.dart';
import 'package:nowu/models/Action.dart';
import 'package:nowu/viewmodels/action_info_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';

final double theHeaderHeight = 200;
final double hPadding = 10;

class ActionInfoArguments {
  final int actionId;

  ActionInfoArguments({
    required this.actionId,
  });
}

class ActionInfo extends StatefulWidget {
  final ActionInfoArguments args;

  ActionInfo(this.args);

  @override
  _ActionInfoState createState() => _ActionInfoState();
}

class _ActionInfoState extends State<ActionInfo> with WidgetsBindingObserver {
  final double expandedHeight = 400.0;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ActionInfoViewModel>.reactive(
        viewModelBuilder: () => ActionInfoViewModel(),
        onModelReady: (model) => model.fetchAction(widget.args.actionId),
        builder: (context, model, child) {
          return Scaffold(
              appBar: customAppBar(
                text: model.busy ? "Loading..." : model.action!.type.name,
                backButtonText: "Actions",
                context: context,
              ),
              key: scaffoldKey,
              body: model.busy
                  ? Center(child: CircularProgressIndicator())
                  : Stack(children: [
                      ListView(
                        children: [
                          Container(
                            width: double.infinity,
                            color: model.action!.type.secondaryColor,
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 20),
                                child: Text(model.action!.title)),
                          ),
                          Container(
                            height: model.action!.isCompleted ? null : 10,
                            color: model.action!.type.primaryColor,
                            child: model.action!.isCompleted
                                ? Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        CustomIcons.ic_check,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 7),
                                      Text(
                                        "Done",
                                        style: textStyleFrom(
                                          Theme.of(context)
                                              .primaryTextTheme
                                              .bodyText1,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                          ),
                          Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        model.action!.type.icon,
                                        color: model.action!.type.primaryColor,
                                      ),
                                      SizedBox(width: 6),
                                      Icon(FontAwesomeIcons.clock, size: 12),
                                      SizedBox(width: 3),
                                      Text(model.action!.timeText),
                                    ],
                                  ),
                                  GestureDetector(
                                      // TODO This must go to the causes info page
                                      // For now this can be the home explore page filtered by a single cause
                                      onTap: model.navigateToCauseExplorePage,
                                      child: Container(
                                        height: 20,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Text(
                                            "See cause",
                                            style: textStyleFrom(
                                              Theme.of(context)
                                                  .primaryTextTheme
                                                  .headline4,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context)
                                                  .primaryColorDark,
                                            ),
                                          ),
                                        ),
                                      )),
                                ],
                              )),

                          SizedBox(height: 15),

                          // Text
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: hPadding, vertical: 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("What should I do?",
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .headline4),
                                SizedBox(height: 10),
                                Text(model.action!.whatDescription,
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1),
                              ],
                            ),
                          ),

                          // Buttons
                          SizedBox(height: 20),

                          // First
                          Center(
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                "First",
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headline2,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: DarkButton(
                              "Take action",
                              size: DarkButtonSize.Large,
                              style: DarkButtonStyle.Secondary,
                              onPressed: () {
                                model.launchAction();
                              },
                            ),
                          ),

                          !model.action!.isCompleted
                              ?
                              // If not completed show the then button
                              Column(
                                  children: [
                                    //Dividor
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 20),
                                        child: Container(
                                          width: double.infinity,
                                          color:
                                              Color.fromRGBO(222, 223, 232, 1),
                                          height: 1,
                                        )),

                                    // Then
                                    Center(
                                        child: Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Text(
                                        "Then",
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .headline2,
                                      ),
                                    )),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: DarkButton("Mark as done",
                                          size: DarkButtonSize.Large,
                                          style: DarkButtonStyle.Secondary,
                                          onPressed: () {
                                        setState(() {
                                          model.completeAction();
                                        });
                                      }),
                                    ),
                                  ],
                                )
                              : // Otherwise show the youre great thing
                              Padding(
                                  padding: EdgeInsets.only(top: 20, bottom: 10),
                                  child: Container(
                                      color: model.action!.type.secondaryColor,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              "Many small actions have a big impact",
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .primaryTextTheme
                                                  .headline2,
                                            ),
                                            SizedBox(height: 10),
                                            RichText(
                                              textAlign: TextAlign.center,
                                              text: TextSpan(
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .bodyText1,
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        "Thank you for completing this action and contributing to this important cause!",
                                                  ),
                                                  // TODO What is happening to this?
                                                  // TextSpan(
                                                  //     text: _campaign!.title,
                                                  //     style: textStyleFrom(
                                                  //       Theme.of(context)
                                                  //           .primaryTextTheme
                                                  //           .bodyText1,
                                                  //       color: Theme.of(context)
                                                  //           .buttonColor,
                                                  //     ),
                                                  //     recognizer:
                                                  //         TapGestureRecognizer()
                                                  //           ..onTap = () {
                                                  //             Navigator.of(context)
                                                  //                 .pushNamed(
                                                  //                     Routes
                                                  //                         .campaignInfo,
                                                  //                     arguments:
                                                  //                         _campaign!
                                                  //                             .id);
                                                  //           }),
                                                  // TextSpan(
                                                  //   text: " campaign.",
                                                  // ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 15),
                                            Icon(FontAwesomeIcons.calendar,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                size: 60),
                                            SizedBox(height: 20),
                                          ],
                                        ),
                                      ))),

                          SizedBox(height: 30),

                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: hPadding, vertical: 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Why is this useful?",
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .headline4),
                                SizedBox(height: 10),
                                Text(model.action!.whyDescription,
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1),
                              ],
                            ),
                          ),

                          SizedBox(height: 20),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                model.action!.isCompleted
                                    ? CustomTextButton("Mark as not done",
                                        fontSize: 14, onClick: () {
                                        model.removeActionStatus();
                                      })
                                    : Container(),
                                //TextButton("Hide this action", fontSize: 14,
                                //    onClick: () {
                                //  showDialog(
                                //    context: context,
                                //    barrierDismissible: true,
                                //    builder: (_) =>
                                //        RejectDialogue(_action, viewModel),
                                //  );
                                //}),

                                SizedBox(width: 10),
                              ]),
                          SizedBox(height: 15),
                          !model.action!.isCompleted
                              ? Container()
                              : Container(
                                  height: 65,
                                  color: Color.fromRGBO(155, 159, 177, 1),
                                  child: Center(
                                    child: Text(
                                      "You completed this action",
                                      style: textStyleFrom(
                                        Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1,
                                      ),
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: model.action!.isCompleted ? 0 : 70,
                          ),
                        ],
                      ),
                    ]));
        });
  }
}
