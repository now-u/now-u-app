import 'package:app/assets/components/explore_tiles.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/models/Cause.dart';
import 'package:app/models/Explorable.dart';
import 'package:app/pages/explore/ExploreFilter.dart';
import 'package:app/viewmodels/explore_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

abstract class ExploreSection<ExplorableType extends Explorable> {
  /// Title of the section
  final String title;

  // TODO
  /// Where clicking on the title should go (maybe this should be a function?)
  // final String link;

  /// Description of the section
  final String description;

  // Params to provide to fetch query
  final Map? fetchParams;

  ///
  final ExploreFilter? filter;

  final double tileHeight;

  final bool showCheckmark;

  const ExploreSection({
    required this.title,
    required this.description,
    this.fetchParams,
    this.filter,
    this.tileHeight = 160,
    this.showCheckmark = false,
  });

  Future<List<ExplorableType>> fetchTiles(Map<String, dynamic>? params);

  Widget renderTile(ExplorableType tile);

  Widget render(BuildContext context) {
    return ViewModelBuilder<ExplorePageViewModel<ExplorableType>>.reactive(
        viewModelBuilder: () => ExplorePageViewModel<ExplorableType>(
            filter: filter, fetchTiles: fetchTiles),
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
                filter != null
                    ? Container(
                        height: 60,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: filter!.options
                                .map((ExploreFilterOption option) => Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: option.render(model),
                                    ))
                                .toList()),
                      )
                    : const SizedBox(height: 0),
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
  const CampaignExploreSection({
    required String title,
    required String description,
    Map? fetchParams,
    ExploreFilter? filter,
    bool showCheckmark = false,
  }) : super(
          title: title,
          description: description,
          fetchParams: fetchParams,
          filter: filter,
          tileHeight: 300,
          showCheckmark: showCheckmark,
        );

  @override
  Future<List<ListCampaign>> fetchTiles(Map<String, dynamic>? params) async {
    // TODO remove mock
    return Future.delayed(
      const Duration(seconds: 2),
      () => List.generate(
        5,
        (i) => ListCampaign(
          id: i,
          title:
              "Advocate for global access to water, sanitation and hygiene (WASH)",
          shortName: "action$i",
          headerImage: "https://picsum.photos/id/$i/200",
          completed: false,
          causes: [
            ListCause(
              id: 0,
              title: "Equality & Human-Rights",
              icon: Icons.error,
              description: "This is a cause",
              selected: false,
            )
          ],
        ),
      ),
    );
    // final CausesService _causesService = locator<CausesService>();
    // return await _causesService.getCampaigns(params: params);
  }

  @override
  Widget renderTile(ListCampaign tile) =>
      ExploreCampaignTile(tile, showCheckmark);
}

class ActionExploreSection extends ExploreSection<ListCauseAction> {
  const ActionExploreSection({
    required String title,
    required String description,
    Map? fetchParams,
    ExploreFilter? filter,
    bool showCheckmark = false,
  }) : super(
          title: title,
          description: description,
          fetchParams: fetchParams,
          filter: filter,
          tileHeight: 160,
          showCheckmark: showCheckmark,
        );

  @override
  Future<List<ListCauseAction>> fetchTiles(Map<String, dynamic>? params) async {
    // TODO remove mock
    return Future.delayed(const Duration(seconds: 2), () {
      var types = [...CampaignActionType.values]..shuffle();

      return List.generate(
          5,
          (i) => ListCauseAction(
              id: i,
              title: "Tell Zara to stop profiting from Uighur forced labour",
              type: types[i],
              causes: [
                ListCause(
                  id: 0,
                  title: "Equality & Human-Rights",
                  icon: Icons.error,
                  description: "This is a cause",
                  selected: false,
                )
              ],
              createdAt: DateTime.now(),
              completed: false,
              starred: false,
              time: 42));
    });
    // final CausesService _causesService = locator<CausesService>();
    // return await _causesService.getActions(params: params);
  }

  @override
  Widget renderTile(ListCauseAction tile) =>
      ExploreActionTile(tile, showCheckmark);
}
