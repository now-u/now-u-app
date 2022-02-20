import 'package:app/assets/components/buttons/customWidthButton.dart';
import 'package:app/assets/components/causes/causeTile.dart';
import 'package:app/assets/components/causes/causeTileGrid.dart';
import 'package:app/assets/components/progressTile.dart';
import 'package:app/pages/explore/ExploreSection.dart';
import 'package:flutter/material.dart';

import 'package:app/routes.dart';

import 'package:app/assets/components/campaignTile.dart';
import 'package:app/pages/other/InfoPage.dart';

import 'package:app/assets/components/buttons/darkButton.dart';
import 'package:app/assets/components/customScrollableSheet.dart';
import 'package:app/assets/components/smoothPageIndicatorEffect.dart';
import 'package:app/assets/components/textButton.dart';
import 'package:app/assets/components/notifications.dart';
import 'package:app/assets/StyleFrom.dart';

import 'package:app/models/Notification.dart';
import 'package:app/models/Campaign.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:stacked/stacked.dart';
import 'package:app/viewmodels/home_model.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

const double BUTTON_PADDING = 10;
const PageStorageKey campaignCarouselPageKey = PageStorageKey(1);

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorFrom(
          Theme.of(context).primaryColor,
          opacity: 0.05,
        ),
        body: ViewModelBuilder<HomeViewModel>.reactive(
            viewModelBuilder: () => HomeViewModel(),
            onModelReady: (model) => model.init(),
            builder: (context, model, child) {
              return ScrollableSheetPage(
                header: model.notifications!.length > 0
                    ? HeaderWithNotifications(
                        name: model.currentUser!.getName(),
                        notification: model.notifications![0],
                        dismissNotification: model.dismissNotification,
                      )
                    : HeaderStyle1(name: model.currentUser!.getName()),
                children: [
                  Column(children: <Widget>[
                    ProgressTile(
                      campaignsScore: model.numberOfJoinedCampaigns,
                      actionsScore: model.numberOfCompletedActions,
                      learningsScore: -1,
                    ),
                    ExploreSectionWidget.fromModel(model.myCampaigns, model),
                    ExploreSectionWidget.fromModel(model.myActions, model),
                    CustomWidthButton(
                      'Explore',
                      onPressed: () {
                        model.goToExplorePage();
                      },
                      backgroundColor: Theme.of(context).primaryColor,
                      size: ButtonSize.Medium,
                      fontSize: 20.0,
                      buttonWidthProportion: 0.8,
                    ),
                    ExploreSectionWidget.fromModel(model.suggestedCampaigns, model),
                    ExploreSectionWidget.fromModel(model.inTheNews, model),
                    model.causes != []
                        ? GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemCount: model.causes.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(height: 100, color: Colors.blue);
                              return CauseTile(
                                  gestureFunction: () => null,
                                  cause: model.causes[index],
                                  getInfoFunction: () =>
                                      model.getCausePopup(model.causes[index]));
                            })
                        : CircularProgressIndicator()
                  ])
                ],
              );
            }));
  }
}

class HeaderStyle1 extends StatelessWidget {
  final String? name;

  HeaderStyle1({this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).errorColor,
            Theme.of(context).errorColor,
          ])),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(
                15, MediaQuery.of(context).size.height * 0.1, 0, 0),
            child: Text(
              "Hello, \n$name",
              style: textStyleFrom(
                Theme.of(context).primaryTextTheme.headline2,
                color: Colors.white,
                height: 0.95,
              ),
            ),
          ),
          Positioned(
              right: -20,
              //top: actionsHomeTilePadding,
              bottom: MediaQuery.of(context).size.height * 0.05,
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Image(
                    image:
                        AssetImage('assets/imgs/graphics/ilstr_home_1@3x.png'),
                  ))),
        ],
      ),
    );
  }
}

class HeaderWithNotifications extends StatelessWidget {
  final String? name;
  final InternalNotification notification;
  final Function dismissNotification;

  HeaderWithNotifications(
      {required this.name,
      required this.notification,
      required this.dismissNotification});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * (1 - 0.4),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorDark,
      ),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome back, $name",
                    style: textStyleFrom(
                      Theme.of(context).primaryTextTheme.headline4,
                      color: Colors.white,
                      height: 0.95,
                    ),
                  ),
                  SizedBox(height: 10),
                  NotificationTile(notification,
                      dismissFunction: dismissNotification),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
