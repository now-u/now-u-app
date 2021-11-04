import 'package:app/pages/explore/ExploreFilter.dart';
import 'package:app/pages/explore/ExploreSection.dart';
import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {
  final List<ExploreSection> sections;

  const ExplorePage({required this.sections, Key? key}) : super(key: key);

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
  const CampaignExploreSection(
    title: "Campaigns",
    description:
        "Join members of the now-u community in coordinated campaigns to make a difference",
    showCheckmark: false,
  ),
  ActionExploreSection(
    title: "Actions",
    description:
        "Take a wide range of actions to drive lasting change for issues you care about",
    filter: filter,
    showCheckmark: false,
  ),
  const NewsExploreSection(
      title: "News",
      description:
          "Find out what’s going on in the world this week in relation to your chosen causes"),
];

var campaign_explore_page = ExplorePage(sections: exploreSections);
