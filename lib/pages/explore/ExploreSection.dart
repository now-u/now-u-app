import 'package:app/assets/components/ExploreTiles.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/pages/explore/ExploreFilter.dart';
import 'package:app/viewmodels/explore_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

abstract class ExploreSection<ExplorableType> {
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

  const ExploreSection(
      {required this.title,
      required this.description,
      this.fetchParams,
      this.filter});

  Future<List<ExplorableType>> fetchTiles();

  Widget renderTile(ExplorableType tile);

  Widget render(BuildContext context) {
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
              ? ViewModelBuilder<ExplorePageViewModel>.reactive(
                  viewModelBuilder: () => ExplorePageViewModel(),
                  builder: (context, model, child) {
                    return Container(
                      height: 60,
                      child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: filter!.options
                              .map((ExploreFilterOption option) => Padding(
                                    padding: EdgeInsets.all(10),
                                    child: option.render(model),
                                  ))
                              .toList()),
                    );
                  })
              : SizedBox(height: 0),
          Container(
            height: 200,
            child: FutureBuilder<List<ExplorableType>>(
                future: fetchTiles(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<ExplorableType>> snapshot) {
                  if (!snapshot.hasData) {
                    return Container(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) =>
                        renderTile(snapshot.data![index]),
                  );
                }),
          ),
        ]);
  }
}

class CampaignExploreSection extends ExploreSection<ListCampaign> {
  const CampaignExploreSection(
      {required String title,
      required String description,
      Map? fetchParams,
      ExploreFilter? filter})
      : super(
            title: title,
            description: description,
            fetchParams: fetchParams,
            filter: filter);

  Future<List<ListCampaign>> fetchTiles() async {
    // TODO remove mock
    return Future.delayed(
        Duration(seconds: 2),
        () => List.generate(
            5,
            (i) => ListCampaign(
                id: i,
                title: "This is action $i",
                shortName: "action$i",
                headerImage: "url?",
                completed: false,
                causes: [])));

    // final CausesService _causesService = locator<CausesService>();
    // return await _causesService.getCampaigns();
  }

  Widget renderTile(ListCampaign campaign) => ExploreCampaignTile(campaign);
}

class ActionExploreSection extends ExploreSection<ListCauseAction> {
  const ActionExploreSection(
      {required String title,
      required String description,
      Map? fetchParams,
      ExploreFilter? filter})
      : super(
            title: title,
            description: description,
            fetchParams: fetchParams,
            filter: filter);

  Future<List<ListCauseAction>> fetchTiles() async {
    // TODO remove mock
    return Future.delayed(Duration(seconds: 2), () {
      var types = []
        ..addAll(CampaignActionType.values)
        ..shuffle();

      return List.generate(
          5,
          (i) => ListCauseAction(
              id: i,
              title: "This is action $i",
              type: types[i],
              causes: [],
              createdAt: DateTime.now(),
              completed: false,
              starred: false,
              time: 42));
    });

    // final CausesService _causesService = locator<CausesService>();
    // return await _causesService.getActions();
  }

  Widget renderTile(ListCauseAction model) => ExploreActionTile(model);
}
