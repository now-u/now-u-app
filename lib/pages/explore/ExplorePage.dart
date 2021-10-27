import 'package:app/pages/explore/ExploreFilter.dart';
import 'package:app/pages/explore/ExploreSection.dart';
import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {
  final List<ExploreSection> sections;

  ExplorePage({required this.sections});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
          scrollDirection: Axis.vertical,
          children: sections
              .map((ExploreSection section) => section.render(context))
              .toList()),
    );
  }
}

ExploreFilter filter = ExploreFilter(parameterName: "abc", options: [
  ExploreFilterOption(displayName: "1-5", parameterValue: "abc"),
  ExploreFilterOption(displayName: "5-10", parameterValue: "def")
]);

List<ExploreSection> exploreSections = [
  CampaignExploreSection(
      title: "Campaigns",
      description:
          "Join members of the now-u community in coordinated campaigns to make a difference"),
  ActionExploreSection(
      title: "Actions", description: "Actions, do stuff", filter: filter),
];

var campaign_explore_page = ExplorePage(sections: exploreSections);
