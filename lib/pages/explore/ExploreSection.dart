import 'package:app/assets/components/explore_tiles.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/models/Explorable.dart';
import 'package:app/models/article.dart';
import 'package:app/pages/explore/ExplorePage.dart';
import 'package:app/viewmodels/explore/explore_section_view_model.dart';
import 'package:app/viewmodels/explore_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:app/assets/components/selectionPill.dart';

abstract class ExploreSection<ExplorableType extends Explorable> {
  ExploreSectionViewModel<ExplorableType> get viewModel;

  /// Title of the section
  final String title;

  // TODO
  /// Where clicking on the title should go (maybe this should be a function?)
  final ExplorePage? link;

  /// Description of the section
  final String? description;

  // Params to provide to fetch query
  final Map<String, dynamic>? fetchParams;

  ///
  final ExploreFilter? filter;

  final double tileHeight;

  const ExploreSection({
    required this.title,
    this.description,
    this.link,
    this.fetchParams,
    this.filter,
    this.tileHeight = 160,
  });

  Widget renderTile(ExplorableType tile);

  Widget render(BuildContext context, ExplorePageViewModel pageModel) {
    return ViewModelBuilder<ExploreSectionViewModel<ExplorableType>>.reactive(
        viewModelBuilder: () => viewModel,
        onModelReady: (model) => model.init(),
        builder: (context, model, child) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                        child: Text(title,
                          style: Theme.of(context).primaryTextTheme.headline2,
                          textAlign: TextAlign.left,
                        ),
                        onPressed: link != null ? () => pageModel.update(title: link!.title, sections: link!.sections) : null,
                    ),
                    if (link != null) Icon(Icons.chevron_right, size: 30)
                  ],
                ),
                if (description != null)
                  Text(
                      description!,
                      style: Theme.of(context).primaryTextTheme.headline4,
                      textAlign: TextAlign.left,
                  ),
                if (model.filter != null)
                  Container(
                    height: 60,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: model.filter!.options
                            .map((ExploreFilterOption option) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 3),
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

  CampaignExploreSection({
    required String title,
    String? description,
    Map<String, dynamic>? fetchParams,
    ExplorePage? link,
    ExploreFilter? filter,
  }) : super(
          title: title,
          description: description,
          fetchParams: fetchParams,
          filter: filter,
          link: link,
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

  ActionExploreSection({
    required String title,
    String? description,
    Map<String, dynamic>? fetchParams,
    ExplorePage? link,
    ExploreFilter? filter,
  }) : super(
          title: title,
          description: description,
          fetchParams: fetchParams,
          filter: filter,
          link: link,
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

  NewsExploreSection({
    required String title,
    String? description,
    Map<String, dynamic>? fetchParams,
    ExplorePage? link,
    ExploreFilter? filter,
  }) : super(
          title: title,
          description: description,
          fetchParams: fetchParams,
          filter: filter,
          link: link,
          tileHeight: 330,
        );

  @override
  Widget renderTile(Article tile) => ExploreNewsTile(tile);
}

class CampaignExploreByCauseSection extends CampaignExploreSection {
  @override
  CampaignExploreByCauseSectionViewModel get viewModel =>
      CampaignExploreByCauseSectionViewModel();

  CampaignExploreByCauseSection({
    required String title,
    String? description,
    Map<String, dynamic>? fetchParams,
    ExplorePage? link,
    ExploreFilter? filter,
  }) : super(
          title: title,
          description: description,
          fetchParams: fetchParams,
          filter: filter,
          link: link,
        );
}

class ActionExploreByCauseSection extends ActionExploreSection {
  @override
  ActionExploreByCauseSectionViewModel get viewModel =>
      ActionExploreByCauseSectionViewModel();

  ActionExploreByCauseSection({
    required String title,
    String? description,
    Map<String, dynamic>? fetchParams,
    ExplorePage? link,
    ExploreFilter? filter,
  }) : super(
          title: title,
          description: description,
          fetchParams: fetchParams,
          filter: filter,
          link: link,
        );
}
