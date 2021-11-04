import 'package:app/assets/components/custom_network_image.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/models/Cause.dart';
import 'package:app/models/news.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExploreCampaignTile extends StatelessWidget {
  final String headerImage;
  final String title;
  final ListCause cause;
  final bool showCheckmark;
  final bool completed;

  ExploreCampaignTile(ListCampaign model, this.showCheckmark, {Key? key})
      : headerImage = model.headerImage,
        title = model.title,
        cause = model.cause,
        completed = model.completed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.antiAlias,
      child: AspectRatio(
        aspectRatio: 0.75,
        child: InkWell(
          onTap: () {
            // TODO do something
          },
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
                      showCheckmark: showCheckmark,
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
                  child: _ExploreTileCause(cause)),
            ],
          ),
        ),
      ),
    );
  }
}

class ExploreActionTile extends StatelessWidget {
  final String title;
  final ActionType type;
  final Color iconColor;
  final Color headerColor;
  final Color dividerColor;
  final IconData icon;
  final ListCause cause;
  final String timeText;
  final bool completed;
  final bool showCheckmark;

  ExploreActionTile(ListCauseAction model, this.showCheckmark, {Key? key})
      : title = model.title,
        type = model.superType,
        iconColor = model.primaryColor,
        headerColor = model.secondaryColor,
        dividerColor = model.tertiaryColor,
        icon = model.icon,
        cause = model.cause,
        timeText = model.timeText,
        completed = model.completed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.antiAlias,
      child: AspectRatio(
        aspectRatio: 1.65,
        child: InkWell(
          onTap: () {
            // TODO do something
          },
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
                        type.name,
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
                        showCheckmark: showCheckmark,
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
                      child: _ExploreTileCause(cause),
                    )
                  ],
                ),
                flex: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExploreNewsTile extends StatelessWidget {
  final String title;
  final String desc;
  final String headerImage;
  final String dateString;
  final String url;
  final String shortUrl;

  ExploreNewsTile(ListNews model, {Key? key})
      : title = model.title,
        desc = model.desc,
        headerImage = model.headerImage,
        dateString = model.dateString,
        url = model.url,
        shortUrl = model.shortUrl,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.antiAlias,
      child: AspectRatio(
        aspectRatio: 0.8,
        child: InkWell(
          onTap: () {
            // TODO do something
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
                      ),
                      Text(
                        desc,
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
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(247, 248, 252, 1)),
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

class _ExploreTileCause extends StatelessWidget {
  final ListCause cause;

  const _ExploreTileCause(this.cause, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Icon(
            cause.icon,
            size: 18,
          ),
          const SizedBox(width: 6),
          Text(
            cause.title,
            textScaleFactor: .9,
          )
        ],
      ),
    );
  }
}

class _ExploreTileCheckmark extends StatelessWidget {
  /// Whether to show the checkmark at all
  final bool showCheckmark;

  /// If the card has been completed
  final bool completed;

  /// Colors for the checkmark
  static const Color _completedColor = Color.fromRGBO(89, 152, 26, 1);
  static const Color _uncompletedColor = Color.fromRGBO(155, 159, 177, 1);

  const _ExploreTileCheckmark({
    required this.showCheckmark,
    this.completed = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (showCheckmark) {
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
            size: 20,
          ),
        ],
      );
    }

    return Container();
  }
}
