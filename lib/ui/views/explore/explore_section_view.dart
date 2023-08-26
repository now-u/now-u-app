import 'package:nowu/assets/components/buttons/darkButton.dart';
import 'package:nowu/assets/components/card.dart';
import 'package:nowu/assets/components/explore_tiles.dart';
import 'package:nowu/assets/constants.dart';
import 'package:flutter/material.dart';
import 'package:nowu/ui/views/explore/explore_page_definition.dart';
import 'package:nowu/ui/views/explore/explore_page_view.dart';
import 'package:nowu/ui/views/explore/explore_page_viewmodel.dart';
import 'package:nowu/ui/views/explore/explore_section_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ExploreFilterSelectionItem extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  ExploreFilterSelectionItem({
    required this.text,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? CustomColors.black1 : CustomColors.greyLight2,
          borderRadius: const BorderRadius.all(Radius.circular(24)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? CustomColors.white : CustomColors.black2,
            ),
          ),
        ),
      ),
    );
  }
}

class ExploreSectionWidget extends StatelessWidget {
  final ExplorePageViewModel? pageViewModel;
  final ExploreSectionArguments data;

  ExploreSectionWidget(this.data, { this.pageViewModel });

  // ExploreSectionWidget.fromModel(
  //     ExploreSection section, ExploreViewModelMixin model)
  //     : data = section,
  //       changePage = ((_) {}),
  //       toggleFilterOption = ((BaseExploreFilterOption option) =>
  //           model.toggleFilterOption(section, option));

  Widget _buildSectionHeader(
    BuildContext context,
    ExploreSectionViewModel model,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        children: [
          GestureDetector(
            onTap: model.handleLink,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.left,
                ),
                if (data.link != null) const Icon(Icons.chevron_right, size: 30)
              ],
            ),
          ),
          if (data.description != null)
            Text(
              data.description!,
              style: Theme.of(context).textTheme.displayMedium,
              textAlign: TextAlign.left,
            ),
        ],
      ),
    );
  }

  Widget _buildSectionFilters(ExploreSectionViewModel model) {
    return Container(
      height: 40,
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 8, top: 6),
        scrollDirection: Axis.horizontal,
        itemCount: model.filterData?.filterOptions.length,
        itemBuilder: (context, index) {
          final option = model.filterData!.filterOptions.elementAt(index);
          return Padding(
            padding: EdgeInsets.only(
              right: 5,
              left: index == 0 ? horizontalPadding : 0,
            ),
            child: ExploreFilterSelectionItem(
              text: option.displayName,
              isSelected: model.filterData!.optionIsSelected(option),
              onPressed: () => model.filterData!.toggleSelectOption(option),
            ),
          );
        },
      ),
    );
  }

  Widget _noTilesFound(ExploreSectionViewModel model) {
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
                  'Looks like we don’t have any ‘${data.title}’ to recommend right now. Check out our ‘Explore’ page to get involved another way.',
                  style: lightTheme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: CustomPaddingSize.small),
                DarkButton(
                  'Explore',
                  onPressed: model.navigateToEmptyExplore,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderTile(ExploreTileData tile) {
    switch (tile) {
      case NewsArticleExploreTileData():
        return ExploreNewsTile(tile);
      case ActionExploreTileData():
        return ExploreActionTile(tile);
      case CampaignExploreTileData():
        return ExploreCampaignTile(tile);
      case LearningResourceExploreTileData():
        return ExploreLearningTile(tile);
    }
  }

  ExploreSectionViewModel getViewModel(ExploreSectionArguments args, ExplorePageViewModel? pageViewModel) {
    switch (args) {
      case NewsArticleExploreSectionArgs():
        return NewsArticleExploreSectionViewModel(args, pageViewModel);
      case ActionExploreSectionArgs():
        return ActionExploreSectionViewModel(args, pageViewModel);
      case CampaignExploreSectionArgs():
        return CampaignExploreSectionViewModel(args, pageViewModel);
      case LearningResourceExploreSectionArgs():
        return LearningResourceExploreSectionViewModel(args, pageViewModel);
    }
  }

  Widget _buildTiles(BuildContext context, ExploreSectionViewModel model) {
    final sectionHeight = data.tileHeight;

    if (model.state == ExploreSectionState.Loading) {
      return Container(
        height: sectionHeight,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (model.state == ExploreSectionState.Errored) {
      return Container(color: Colors.red);
    }

    if (model.tiles.length == 0) {
      return _noTilesFound(model);
    }

    return Container(
      height: sectionHeight,
      clipBehavior: Clip.none,
      child: ListView.builder(
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
        itemCount: model.tiles.length,
        itemBuilder: (context, index) => Container(
          clipBehavior: Clip.none,
          child: Padding(
            padding: EdgeInsets.only(
              right: 8,
              left: index == 0 ? horizontalPadding : 0,
            ),
            child: _renderTile(model.tiles.elementAt(index)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => getViewModel(data, pageViewModel),
      onViewModelReady: (model) => model.init(),
      // TODO THis broke everything?
      // fireOnViewModelReadyOnce: true,
      builder: (conext, model, child) {
        return Container(
          color: data.backgroundColor,
          child: Padding(
            padding:
                EdgeInsets.only(top: data.backgroundColor != null ? 12 : 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Section header
                Column(
                  children: [
                    // Text header
                    _buildSectionHeader(context, model),
                    const SizedBox(height: 2),
                    if (model.filterData != null &&
                        model.filterData!.state ==
                            ExploreSectionFilterState.Loaded)
                      _buildSectionFilters(model),

                    SizedBox(height: CustomPaddingSize.small),
                    _buildTiles(context, model),
                    SizedBox(height: CustomPaddingSize.normal),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
