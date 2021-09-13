import 'package:flutter/material.dart';

import 'package:app/models/Campaign.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/Explorable.dart';

final List<Map> dummyData = [
  {"abc": "def"},
  {"abc": "def"},
  {"abc": "def"},
  {"abc": "def"},
];

Future<List<Explorable>> getActions() async {
  await Future.delayed(const Duration(seconds: 2));
  return [
    CampaignAction(
        type: CampaignActionType.Volunteer,
        link: "http://google.com",
        time: 4,
        whyDescription: "because",
        whatDescription: "this",
        id: 1,
        title: "Action title"),
    CampaignAction(
        type: CampaignActionType.Volunteer,
        link: "http://google.com",
        time: 4,
        whyDescription: "because",
        whatDescription: "this",
        id: 1,
        title: "Action title")
  ];
}

Future<List<Explorable>> getCampaigns() async {
  await Future.delayed(const Duration(seconds: 5));
  return [
    Campaign(
        id: 1,
        title: "Action title",
        description: "abc",
        headerImage: "http://abc.com",
        actions: [],
        shortName: "abc",
        sdgs: []),
  ];
}

class ExploreSection {
  /// Endpoint to hit to get data for this section
  final String fetchFunction;

  /// URL params to send to endpoint
  final Map<String, dynamic> fetchArgs;

  /// Title of the section
  final String title;
  // final String link;
  /// Description of the section
  final String description;

  final Function getTiles;

  const ExploreSection(
      {this.fetchFunction,
      this.fetchArgs,
      this.title,
      this.description,
      this.getTiles});

  Future<List<Explorable>> fetchTiles() {
    return getActions();
  }

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
          Container(
            height: 200,
            child: FutureBuilder<List<Explorable>>(
                future: getTiles(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Explorable>> snapshot) {
                  if (!snapshot.hasData) {
                    return Container(child: CircularProgressIndicator());
                  }
                  return ListView(
                      scrollDirection: Axis.horizontal,
                      children: snapshot.data
                          .map((item) => Padding(
                              padding: EdgeInsets.all(10),
                              child: item.renderTile()))
                          .toList());
                }),
          ),
        ]);
  }
}

const List<ExploreSection> exploreSections = [
  ExploreSection(
      title: "Actions",
      description:
          "Take a wide range of actions to drive lasting change for issues you care about",
      getTiles: getActions),
  ExploreSection(
      title: "Campaigns",
      description:
          "Join members of the now-u community in coordinated campaigns to make a difference",
      getTiles: getCampaigns),
];

class ExplorePage extends StatelessWidget {
  final List<ExploreSection> sections;
  ExplorePage({this.sections = exploreSections});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
          scrollDirection: Axis.vertical,
          children:
              sections.map((section) => section.render(context)).toList()),
    );
  }
}
