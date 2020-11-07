import 'package:app/viewmodels/action_info_model.dart';
import 'package:app/viewmodels/action_info_model.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:app/models/Action.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/models/Learning.dart';
import 'package:app/routes.dart';

import 'package:app/viewmodels/base_model.dart';
import 'package:stacked/stacked.dart';

import 'package:app/pages/action/ActionInfo.dart';

import 'package:app/assets/routes/customLaunch.dart';
import 'package:app/assets/components/customTile.dart';
import 'package:app/assets/StyleFrom.dart';

final Color CHEVRON_COLOR = Color.fromRGBO(109, 113, 129, 1);

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
              child != null
                  ? Container(
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
              color: arrowColor == null ? CHEVRON_COLOR : arrowColor,
            ),
          ),
        ],
      ),
    );
  }
}

///This Widget when clicked opens the actions [ActionInfo] Page
///
/// This widget  (in orange encirclement) ![](https://i.ibb.co/HGb7jTc/IMG-20201103-065007.jpg)
/// is used extensively in each row in the [ActionPage] to show a list of actions the user can take
class OldActionSelectionItem extends StatelessWidget {
  final double defaultOuterHpadding = 10;
  final double defaultInnerHpadding = 10;
  final double defaultIconWidth = 50;

  final CampaignAction action;
  final Campaign campaign;
  final double innerHpadding;
  final double outerHpadding;
  final double iconWidth;
  final bool isNew;
  final Function extraOnTap;
  final Color backgroundColor;

  OldActionSelectionItem({
    @required this.action,
    @required this.campaign,
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
          bool completed = model.currentUser.getCompletedActions().contains(action.getId());
          return LeadingSelectionItem(
              backgroundColor: backgroundColor,
              innerHpadding: innerHpadding,
              outerHpadding: outerHpadding,
              iconWidth: iconWidth,
              isNew: action.isNew(),
              onTap: () {
                if (extraOnTap != null) {
                  extraOnTap();
                }
                Navigator.of(context).pushNamed(Routes.actionInfo, arguments: ActionInfoArguments(campaign: campaign, action: action));
              },
              leading: Stack(children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)), color: completed ? action.getActionIconMap()['iconColor'] : action.getActionIconMap()['iconBackgroundColor']),
                    child: Center(
                      child: Icon(
                        completed ? Icons.check : action.getActionIconMap()['icon'],
                        color: completed ? Colors.white : action.getActionIconMap()['iconColor'],
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
              text: action.getTitle(),
              time: action.getTimeText(),
              extraOverflow: 50);
        });
  }
}

///This widget is a newer more slim version of the old [ActionSelectionItem]
///
/// the final image should be something like this
/// ![](https://i.ibb.co/S6JdYDL/Favourites.png)
/// Note , this class should be renamed to ActionSelectionItem after its done ,
/// the reason I am making an entire new class for testing is because
/// the current ActionSelectionItem uses [LeadingSelectionItem] for the looks , but that widget
/// is pretty complex for me to understand , so I am trying to make a new one from scratch
class ActionSelectionItem extends StatefulWidget {
  // final double defaultOuterHpadding = 10;
  // final double defaultInnerHpadding = 10;
  // final double defaultIconWidth = 50;
  //instead of default I set the original variables to default values in the contructor

  final CampaignAction action;
  final Campaign campaign;
  final double innerHpadding;
  final double outerHpadding;
  final double iconWidth;
  final bool isNew;
  final Function extraOnTap;
  final Color backgroundColor;

  ActionSelectionItem({
    @required this.action,
    @required this.campaign,
    this.iconWidth = 50,
    this.innerHpadding = 10,
    this.outerHpadding = 5,
    this.isNew,
    this.extraOnTap,
    this.backgroundColor,
  });

  @override
  _ActionSelectionItemState createState() => _ActionSelectionItemState();
}

class _ActionSelectionItemState extends State<ActionSelectionItem> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ActionInfoViewModel>.reactive(
        viewModelBuilder: () => ActionInfoViewModel(),
        builder: (context, model, child) {
          bool completed = model.currentUser.getCompletedActions().contains(widget.action.getId());
          bool isStarred = model.currentUser.getStarredActions().contains(widget.action.getId());
          return GestureDetector(
            onTap: () {
              print("Outer is pressed");
              Navigator.push(
                  context, PageRouteBuilder(transitionDuration: Duration(seconds: 5), pageBuilder: (_, __, ___) => ActionInfo(ActionInfoArguments(campaign: widget.campaign, action: widget.action))));
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(widget.outerHpadding, 0, widget.outerHpadding, widget.outerHpadding),
              child: CustomTile(
                child: Column(children: [
                  //The first row is supposed to be of accent color and looks like this https://i.ibb.co/M9jppys/image.png
                  Container(
                    color: widget.action.getActionIconMap()["iconBackgroundColor"],
                    child: Container(
                      margin: EdgeInsets.all(5),
                      child: IntrinsicHeight(
                        //without Intrinsic Height the VerticalDividers were acting like a space and not showing the line
                        child: Row(
                          children: [
                            Icon(
                              widget.action.getActionIconMap()["icon"],
                              color: widget.action.getActionIconMap()["iconColor"],
                            ),
                            VerticalDivider(
                              color: Colors.transparent,
                            ),
                            Text(widget.action.getSuperTypeName(),
                                style: textStyleFrom(
                                  Theme.of(context).primaryTextTheme.headline5,
                                )),
                            VerticalDivider(),
                            Icon(
                              Icons.access_time,
                            ),
                            VerticalDivider(
                              color: Colors.transparent,
                              width: 5.0,
                            ),
                            Text(widget.action.getTimeText()),
                            Text(widget.action.isNew() ? "new" : ""),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(child: Text(widget.action.title, style: textStyleFrom(Theme.of(context).primaryTextTheme.headline4))),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            child: Icon(
                              Icons.star,
                              color: isStarred ? Color.fromRGBO(244, 185, 42, 1.0) : Colors.grey, //if its starred then show a bright orange color , if not ,then grey
                              size: 30, //when i give it a size of 1.3 , it disappears, and thats because 1.3 is a very small size
                            ),
                            onTap: () {
                              isStarred ? model.removeActionStatus(widget.action.getId()) : model.starAction(widget.action.getId()); //this basically changes the user setting through the api probably
                              setState(() {
                                print(
                                    "Inner is pressed "); // we dont really need anything in the setstate to update the isStarred variable because we are updating the model , and the isStarred is automatically recalculated from the model every time we build the widget
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          );
        });
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
  final Function extraOnClick;

  final bool completed;

  LearningResouceSelectionItem({
    @required this.resource,
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
        customLaunch(
          context,
          resource.getLink(),
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

///This is a more low level widget that the [ActionSelectionItem] uses
class LeadingSelectionItem extends StatelessWidget {
  final double defaultOuterHpadding = 5;
  final double defaultInnerHpadding = 5;
  final double defaultIconWidth = 50;

  final double innerHpadding;
  final double outerHpadding;
  final double iconWidth;
  final Widget leading;
  final Function onTap;
  final String text;
  final String time;
  final String secondaryText;
  final double extraOverflow;
  final Color backgroundColor;
  final bool isNew;
  final bool isCompleted;

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
      onTap: onTap,
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: outerHpadding ?? defaultOuterHpadding),
          child: CustomTile(
              child: Stack(children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: innerHpadding ?? defaultInnerHpadding),
              child: Row(children: <Widget>[
                leading,
                SizedBox(width: 10), //this is shown in a red rectangle (https://i.ibb.co/yB0CW69/image.png)
                Expanded(
                  child: SelectionItem(
                      onClick: onTap,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                        Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width -
                                  (outerHpadding ?? defaultOuterHpadding) * 2 -
                                  (innerHpadding ?? defaultInnerHpadding) * 2 -
                                  (iconWidth ?? defaultIconWidth) -
                                  10 -
                                  extraOverflow ??
                              40,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              text,
                              style: textStyleFrom(
                                Theme.of(context).primaryTextTheme.bodyText1,
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
                                  Text(time,
                                      style: textStyleFrom(
                                        Theme.of(context).primaryTextTheme.bodyText1,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 11,
                                      )),
                                ],
                              )
                            : secondaryText == null
                                ? Container()
                                : Text(secondaryText,
                                    style: textStyleFrom(
                                      Theme.of(context).primaryTextTheme.bodyText1,
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
                      decoration: BoxDecoration(color: isNew ? Theme.of(context).errorColor : Color.fromRGBO(89, 152, 26, 1), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8))),
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          child: isNew
                              ? Text("New",
                                  style: textStyleFrom(
                                    Theme.of(context).primaryTextTheme.bodyText1,
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
  final LearningTopic topic;
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
    return ImageSelectionItem(
      text: topic.getTitle(),
      imageUrl: topic.getImageLink(),
      onTap: () {
        Navigator.of(context).pushNamed(Routes.learningTopic, arguments: topic);
      },
      hpadding: hpadding,
      imageWidth: imageWidth,
      height: height,
      hasNew: topic.containsNew(),
    );
  }
}

class CheckboxSelectionItem extends StatelessWidget {
  final bool value;
  final Function onChanged;
  final String title;
  CheckboxSelectionItem({
    @required this.value,
    @required this.onChanged,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      dense: true,
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Theme.of(context).primaryColor,
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }
}

class LearningCentreCampaignSelectionItem extends StatelessWidget {
  @required
  final Campaign campaign;
  final double hpadding;
  final double imageWidth;
  final double height;
  final bool onWhiteBackground;

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
      text: campaign.getTitle(),
      imageUrl: campaign.getHeaderImage(),
      onTap: () {
        Navigator.of(context).pushNamed(Routes.learningSingle, arguments: campaign.getId());
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
  final double hpadding;
  final double imageWidth;
  final double height;
  final bool onWhiteBackground;

  final String text;
  final String imageUrl;
  final Function onTap;

  final bool hasNew;

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
      onTap: onTap,
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: hpadding ?? defaultHpadding),
          child: CustomTile(
              child: Padding(
                  padding: EdgeInsets.only(right: rightOuterPadding),
                  child: Stack(children: [
                    Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                      ClipRRect(
                        child: Container(
                          width: imageWidth ?? defaultImageWidth,
                          height: height ?? defaultHeight,
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        child: SelectionItem(
                          onClick: null,
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                            Container(
                              height: height ?? defaultHeight,
                              width: MediaQuery.of(context).size.width - (hpadding ?? defaultHpadding) * 2 - (imageWidth ?? defaultImageWidth) - 40 - rightOuterPadding,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  text,
                                  style: Theme.of(context).primaryTextTheme.bodyText1,
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
                                  borderRadius: BorderRadius.all(Radius.circular(6)),
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
