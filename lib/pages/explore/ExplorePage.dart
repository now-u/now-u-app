import 'dart:collection';

import 'package:app/pages/explore/ExploreSection.dart';
import 'package:app/viewmodels/explore/explore_section_view_model.dart';
import 'package:app/viewmodels/explore_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ExplorePage extends StatelessWidget {
  final List<ExploreSection> sections;
  final String title;

  ExplorePage({required this.sections, required this.title, Key? key})
      : super(key: key);

  Widget _header(BuildContext context, ExplorePageViewModel model) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (model.canBack) Icon(Icons.chevron_left, size: 30),
          TextButton(
            child: Text(
              model.title,
              style: Theme.of(context).primaryTextTheme.headline2,
              textAlign: TextAlign.left,
            ),
            onPressed: model.canBack ? () => model.back() : null,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExplorePageViewModel>.reactive(
        viewModelBuilder: () => ExplorePageViewModel(sections, title),
        builder: (context, model, child) {
          return Scaffold(
            body: ListView(
                scrollDirection: Axis.vertical,
                children: [_header(context, model)] +
                    model.sections
                        .map((ExploreSection section) =>
                            section.render(context, model))
                        .toList()),
          );
        });
  }
}

ExplorePage campaigns_explore_page = ExplorePage(title: "Campaigns", sections: [
  CampaignExploreSection(
    title: "Campaigns",
    description:
        "Join members of the now-u community in coordinated campaigns to make a difference",
  ),
]);

ExplorePage home_explore_page = ExplorePage(
  title: "Explore",
  sections: [
    CampaignExploreSection(
      title: "Campaigns",
      link: campaigns_explore_page,
      description:
          "Join members of the now-u community in coordinated campaigns to make a difference",
    ),
    ActionExploreSection(
      title: "Actions",
      description:
          "Take a wide range of actions to drive lasting change for issues you care about",
      filter: ExploreFilter(parameterName: "abc", options: [
        ExploreFilterOption(displayName: "1-5", parameterValue: "abc"),
        ExploreFilterOption(displayName: "5-10", parameterValue: "def")
      ]),
    ),
    NewsExploreSection(
      title: "News",
      description:
          "Find out what’s going on in the world this week in relation to your chosen causes",
    ),
  ],
);
