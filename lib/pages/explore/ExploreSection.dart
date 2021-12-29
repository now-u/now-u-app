import 'package:app/assets/components/explore_tiles.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/models/Explorable.dart';
import 'package:app/models/article.dart';
import 'package:app/viewmodels/explore/explore_section_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:app/assets/components/selectionPill.dart';

abstract class ExploreSection<ExplorableType extends Explorable> {
  ExploreSectionViewModel<ExplorableType> get viewModel;

  /// Title of the section
  final String title;

  // TODO
  /// Where clicking on the title should go (maybe this should be a function?)
  // final String link;

  /// Description of the section
  final String description;

  // Params to provide to fetch query
  final Map<String, dynamic>? fetchParams;

  ///
  final ExploreFilter? filter;

  final double tileHeight;

  const ExploreSection({
    required this.title,
    required this.description,
    this.fetchParams,
    this.filter,
    this.tileHeight = 160,
  });

  Widget renderTile(ExplorableType tile);

  Widget render(BuildContext context) {
    return ViewModelBuilder<ExploreSectionViewModel<ExplorableType>>.reactive(
        viewModelBuilder: () => viewModel,
        onModelReady: (model) => model.fetchTiles(),
        builder: (context, model, child) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title,
                    style: Theme.of(context).primaryTextTheme.headline2,
                    textAlign: TextAlign.left),
                Text(description,
                    style: Theme.of(context).primaryTextTheme.headline4,
                    textAlign: TextAlign.left),
                if (filter != null)
                  Container(
                    height: 60,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: filter!.options
                            .map((ExploreFilterOption option) => Padding(
                                padding: const EdgeInsets.all(10),
                                child: SelectionPill(
                                  option.displayName,
                                  option.isSelected,
                                  onClick: () =>
                                      model.toggleFilterOption(option),
                                )))
                            .toList()),
                  ),
                Container(
                  height: tileHeight,
                  child: model.busy
                      ? const Center(child: CircularProgressIndicator())
                      : model.error || model.tiles == null
                          // TODO handle error here
                          ? Container(color: Colors.red)
                          : ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              scrollDirection: Axis.horizontal,
                              itemCount: model.tiles!.length,
                              itemBuilder: (context, index) =>
                                  renderTile(model.tiles![index]),
                            ),
                ),
              ]);
        });
  }
}

class CampaignExploreSection extends ExploreSection<ListCampaign> {
  @override
  CampaignExploreSectionViewModel get viewModel =>
      CampaignExploreSectionViewModel(
        params: fetchParams,
        filter: filter,
      );

  const CampaignExploreSection({
    required String title,
    required String description,
    Map<String, dynamic>? fetchParams,
    ExploreFilter? filter,
  }) : super(
          title: title,
          description: description,
          fetchParams: fetchParams,
          filter: filter,
          tileHeight: 300,
        );

  @override
  Widget renderTile(ListCampaign tile) => ExploreCampaignTile(tile);
}

class ActionExploreSection extends ExploreSection<ListCauseAction> {
  @override
  ActionExploreSectionViewModel get viewModel => ActionExploreSectionViewModel(
        params: fetchParams,
        filter: filter,
      );

  const ActionExploreSection({
    required String title,
    required String description,
    Map<String, dynamic>? fetchParams,
    ExploreFilter? filter,
  }) : super(
          title: title,
          description: description,
          fetchParams: fetchParams,
          filter: filter,
          tileHeight: 160,
        );

  @override
  Widget renderTile(ListCauseAction tile) => ExploreActionTile(tile);
}

class NewsExploreSection extends ExploreSection<Article> {
  @override
  NewsExploreSectionViewModel get viewModel => NewsExploreSectionViewModel(
        params: fetchParams,
        filter: filter,
      );

  const NewsExploreSection({
    required String title,
    required String description,
    Map<String, dynamic>? fetchParams,
    ExploreFilter? filter,
  }) : super(
          title: title,
          description: description,
          fetchParams: fetchParams,
          filter: filter,
          tileHeight: 330,
        );

  @override
  Widget renderTile(Article tile) => ExploreNewsTile(tile);
}
