import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:app/models/Action.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/models/Learning.dart';
import 'package:app/routes.dart';

import 'package:app/viewmodels/base_model.dart';
import 'package:stacked/stacked.dart';

import 'package:app/pages/action/ActionInfo.dart';

import 'package:app/assets/components/customTile.dart';
import 'package:app/assets/StyleFrom.dart';
import 'package:app/assets/components/custom_network_image.dart';

import 'package:app/locator.dart';
import 'package:app/services/navigation_service.dart';

final Color CHEVRON_COLOR = Color.fromRGBO(109, 113, 129, 1);
final NavigationService? _navigationService = locator<NavigationService>();

class SelectionItem extends StatelessWidget {
  final String? text;
  final GestureTapCallback? onClick;
  final IconData? icon;
  final Color? arrowColor;
  final EdgeInsetsGeometry? padding;
  final Widget? child;

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
              child != null
                  ? Container(
                      child: child,
                    )
                  :
                  // Else will do text
                  Padding(
                      padding: this.padding ?? EdgeInsets.all(15),
                      child: Text(
                        text!,
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
              color: arrowColor == null ? CHEVRON_COLOR : arrowColor,
            ),
          ),
        ],
      ),
    );
  }
}

class ActionSelectionItem extends StatelessWidget {
  final double defaultOuterHpadding = 10;
  final double defaultInnerHpadding = 10;
  final double defaultIconWidth = 50;

  final ListCauseAction action;
  final Campaign? campaign;
  final double? innerHpadding;
  final double? outerHpadding;
  final double? iconWidth;
  final bool? isNew;
  final Function? extraOnTap;
  final Color? backgroundColor;

  ActionSelectionItem({
    required this.action,
    required this.campaign,
    this.iconWidth,
    this.innerHpadding,
    this.outerHpadding,
    this.isNew,
    this.extraOnTap,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BaseModel>.reactive(
        viewModelBuilder: () => BaseModel(),
        builder: (context, model, child) {
          bool completed =
              model.currentUser!.getCompletedActions()!.contains(action.id);
          return LeadingSelectionItem(
              backgroundColor: backgroundColor,
              innerHpadding: innerHpadding,
              outerHpadding: outerHpadding,
              iconWidth: iconWidth,
              isNew: action.isNew,
              onTap: () {
                if (extraOnTap != null) {
                  extraOnTap!();
                }
                Navigator.of(context).pushNamed(Routes.actionInfo,
                    arguments: ActionInfoArguments(action: action));
              },
              leading: Stack(children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: completed ? action.primaryColor : action.secondaryColor,
                    ),
                    child: Center(
                      child: Icon(
                        completed
                            ? Icons.check
                            : action.icon,
                        color: completed
                            ? Colors.white
                            : action.primaryColor,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                //!(action.isNew())
                //    ? Container()
                //    : Positioned(
                //        right: 0,
                //        child: Container(
                //          padding: EdgeInsets.all(1),
                //          decoration: BoxDecoration(
                //            color: Theme.of(context).primaryColor,
                //            borderRadius: BorderRadius.circular(6),
                //          ),
                //          constraints: BoxConstraints(
                //            minWidth: 12,
                //            minHeight: 12,
                //          ),
                //        ),
                //      ),
              ]),
              text: action.title,
              time: action.timeText,
              extraOverflow: 50);
        });
  }
}

class LearningResouceSelectionItem extends StatelessWidget {
  final double defaultOuterHpadding = 10;
  final double defaultInnerHpadding = 10;
  final double defaultIconWidth = 50;

  final LearningResource resource;
  final double? innerHpadding;
  final double? outerHpadding;
  final double? iconWidth;
  final Function? extraOnClick;

  final bool? completed;

  LearningResouceSelectionItem({
    required this.resource,
    this.iconWidth,
    this.innerHpadding,
    this.outerHpadding,
    this.extraOnClick,
    this.completed,
  });

  @override
  Widget build(BuildContext context) {
    return LeadingSelectionItem(
      onTap: () {
        _navigationService!.launchLink(
          resource.getLink()!,
          extraOnConfirmFunction: extraOnClick,
        );
      },
      isNew: resource.isNew(),
      leading: Stack(children: <Widget>[
        Padding(
          padding: EdgeInsets.all(5),
          child: Container(
            width: iconWidth ?? defaultIconWidth,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: colorFrom(Theme.of(context).primaryColor, opacity: 0.15),
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
      ]),
      text: resource.getTitle(),
      secondaryText: resource.getSource(),
      extraOverflow: 40,
      isCompleted: completed,
    );
  }
}

class LeadingSelectionItem extends StatelessWidget {
  final double defaultOuterHpadding = 5;
  final double defaultInnerHpadding = 5;
  final double defaultIconWidth = 50;

  final double? innerHpadding;
  final double? outerHpadding;
  final double? iconWidth;
  final Widget? leading;
  final Function? onTap;
  final String? text;
  final String? time;
  final String? secondaryText;
  final double? extraOverflow;
  final Color? backgroundColor;
  final bool? isNew;
  final bool? isCompleted;

  LeadingSelectionItem({
    this.iconWidth,
    this.innerHpadding,
    this.outerHpadding,
    this.leading,
    this.onTap,
    this.text,
    this.time,
    this.secondaryText,
    this.extraOverflow,
    this.backgroundColor,
    this.isNew,
    this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 5, horizontal: outerHpadding ?? defaultOuterHpadding),
          child: CustomTile(
              child: Stack(children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: innerHpadding ?? defaultInnerHpadding),
              child: Row(children: <Widget>[
                leading!,
                SizedBox(width: 10),
                Expanded(
                  child: SelectionItem(
                      onClick: onTap as void Function()?,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 45,
                              width: MediaQuery.of(context).size.width -
                                      (outerHpadding ?? defaultOuterHpadding) *
                                          2 -
                                      (innerHpadding ?? defaultInnerHpadding) *
                                          2 -
                                      (iconWidth ?? defaultIconWidth) -
                                      10 - (extraOverflow ?? 40),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  text!,
                                  style: textStyleFrom(
                                    Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1,
                                    fontSize: 16,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            time != null
                                ? Row(
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
                                      Text(time!,
                                          style: textStyleFrom(
                                            Theme.of(context)
                                                .primaryTextTheme
                                                .bodyText1,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 11,
                                          )),
                                    ],
                                  )
                                : secondaryText == null
                                    ? Container()
                                    : Text(secondaryText!,
                                        style: textStyleFrom(
                                          Theme.of(context)
                                              .primaryTextTheme
                                              .bodyText1,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 11,
                                        )),
                          ])),
                )
              ]),
            ),
            // Im checking here because the value could be null
            isNew == true || isCompleted == true
                ? Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          color: isNew!
                              ? Theme.of(context).errorColor
                              : Color.fromRGBO(89, 152, 26, 1),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8))),
                      child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          child: isNew!
                              ? Text("New",
                                  style: textStyleFrom(
                                    Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1,
                                    color: Colors.white,
                                    fontSize: 12,
                                  ))
                              // Otherwise is completed
                              : Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 12,
                                )),
                    ),
                  )
                : Container(),
          ]))),
    );
  }
}

class LearningTopicSelectionItem extends StatelessWidget {
  final double defaultImageWidth = 80;
  final double defaultHpadding = 10;
  final double defaultHeight = 80;
  final double rightOuterPadding = 10;
  final double borderRadius = 8;

  @required
  final LearningTopic? topic;
  final double? hpadding;
  final double? imageWidth;
  final double? height;

  LearningTopicSelectionItem({
    this.topic,
    this.hpadding,
    this.imageWidth,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ImageSelectionItem(
      text: topic!.getTitle(),
      imageUrl: topic!.getImageLink(),
      onTap: () {
        Navigator.of(context).pushNamed(Routes.learningTopic, arguments: topic);
      },
      hpadding: hpadding,
      imageWidth: imageWidth,
      height: height,
      hasNew: topic!.containsNew(),
    );
  }
}

class CheckboxSelectionItem extends StatelessWidget {
  final bool? value;
  final Function onChanged;
  final String? title;
  CheckboxSelectionItem({
    required this.value,
    required this.onChanged,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      dense: true,
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Theme.of(context).primaryColor,
      title: Text(title!),
      value: value,
      onChanged: onChanged as void Function(bool?)?,
    );
  }
}

class LearningCentreCampaignSelectionItem extends StatelessWidget {
  @required
  final Campaign? campaign;
  final double? hpadding;
  final double? imageWidth;
  final double? height;
  final bool? onWhiteBackground;

  LearningCentreCampaignSelectionItem({
    this.campaign,
    this.hpadding,
    this.imageWidth,
    this.height,
    this.onWhiteBackground,
  });

  @override
  Widget build(BuildContext context) {
    return ImageSelectionItem(
      text: campaign!.title,
      imageUrl: campaign!.headerImage,
      onTap: () {
        Navigator.of(context)
            .pushNamed(Routes.learningSingle, arguments: campaign!.id);
      },
      hpadding: hpadding,
      imageWidth: imageWidth,
      height: height,
      onWhiteBackground: onWhiteBackground,
    );
  }
}

class ImageSelectionItem extends StatelessWidget {
  final double defaultImageWidth = 80;
  final double defaultHpadding = 10;
  final double defaultHeight = 80;
  final double rightOuterPadding = 10;
  final double borderRadius = 8;

  @required
  final double? hpadding;
  final double? imageWidth;
  final double? height;
  final bool? onWhiteBackground;

  final String? text;
  final String? imageUrl;
  final Function? onTap;

  final bool? hasNew;

  ImageSelectionItem({
    this.text,
    this.imageUrl,
    this.onTap,
    this.hasNew,
    this.hpadding,
    this.imageWidth,
    this.height,
    this.onWhiteBackground,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 5, horizontal: hpadding ?? defaultHpadding),
          child: CustomTile(
              child: Padding(
                  padding: EdgeInsets.only(right: rightOuterPadding),
                  child: Stack(children: [
                    Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                      ClipRRect(
                        child: Container(
                          width: imageWidth ?? defaultImageWidth,
                          height: height ?? defaultHeight,
                          child: CustomNetworkImage(
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
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
                                  width: MediaQuery.of(context).size.width -
                                      (hpadding ?? defaultHpadding) * 2 -
                                      (imageWidth ?? defaultImageWidth) -
                                      40 -
                                      rightOuterPadding,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      text!,
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .bodyText1,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      )
                    ]),
                    Positioned(
                        top: 10,
                        right: 2,
                        child: hasNew ?? false
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                  color: Theme.of(context).errorColor,
                                ),
                                height: 12,
                                width: 12,
                              )
                            : Container())
                  ])))),
    );
  }
}
