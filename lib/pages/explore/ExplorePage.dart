import 'package:flutter/material.dart';
import 'package:app/models/Campaign.dart';

final List<Map> dummyData = [
  {"abc": "def"},
  {"abc": "def"},
  {"abc": "def"},
  {"abc": "def"},
];

class ExploreSection {
  /// Endpoint to hit to get data for this section
  final String endpoint;

  /// URL params to send to endpoint
  final Map<String, dynamic> params;

  /// The type of the items in the section (Campaign, Action, Learning Topic/Resource or News)
  final Type type;
 
  const ExploreSection({this.endpoint, this.params, this.type});

  Widget render() {
    return Container(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: dummyData.map((item) => Padding(
            padding: EdgeInsets.all(10),
            child: Container(color: Colors.red, height: 200, width: 500)
          )
        ).toList()
      ),
    );
  }
}

const List<ExploreSection> exploreSections = [
  ExploreSection(endpoint: "campaigns", params: {}, type: Campaign),
  ExploreSection(endpoint: "campaigns2", params: {}, type: Campaign),
  ExploreSection(endpoint: "campaigns2", params: {}, type: Campaign),
  ExploreSection(endpoint: "campaigns2", params: {}, type: Campaign),
  ExploreSection(endpoint: "campaigns2", params: {}, type: Campaign),
  ExploreSection(endpoint: "campaigns2", params: {}, type: Campaign),
  ExploreSection(endpoint: "campaigns2", params: {}, type: Campaign),
];

class ExplorePage extends StatelessWidget {

  final List<ExploreSection> sections;
  ExplorePage(
    {this.sections=exploreSections}
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: sections.map((section) => section.render()).toList()
      ),
    );
  }
}
