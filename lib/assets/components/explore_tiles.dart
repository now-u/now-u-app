import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nowu/assets/components/card.dart';
import 'package:nowu/assets/components/cause_indicator.dart';
import 'package:nowu/assets/components/custom_network_image.dart';
import 'package:nowu/models/article.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/ui/views/explore/explore_page_viewmodel.dart';

enum ExploreTileStyle {
  Standard,
}

abstract class ExploreTile extends StatelessWidget {
  ExploreTile({key});

  Widget buildBody(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      buildBody(context),
    );
  }
}

class ExploreCampaignTile extends ExploreTile {
  final String headerImage;
  final String title;
  final Cause cause;
  final bool? completed;
  final ListCampaign campaign;
  final GestureTapCallback onTap;

  ExploreCampaignTile(
    CampaignExploreTileData tile, {
    required this.onTap,
    Key? key,
  })  : headerImage = tile.campaign.headerImage.url,
        title = tile.campaign.title,
        cause = tile.campaign.cause,
        completed = tile.isCompleted,
        campaign = tile.campaign,
        super(key: key);

  @override
  Widget buildBody(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.75,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              constraints: const BoxConstraints(maxHeight: 150),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  // FIXME ink animation doesn't cover image
                  CustomNetworkImage(
                    headerImage,
                    fit: BoxFit.cover,
                  ),
                  if (completed != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _ExploreTileCheckmark(
                        completed: completed!,
                      ),
                    ),
                ],
              ),
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
              child: CauseIndicator(cause),
            ),
          ],
        ),
      ),
    );
  }
}

class ExploreActionTile extends ExploreResourceTile {
  final ListAction action;

  ExploreActionTile(
    ActionExploreTileData tile, {
    required GestureTapCallback onTap,
    ExploreTileStyle? style,
    Key? key,
  })  : action = tile.action,
        super(
          title: tile.action.title,
          type: tile.action.type.name,
          iconColor: tile.action.type.primaryColor,
          headerColor: tile.action.type.secondaryColor,
          dividerColor: tile.action.type.tertiaryColor,
          icon: tile.action.type.icon,
          cause: tile.action.cause,
          timeText: tile.action.timeText,
          isCompleted: tile.isCompleted,
          style: style,
          onTap: onTap,
          key: key,
        );
}

class ExploreLearningResourceTile extends ExploreResourceTile {
  final LearningResource resource;

  ExploreLearningResourceTile(
    LearningResourceExploreTileData tile, {
    required GestureTapCallback onTap,
    ExploreTileStyle? style,
    Key? key,
  })  : resource = tile.learningResource,
        super(
          title: tile.learningResource.title,
          type: tile.learningResource.type.name,
          iconColor: blue0,
          headerColor: blue1,
          dividerColor: blue2,
          icon: tile.learningResource.icon,
          cause: tile.learningResource.cause,
          timeText: tile.learningResource.timeText,
          isCompleted: tile.isCompleted,
          key: key,
          style: style,
          onTap: onTap,
        );
}

abstract class ExploreResourceTile extends ExploreTile {
  final double COMPLETED_EXTENSION_WIDTH = 110;

  final String title;
  final String type;
  final Color iconColor;
  final Color headerColor;
  final Color dividerColor;
  final IconData icon;
  final Cause cause;
  final String timeText;
  final bool? isCompleted;
  final ExploreTileStyle style;
  final GestureTapCallback onTap;

  ExploreResourceTile({
    required this.title,
    required this.type,
    required this.iconColor,
    required this.headerColor,
    required this.dividerColor,
    required this.icon,
    required this.cause,
    required this.timeText,
    required this.isCompleted,
    required this.onTap,
    ExploreTileStyle? style,
    Key? key,
  })  : this.style = style ?? ExploreTileStyle.Standard,
        super(key: key);

  @override
  Widget buildBody(BuildContext context) {
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
                    const SizedBox(width: 8),
                    Text(
                      type,
                      textScaler: const TextScaler.linear(.8),
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
                      textScaler: const TextScaler.linear(.8),
                    ),
                    Expanded(child: Container()),
                    if (isCompleted != null)
                      _ExploreTileCheckmark(
                        completed: isCompleted!,
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
                      child: style == ExploreTileStyle.Standard
                          ? _ExploreTileTitle(title)
                          : Padding(
                              padding: EdgeInsets.only(
                                right: COMPLETED_EXTENSION_WIDTH - 50,
                              ),
                              child: _ExploreTileTitle(title),
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: CauseIndicator(cause),
                  ),
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

class ExploreNewsArticleTile extends ExploreTile {
  final String title;
  final String subtitle;
  final String headerImage;
  final String dateString;
  final String url;
  final String shortUrl;
  final NewsArticle article;
  final GestureTapCallback onTap;

  ExploreNewsArticleTile(
    NewsArticleExploreTileData tile, {
    required this.onTap,
    Key? key,
  })  : title = tile.article.title,
        subtitle = tile.article.subtitle,
        headerImage = tile.article.headerImage.url,
        dateString = tile.article.dateString ?? '',
        url = tile.article.link,
        shortUrl = tile.article.shortUrl,
        article = tile.article,
        super(key: key);

  Widget buildBody(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.8,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1.8,
              // TODO ink animation doesn't cover image
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
                      style: Theme.of(context).textTheme.headlineMedium!,
                      textScaler: const TextScaler.linear(.7),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .apply(fontStyle: FontStyle.normal),
                    ),
                    Text(
                      dateString,
                    ),
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
                  style: Theme.of(context).textTheme.bodyLarge?.apply(
                        color: const Color.fromRGBO(255, 136, 0, 1),
                      ),
                  textScaler: const TextScaler.linear(.7),
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
      style: Theme.of(context).textTheme.headlineMedium!,
      textScaler: const TextScaler.linear(.6),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _ExploreTileCheckmark extends StatelessWidget {
  /// If the card has been completed
  final bool completed;

  /// Colors for the checkmark
  static const Color _completedColor = Color.fromRGBO(89, 152, 26, 1);
  static const Color _uncompletedColor = Color.fromRGBO(155, 159, 177, 1);

  const _ExploreTileCheckmark({
    required this.completed,
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
          FontAwesomeIcons.solidCircleCheck,
          color: completed ? _completedColor : _uncompletedColor,
        ),
      ],
    );
  }
}
