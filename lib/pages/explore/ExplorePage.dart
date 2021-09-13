import 'package:flutter/material.dart';

import 'package:app/models/Campaign.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/Explorable.dart';
import 'package:app/assets/components/selectionItem.dart';
import 'package:app/assets/components/selectionPill.dart';

import 'package:app/locator.dart';
import 'package:app/services/campaign_service.dart';

class ExploreFilterOption<T> {
  /// What is displayed to the user
  final String displayName;

  /// The value posted to the api when this is selected
  final T parameterValue;

  /// Whether the filter is selected
  bool isSelected;

  ExploreFilterOption({this.displayName, this.parameterValue, this.isSelected = false});

  void toggleSelect() {
    print("TOGGLING");
    isSelected = !isSelected;
  }

  Widget render() {
    return SelectionPill(displayName, isSelected, onClick: toggleSelect);
  }
} 

class ExploreFilter {
  /// The name of the parameter to be posted to the api
  final String parameterName;

  /// The options that can be selected for this filter
  final List<ExploreFilterOption> options;

  /// Whether multiple filter options can be selected at once
  final bool multi; 

  const ExploreFilter({this.parameterName, this.options, this.multi});
}

abstract class ExploreSection<ExplorableType> {

  /// Title of the section
  final String title;

  // TODO
  /// Where clicking on the title should go (maybe this should be a function?)
  // final String link;

  /// Description of the section
  final String description;

  // Params to provide to fetch query
  final Map fetchParams;

  /// 
  final ExploreFilter filter;
 
  const ExploreSection({this.title, this.description, this.fetchParams, this.filter});

  Future<List<ExplorableType>> fetchTiles();
  Widget renderTile(ExplorableType tile);

  Widget render(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: Theme.of(context).primaryTextTheme.headline2, textAlign: TextAlign.left),
        Text(description, style: Theme.of(context).primaryTextTheme.headline4, textAlign: TextAlign.left),
        Container(
          height: 60,
          child: filter != null ? ListView(
            scrollDirection: Axis.horizontal,
            children: filter.options.map((ExploreFilterOption option) => Padding(
                padding: EdgeInsets.all(10),
                child: option.render(),
              )
            ).toList()
          ) : SizedBox(height: 0),
        ),
        Container(
          height: 200,
          child: FutureBuilder<List<ExplorableType>>(
            future: fetchTiles(),
            builder: (BuildContext context, AsyncSnapshot<List<ExplorableType>> snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  child: CircularProgressIndicator()
                );
              }
              return ListView(
                scrollDirection: Axis.horizontal,
                children: snapshot.data.map((item) => Padding(
                    padding: EdgeInsets.all(10),
                    child: renderTile(item) 
                  )
                ).toList()
              );
            }
          ),
        ),
      ]
    );
  }
}

class CampaignExploreSection extends ExploreSection<Campaign> {
  const CampaignExploreSection({String title, String description, Map fetchParams, ExploreFilter filter}) : super(title:title, description:description, fetchParams:fetchParams, filter:filter);

  Future<List<Campaign>> fetchTiles() async {
    final CampaignService _campaignService = locator<CampaignService>();
    await _campaignService.fetchCampaigns();
    return _campaignService.campaigns;
  }

  Widget renderTile(Campaign tile) {
    return Container(color: Colors.red, height: 100, width: 200);
  }
}

class ActionExploreSection extends ExploreSection<CampaignAction> {
  const ActionExploreSection({String title, String description, Map fetchParams, ExploreFilter filter}) : super(title:title, description:description, fetchParams:fetchParams, filter:filter);

  Future<List<CampaignAction>> fetchTiles() async {
    final CampaignService _campaignService = locator<CampaignService>();
    await _campaignService.fetchCampaigns();
    return _campaignService.getActiveActions();
  }

  Widget renderTile(CampaignAction tile) {
    return Container(
      color: Colors.red, height: 100, width: 200
    );
  }
}

ExploreFilter filter = ExploreFilter(parameterName: "abc", options: [ExploreFilterOption(displayName: "1-5")]);
List<ExploreSection> exploreSections = [
  ActionExploreSection(title: "Actions", description: "Actions, do stuff", filter: filter),
  CampaignExploreSection(title: "Campaigns", description: "Join members of the now-u community in coordinated campaigns to make a difference"),
];

class ExplorePage extends StatelessWidget {

  final List<ExploreSection> sections;
  ExplorePage({
    @required this.sections
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: sections.map((section) => section.render(context)).toList()
      ),
    );
  }
}

var campaign_explore_page = ExplorePage(sections: exploreSections);
