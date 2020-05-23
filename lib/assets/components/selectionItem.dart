import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:url_launcher/url_launcher.dart';

import 'package:app/models/Action.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/models/Learning.dart';

import 'package:app/pages/action/ActionInfo.dart';
import 'package:app/pages/campaign/LearningCentre/LearningTopicPage.dart';

import 'package:app/assets/routes/customRoute.dart';
import 'package:app/assets/StyleFrom.dart';

class SelectionItem extends StatelessWidget {
  final String text;
  final GestureTapCallback onClick;
  final IconData icon;
  final Color arrowColor;
  final EdgeInsetsGeometry padding;
  final Widget child;

  SelectionItem({
    this.text,
    this.onClick,
    this.icon,
    this.arrowColor,
    this.padding,
    this.child,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onClick,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              icon == null ? Container() : Icon(icon),
              // If given child will do that
              child != null ? 
              Container(
                child: child,
              )
              :
              // Else will do text
              Padding(
                padding: this.padding ?? EdgeInsets.all(15),
                child: Text(
                  text,
                  style: Theme.of(context).primaryTextTheme.bodyText1,
                ),
              ),
            ],
          ),
          Transform.rotate(
            angle: 180 * math.pi / 180,
            child: Icon(
              Icons.chevron_left,
              size: 25,
              color: arrowColor == null
                  ? Theme.of(context).primaryColor
                  : arrowColor,
            ),
          ),
        ],
      ),
    );
  }
}

class ActionSelectionItem extends StatelessWidget {
  @required final CampaignAction action;
  @required final Campaign campaign;
  final Function extraOnTap;
  final bool isNew;

  ActionSelectionItem({
    this.action,
    this.campaign,
    this.extraOnTap,
    this.isNew,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context,
              CustomRoute(builder: (context) => ActionInfo(action, campaign)));
        },
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: colorFrom(Theme.of(context).primaryColor,
                        opacity: 0.05)
                    ),
                child: 
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: <Widget>[
                      Stack (
                        children: <Widget> [
                          Padding(
                           padding: EdgeInsets.all(5),
                           child: Container(
                             width: 50,
                             height: 50,
                             decoration: BoxDecoration(
                                 borderRadius:
                                     BorderRadius.all(Radius.circular(8)),
                                 color: action
                                     .getActionIconMap()['iconBackgroundColor']),
                             child: Center(
                               child: Icon(
                                 action.getActionIconMap()['icon'],
                                 color: action.getActionIconMap()['iconColor'],
                                 size: 30,
                               ),
                             ),
                           ),
                          ), 
                          !(isNew ?? false) ? Container() :
                          Positioned(
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 12,
                                minHeight: 12,
                              ),
                            ),
                          ),
                        ]
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: SelectionItem(
                           onClick: () {
                             if (extraOnTap != null) {
                               extraOnTap();
                             }
                             Navigator.push(
                                 context,
                                 CustomRoute(
                                     builder: (context) =>
                                         ActionInfo(action, campaign)));
                            },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width * 0.8 - 50,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    action.getTitle(),
                                    style: Theme.of(context).primaryTextTheme.bodyText1,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                                  Row(
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
                                      Text(
                                        action.getTimeText(),
                                        style: textStyleFrom(
                                          Theme.of(context).primaryTextTheme.bodyText1,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 11,
                                        )
                                      ),
                                    ],
                                  ),
                                ]
                              )
                          ),
                      )
                    ]
                  ),
                )
            )
        ),
      );
  }
}

class LearningResouceSelectionItem extends StatelessWidget {
  final double defaultOuterHpadding = 10;
  final double defaultInnerHpadding = 10;
  final double defaultIconWidth = 50;
  
  final LearningResource resource;
  final double innerHpadding;
  final double outerHpadding;
  final double iconWidth;

  LearningResouceSelectionItem({
    @required this.resource,
    this.iconWidth,
    this.innerHpadding,
    this.outerHpadding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          launch(resource.getLink());
        },
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: outerHpadding ?? defaultOuterHpadding),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: colorFrom(Theme.of(context).primaryColor,
                        opacity: 0.05)
                    ),
                child: 
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: innerHpadding ?? defaultInnerHpadding),
                  child: Row(
                    children: <Widget>[
                      Stack (
                        children: <Widget> [
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Container(
                              width: iconWidth ?? defaultIconWidth,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  color: colorFrom(
                                    Theme.of(context).primaryColor,
                                    opacity: 0.15
                                  ),
                              ),
                              child: Center(
                                child: Icon(
                                  resource.getTypeIcon(),
                                  size: 30,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                           ),
                          ), 
                        ]
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: SelectionItem(
                          onClick: () {
                            launch(resource.getLink());
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width - (outerHpadding ?? defaultOuterHpadding) * 2 - (innerHpadding ?? defaultInnerHpadding) * 2 - (iconWidth ?? defaultIconWidth) - 10 - 40,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    resource.getTitle(),
                                    style: Theme.of(context).primaryTextTheme.bodyText1,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                                  Row(
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
                                      Text(
                                        resource.getTimeText(),
                                        style: textStyleFrom(
                                          Theme.of(context).primaryTextTheme.bodyText1,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 11,
                                        )
                                      ),
                                    ],
                                  ),
                                ]
                              )
                          ),
                      )
                    ]
                  ),
                )
            )
        ),
      );
  }
}

class LearningTopicSelectionItem extends StatelessWidget {

  final double defaultImageWidth = 80;
  final double defaultHpadding = 10;
  final double defaultHeight = 80;
  final double rightOuterPadding = 10;

  @required final LearningTopic topic;
  final double hpadding;
  final double imageWidth;
  final double height;

  LearningTopicSelectionItem({
    this.topic,
    this.hpadding,
    this.imageWidth,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context,
            CustomRoute(
              builder: (context) => LearningTopicPage(topic),
            )
          );
        },
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: hpadding ?? defaultHpadding),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: colorFrom(
                        Colors.black,
                        opacity: 0.16,
                      ),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                    )
                  ]
                ),
                child: 
                Padding(
                  padding: EdgeInsets.only(right: rightOuterPadding),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        width: imageWidth ?? defaultImageWidth,
                        height: height ?? defaultHeight,
                        color: Colors.orange,
                        child: Image.network(
                          topic.getImageLink(),
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        child: SelectionItem(
                          onClick: null,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: height ?? defaultHeight,
                                width: MediaQuery.of(context).size.width - (hpadding ?? defaultHpadding) * 2 - (imageWidth ?? defaultImageWidth) - 40 - rightOuterPadding,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    topic.getTitle(),
                                    style: Theme.of(context).primaryTextTheme.bodyText1,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ]
                          ),
                        ),
                      )
                    ]
                  ),
                )
            )
        ),
      );
  }
}
