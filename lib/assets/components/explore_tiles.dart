import 'package:app/assets/components/cause_indicator.dart';
import 'package:app/assets/components/customTile.dart';
import 'package:app/assets/components/custom_network_image.dart';
import 'package:app/assets/constants.dart';
import 'package:app/locator.dart';
import 'package:app/models/Learning.dart';
import 'package:app/routes.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/models/Cause.dart';
import 'package:app/models/article.dart';
import 'package:app/services/navigation_service.dart';
import 'package:app/pages/action/ActionInfo.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../StyleFrom.dart';

enum ExploreTileStyle {
  Extended,
  Standard,
}

abstract class ExploreTile extends StatelessWidget {
  final ExploreTileStyle style;
  final bool? completed;

  ExploreTile({ExploreTileStyle? style, this.completed, Key? key})
      // If the style is extended then we need to know if the tile is completed
      : assert(style != ExploreTileStyle.Extended || completed != null),
        this.style = style ?? ExploreTileStyle.Standard;

  Widget render(BuildContext context);

  Widget _standardWrapper(Widget child) {
    // return Card(
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    //   clipBehavior: Clip.antiAlias,
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }

  Widget _extendedWrapper(BuildContext context, Widget child) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.antiAlias,
      child: AspectRatio(
        aspectRatio: 2,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            child,
            Positioned(
              right: 0,
              child: Container(
                width: 110,
                decoration: BoxDecoration(
                    color: CustomColors.white,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        completed! ? 'Completed' : 'Needs Completing',
                        style: textStyleFrom(
                          Theme.of(context).primaryTextTheme.button,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      _ExploreTileCheckmark(completed: completed!, size: 30),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget child = render(context);
    if (style == ExploreTileStyle.Extended)
      return _extendedWrapper(context, child);
    return _standardWrapper(child);
  }
}

class ExploreCampaignTile extends ExploreTile {
  final NavigationService _navigationService = locator<NavigationService>();

  final String headerImage;
  final String title;
  final ListCause cause;
  final bool completed;
  final ListCampaign campaign;

  ExploreCampaignTile(ListCampaign model, {Key? key})
      : headerImage = model.headerImage,
        title = model.title,
        cause = model.cause,
        completed = model.completed,
        campaign = model,
        super(key: key);

  Widget render(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.75,
      child: InkWell(
        onTap: () => _navigationService.navigateTo(
          Routes.campaign,
          arguments: campaign,
        ),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                AspectRatio(
                  aspectRatio: 1.5,
                  // FIXME ink animation doesn't cover image
                  child: CustomNetworkImage(
                    headerImage,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _ExploreTileCheckmark(
                    completed: completed,
                  ),
                )
              ],
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: _ExploreTileTitle(title),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: CauseIndicator(cause)),
          ],
        ),
      ),
    );
  }
}

class ExploreActionTile extends BaseExploreResourceTile {
  final ListCauseAction action;

  ExploreActionTile(ListCauseAction model, {ExploreTileStyle? style, Key? key})
      : action = model,
        super(
          title: model.title,
          type: model.superType.name,
          iconColor: model.primaryColor,
          headerColor: model.secondaryColor,
          dividerColor: model.tertiaryColor,
          icon: model.icon,
          cause: model.cause,
          timeText: model.timeText,
          completed: model.completed,
          style: style,
          key: key,
        );

  void onTap() {
    _navigationService.navigateTo(
      Routes.actionInfo,
      arguments: ActionInfoArguments(action: action),
    );
  }
}

class ExploreLearningTile extends BaseExploreResourceTile {
  final LearningResource resource;

  ExploreLearningTile(LearningResource model,
      {ExploreTileStyle? style, Key? key})
      : resource = model,
        super(
            title: model.title,
            type: model.type.name,
            iconColor: blue0,
            headerColor: blue1,
            dividerColor: blue2,
            icon: model.icon,
            cause: model.cause,
            timeText: model.timeText,
            completed: model.completed,
            key: key,
            style: style);

  void onTap() {
    _navigationService.launchLink(
      resource.link,
    );
  }
}

abstract class BaseExploreResourceTile extends ExploreTile {
  final NavigationService _navigationService = locator<NavigationService>();

  final String title;
  final String type;
  final Color iconColor;
  final Color headerColor;
  final Color dividerColor;
  final IconData icon;
  final ListCause cause;
  final String timeText;
  final bool completed;

  BaseExploreResourceTile(
      {required this.title,
      required this.type,
      required this.iconColor,
      required this.headerColor,
      required this.dividerColor,
      required this.icon,
      required this.cause,
      required this.timeText,
      required this.completed,
      ExploreTileStyle? style,
      Key? key})
      : super(style: style, completed: completed, key: key);

  void onTap();

  Widget render(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.65,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Flexible(
              child: Ink(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                color: headerColor,
                child: Row(
                  children: [
                    Icon(
                      icon,
                      size: 18,
                      color: iconColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      type,
                      textScaleFactor: .8,
                    ),
                    VerticalDivider(
                      color: dividerColor,
                      indent: 12,
                      endIndent: 12,
                    ),
                    const FaIcon(
                      // Use FaIcon to center icons properly
                      FontAwesomeIcons.clock,
                      size: 16,
                      color: Color.fromRGBO(55, 58, 74, 1),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      timeText,
                      textScaleFactor: .8,
                    ),
                    Expanded(child: Container()),
                    _ExploreTileCheckmark(
                      completed: completed,
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: _ExploreTileTitle(title),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: CauseIndicator(cause),
                  )
                ],
              ),
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}

class ExploreNewsTile extends ExploreTile {
  final NavigationService _navigationService = locator<NavigationService>();

  final String title;
  final String subtitle;
  final String headerImage;
  final String dateString;
  final String url;
  final String shortUrl;
  final Article article;

  ExploreNewsTile(Article model, {Key? key})
      : title = model.title,
        subtitle = model.subtitle,
        headerImage = model.headerImage,
        dateString = model.dateString ?? "",
        url = model.fullArticleLink,
        shortUrl = model.shortUrl,
        article = model,
        super(key: key);

  Widget render(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.8,
      child: InkWell(
        onTap: () {
          _navigationService.launchLink(article.fullArticleLink);
        },
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1.8,
              // FIXME ink animation doesn't cover image
              child: CustomNetworkImage(
                headerImage,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).primaryTextTheme.headline2!,
                      textScaleFactor: .7,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .primaryTextTheme
                          .bodyText2!
                          .apply(fontStyle: FontStyle.normal),
                    ),
                    Text(
                      dateString,
                    )
                  ],
                ),
              ),
            ),
            Ink(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(247, 248, 252, 1)),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  shortUrl,
                  style: Theme.of(context).primaryTextTheme.bodyText1?.apply(
                        color: const Color.fromRGBO(255, 136, 0, 1),
                      ),
                  textScaleFactor: .7,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExploreTileTitle extends StatelessWidget {
  final String title;

  const _ExploreTileTitle(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).primaryTextTheme.headline2!,
      textScaleFactor: .6,
    );
  }
}

class _ExploreTileCheckmark extends StatelessWidget {
  /// If the card has been completed
  final bool completed;
  final double size;

  /// Colors for the checkmark
  static const Color _completedColor = Color.fromRGBO(89, 152, 26, 1);
  static const Color _uncompletedColor = Color.fromRGBO(155, 159, 177, 1);

  const _ExploreTileCheckmark({
    required this.completed,
    this.size = 20,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            margin: const EdgeInsets.all(1),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ),
        FaIcon(
          FontAwesomeIcons.solidCheckCircle,
          color: completed ? _completedColor : _uncompletedColor,
          size: size,
        ),
      ],
    );
  }
}
