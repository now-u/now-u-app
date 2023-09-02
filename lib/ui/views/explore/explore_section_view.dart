import 'package:nowu/assets/components/buttons/darkButton.dart';
import 'package:nowu/assets/components/card.dart';
import 'package:nowu/assets/components/explore_tiles.dart';
import 'package:nowu/assets/constants.dart';
import 'package:flutter/material.dart';
import 'package:nowu/services/search_service.dart';
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

abstract class ExploreSectionWidget<
    TTileData extends ExploreTileData,
    TFilter extends ResourceSearchFilter<TFilter>,
    TFilterParam,
    TArgs extends ExploreSectionArguments<TFilter, TFilterParam>,
    TViewModel extends ExploreSectionViewModel<TTileData, TFilter,
        TFilterParam>> extends StackedView<TViewModel> {
  final ExplorePageViewModel? pageViewModel;
  final TArgs args;

  ExploreSectionWidget(this.args, {this.pageViewModel});

  Widget _renderTile(TTileData tile, TViewModel viewModel);

  @override
  bool get createNewViewModelOnInsert => true;

  @override
  void onViewModelReady(TViewModel viewModel) {
    viewModel.init();
  }

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
                  args.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.left,
                ),
                if (args.link != null) const Icon(Icons.chevron_right, size: 30)
              ],
            ),
          ),
          if (args.description != null)
            Text(
              args.description!,
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

  Widget _noTilesFound(TViewModel model) {
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
                  'Looks like we don’t have any ‘${args.title}’ to recommend right now. Check out our ‘Explore’ page to get involved another way.',
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

  Widget _buildTiles(BuildContext context, TViewModel model) {
    final sectionHeight = args.tileHeight;

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
            child: _renderTile(model.tiles.elementAt(index), model),
          ),
        ),
      ),
    );
  }

  @override
  Widget builder(
    BuildContext context,
    TViewModel model,
    Widget? child,
  ) {
    // TODO When the input args changes, the viewmodel isn't updated
    return Container(
      color: args.backgroundColor,
      child: Padding(
        padding: EdgeInsets.only(top: args.backgroundColor != null ? 12 : 0),
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
                    model.filterData!.state == ExploreSectionFilterState.Loaded)
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
  }
}

class ActionExploreSection<TFilterParam> extends ExploreSectionWidget<
    ActionExploreTileData,
    ActionSearchFilter,
    TFilterParam,
    ActionExploreSectionArgs<TFilterParam>,
    ActionExploreSectionViewModel<TFilterParam>> {
  ActionExploreSection(ActionExploreSectionArgs<TFilterParam> args,
      {ExplorePageViewModel? pageViewModel,})
      : super(args, pageViewModel: pageViewModel);

  @override
  Widget _renderTile(ActionExploreTileData tile, ActionExploreSectionViewModel viewModel) {
    return ExploreActionTile(tile, onTap: () => viewModel.tileOnClick(tile));
  }

  @override
  ActionExploreSectionViewModel<TFilterParam> viewModelBuilder(
      BuildContext context,) {
    return ActionExploreSectionViewModel(this.args, pageViewModel);
  }
}

class LearningResourceExploreSection<TFilterParam> extends ExploreSectionWidget<
    LearningResourceExploreTileData,
    LearningResourceSearchFilter,
    TFilterParam,
    LearningResourceExploreSectionArgs<TFilterParam>,
    LearningResourceExploreSectionViewModel<TFilterParam>> {
  LearningResourceExploreSection(
      LearningResourceExploreSectionArgs<TFilterParam> args,
      {ExplorePageViewModel? pageViewModel,})
      : super(args, pageViewModel: pageViewModel);

  @override
  Widget _renderTile(LearningResourceExploreTileData tile, LearningResourceExploreSectionViewModel viewModel) {
    return ExploreLearningResourceTile(tile, onTap: () => viewModel.tileOnClick(tile));
  }

  @override
  LearningResourceExploreSectionViewModel<TFilterParam> viewModelBuilder(
      BuildContext context,) {
    return LearningResourceExploreSectionViewModel(this.args, pageViewModel);
  }
}

class CampaignExploreSection<TFilterParam> extends ExploreSectionWidget<
    CampaignExploreTileData,
    CampaignSearchFilter,
    TFilterParam,
    CampaignExploreSectionArgs<TFilterParam>,
    CampaignExploreSectionViewModel<TFilterParam>> {
  CampaignExploreSection(CampaignExploreSectionArgs<TFilterParam> args,
      {ExplorePageViewModel? pageViewModel,})
      : super(args, pageViewModel: pageViewModel);

  @override
  Widget _renderTile(CampaignExploreTileData tile, CampaignExploreSectionViewModel viewModel) {
    return ExploreCampaignTile(tile, onTap: () => viewModel.tileOnClick(tile));
  }

  @override
  CampaignExploreSectionViewModel<TFilterParam> viewModelBuilder(
      BuildContext context,) {
    return CampaignExploreSectionViewModel(this.args, pageViewModel);
  }
}

class NewsArticleExploreSection<TFilterParam> extends ExploreSectionWidget<
    NewsArticleExploreTileData,
    NewsArticleSearchFilter,
    TFilterParam,
    NewsArticleExploreSectionArgs<TFilterParam>,
    NewsArticleExploreSectionViewModel<TFilterParam>> {
  NewsArticleExploreSection(NewsArticleExploreSectionArgs<TFilterParam> args,
      {ExplorePageViewModel? pageViewModel,})
      : super(args, pageViewModel: pageViewModel);

  @override
  Widget _renderTile(NewsArticleExploreTileData tile, NewsArticleExploreSectionViewModel viewModel) {
    return ExploreNewsArticleTile(tile, onTap: () => viewModel.tileOnClick(tile));
  }

  @override
  NewsArticleExploreSectionViewModel<TFilterParam> viewModelBuilder(
      BuildContext context,) {
    return NewsArticleExploreSectionViewModel(this.args, pageViewModel);
  }
}
