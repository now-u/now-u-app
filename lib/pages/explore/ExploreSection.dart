import 'package:app/assets/components/explore_tiles.dart';
import 'package:app/assets/constants.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/models/Explorable.dart';
import 'package:app/models/article.dart';
import 'package:app/models/Learning.dart';
import 'package:app/pages/explore/ExplorePage.dart';
import 'package:app/viewmodels/explore/explore_section_view_model.dart';
import 'package:app/viewmodels/explore_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:app/assets/components/selectionPill.dart';

class ExploreFilterSelectionItem extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  ExploreFilterSelectionItem(
      {required ExploreFilterOption item, required this.onPressed})
      : this.text = item.displayName,
        this.isSelected = item.isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            color: isSelected ? CustomColors.black1 : CustomColors.greyLight2,
            borderRadius: BorderRadius.all(Radius.circular(24))),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                // Section header
                Column(
                  children: [
                    // Text header
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: horizontalPadding),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: link != null
                                ? () => pageModel.update(
                                    title: link!.title,
                                    sections: link!.sections)
                                : null,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .headline3,
                                  textAlign: TextAlign.left,
                                ),
                                if (link != null)
                                  Icon(Icons.chevron_right, size: 30)
                              ],
                            ),
                          ),
                          if (description != null)
                            Text(
                              description!,
                              style:
                                  Theme.of(context).primaryTextTheme.headline4,
                              textAlign: TextAlign.left,
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2),
                    if (model.filter != null)
                      Container(
                        height: 40,
                        child: ListView.builder(
                            padding: EdgeInsets.only(bottom: 8, top: 6),
                            scrollDirection: Axis.horizontal,
                            itemCount: model.filter!.options.length,
                            itemBuilder: (context, index) {
                              ExploreFilterOption option =
                                  model.filter!.options[index];
                              return Padding(
                                  padding: EdgeInsets.only(
                                    right: 5,
                                    left: index == 0 ? horizontalPadding : 0,
                                  ),
                                  child: ExploreFilterSelectionItem(
                                    item: option,
                                    onPressed: () =>
                                        model.toggleFilterOption(option),
                                  ));
                            }),
                      ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: CustomPaddingSize.normal,
                      top: CustomPaddingSize.small),
                  child: Container(
                    height: tileHeight + tileShadowBlurRadius,
                    child: model.busy
                        ? const Center(child: CircularProgressIndicator())
                        : model.error || model.tiles == null
                            // TODO handle error here
                            ? Container(color: Colors.red)
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: model.tiles!.length,
                                itemBuilder: (context, index) => Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      right: 8,
                                      left: index == 0 ? horizontalPadding : 0,
                                      bottom: tileShadowBlurRadius,
                                    ),
                                    child: renderTile(model.tiles![index]),
                                  ),
                                ),
                              ),
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

class LearningResourceExploreSection extends ExploreSection<LearningResource> {
  @override
  LearningResourceExploreSectionViewModel get viewModel {
    return LearningResourceExploreSectionViewModel(
      params: fetchParams,
      filter: filter,
    );
  }

  LearningResourceExploreSection({
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
  Widget renderTile(LearningResource tile) => ExploreLearningTile(tile);
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

class LearningResourceExploreByCauseSection
    extends LearningResourceExploreSection {
  @override
  LearningResourceExploreByCauseSectionViewModel get viewModel =>
      LearningResourceExploreByCauseSectionViewModel();

  LearningResourceExploreByCauseSection({
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
