import 'package:nowu/assets/components/buttons/darkButton.dart';
import 'package:nowu/assets/components/card.dart';
import 'package:nowu/assets/components/explore_tiles.dart';
import 'package:nowu/assets/constants.dart';
import 'package:flutter/material.dart';
import 'package:nowu/ui/views/explore/explore_page_view.dart';
import 'package:nowu/ui/views/explore/explore_page_viewmodel.dart';

class ExploreSectionWidget extends StatelessWidget {
  final bool isLoading;
  final String title;
  final GestureTapCallback? titleOnClick;
  final String? description;
  final Iterable<Widget>? tiles;
  final double tileHeight;

  ExploreSectionWidget({
    required this.isLoading,
    required this.title,
    required this.titleOnClick,
    required this.description,
    required this.tiles,
    required this.tileHeight,
  });

  Widget _buildSectionHeader(
    BuildContext context,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        children: [
          GestureDetector(
            onTap: titleOnClick,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.left,
                ),
                if (titleOnClick != null)
                  const Icon(Icons.chevron_right, size: 30)
              ],
            ),
          ),
          if (description != null)
            Text(
              description!,
              style: Theme.of(context).textTheme.displayMedium,
              textAlign: TextAlign.left,
            ),
        ],
      ),
    );
  }

  Widget _noTilesFound() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: BaseCard(
        Padding(
          padding: EdgeInsets.all(CustomPaddingSize.normal),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Oops.. No items found',
                      style: lightTheme.textTheme.headlineMedium,
                    ),
                  ],
                ),
                SizedBox(height: CustomPaddingSize.small),
                Text(
                  'Looks like we don’t have any ‘${title}’ to recommend right now. Check out our ‘Explore’ page to get involved another way.',
                  style: lightTheme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: CustomPaddingSize.small),
                DarkButton(
                  'Explore',
                  // TODO
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTiles(BuildContext context) {
    final sectionHeight = tileHeight;

    if (isLoading) {
      return Container(
        height: sectionHeight,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (tiles?.length == 0) {
      return _noTilesFound();
    }

    return Container(
      height: sectionHeight,
      clipBehavior: Clip.none,
      child: ListView(
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          const SizedBox(width: 8.0),
          ...(tiles ?? []),
          const SizedBox(width: 8.0)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO When the input args changes, the viewmodel isn't updated
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Section header
            Column(
              children: [
                // Text header
                _buildSectionHeader(context),
                const SizedBox(height: 2),
                SizedBox(height: CustomPaddingSize.small),
                _buildTiles(context),
                SizedBox(height: CustomPaddingSize.normal),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ActionExploreSection extends StatelessWidget {
  final Iterable<ActionExploreTileData>? tiles;
  final bool isLoading;
  final String title;
  final GestureTapCallback? titleOnClick;
  final String? description;
  final void Function(ActionExploreTileData tileData) tileOnClick;

  const ActionExploreSection({
    required this.title,
    required this.isLoading,
    required this.tiles,
    required this.tileOnClick,
    this.titleOnClick,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return ExploreSectionWidget(
      tiles: this.tiles?.map((tileData) =>
          ExploreActionTile(tileData, onTap: () => tileOnClick(tileData)),),
      tileHeight: 160,
      isLoading: isLoading,
      titleOnClick: titleOnClick,
      title: title,
      description: description,
    );
  }
}

class LearningResourceExploreSection extends StatelessWidget {
  final Iterable<LearningResourceExploreTileData>? tiles;
  final bool isLoading;
  final String title;
  final GestureTapCallback? titleOnClick;
  final String? description;
  final void Function(LearningResourceExploreTileData tileData) tileOnClick;

  const LearningResourceExploreSection({
    required this.title,
    required this.isLoading,
    required this.tiles,
    required this.tileOnClick,
    this.titleOnClick,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return ExploreSectionWidget(
      tiles: this.tiles?.map(
            (tileData) => ExploreLearningResourceTile(tileData,
                onTap: () => tileOnClick(tileData)),
          ),
      tileHeight: 160,
      isLoading: isLoading,
      titleOnClick: titleOnClick,
      title: title,
      description: description,
    );
  }
}

class CampaignExploreSection extends StatelessWidget {
  final Iterable<CampaignExploreTileData>? tiles;
  final bool isLoading;
  final String title;
  final GestureTapCallback? titleOnClick;
  final String? description;
  final void Function(CampaignExploreTileData tileData) tileOnClick;

  const CampaignExploreSection({
    required this.title,
    required this.isLoading,
    required this.tiles,
    required this.tileOnClick,
    this.description,
    this.titleOnClick,
  });

  @override
  Widget build(BuildContext context) {
    return ExploreSectionWidget(
      tiles: this.tiles?.map((tileData) =>
          ExploreCampaignTile(tileData, onTap: () => tileOnClick(tileData))),
      tileHeight: 300,
      isLoading: isLoading,
      titleOnClick: titleOnClick,
      title: title,
      description: description,
    );
  }
}

class NewsArticleExploreSection extends StatelessWidget {
  final Iterable<NewsArticleExploreTileData>? tiles;
  final bool isLoading;
  final String title;
  final GestureTapCallback? titleOnClick;
  final String? description;
  final void Function(NewsArticleExploreTileData tileData) tileOnClick;

  const NewsArticleExploreSection({
    required this.title,
    required this.isLoading,
    required this.tiles,
    required this.tileOnClick,
    this.titleOnClick,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return ExploreSectionWidget(
      tiles: this.tiles?.map((tileData) =>
          ExploreNewsArticleTile(tileData, onTap: () => tileOnClick(tileData))),
      tileHeight: 330,
      isLoading: isLoading,
      titleOnClick: titleOnClick,
      title: title,
      description: description,
    );
  }
}
