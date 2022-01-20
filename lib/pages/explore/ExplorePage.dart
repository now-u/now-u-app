import 'package:app/assets/constants.dart';
import 'package:app/models/Action.dart';
import 'package:app/pages/explore/ExploreSection.dart';
import 'package:app/viewmodels/explore/explore_section_view_model.dart';
import 'package:app/viewmodels/explore_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

final double horizontalPadding = CustomPaddingSize.small;

class ExplorePage extends StatelessWidget {
  final List<ExploreSection> sections;
  final String title;

  ExplorePage({required this.sections, required this.title, Key? key})
      : super(key: key);

  Widget _header(BuildContext context, ExplorePageViewModel model) {
    return SafeArea(
        child: Padding(
      padding:
          EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20),
      child: GestureDetector(
        onTap: model.canBack ? () => model.back() : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (model.canBack) Icon(Icons.chevron_left, size: 30),
            Text(
              model.title,
              style: exploreHeading,
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    ));
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
                            section.build(context, pageModel: model))
                        .toList()),
          );
        });
  }
}

ExplorePage campaigns_explore_page = ExplorePage(title: "Campaigns", sections: [
  CampaignExploreSection(title: "Campaigns of the month", fetchParams: {
    "of_the_month": true,
  }),
  CampaignExploreSection(title: "Recommended campaigns", fetchParams: {
    "recommended": true,
  }),
  CampaignExploreByCauseSection(
    title: "Campaigns by cause",
  ),
  CampaignExploreSection(title: "Completed campaigns", fetchParams: {
    "completed": true,
  }),
]);

ExplorePage actions_explore_page = ExplorePage(
  title: "Actions",
  sections: [
    ActionExploreSection(title: "Actions of the month", fetchParams: {
      "of_the_month": true,
    }),
    ActionExploreByCauseSection(
      title: "Actions by cause",
    ),
    ActionExploreSection(
        title: "Actions by time",
        filter: ExploreFilter(
          parameterName: "time",
          options: timeBrackets
              .map((bracket) => ExploreFilterOption(
                    displayName: bracket['text'],
                    parameterValue: bracket['text'],
                  ))
              .toList(),
        )),
    ActionExploreSection(
        title: "Actions by type",
        filter: ExploreFilter(
          parameterName: "type",
          options: actionTypes
              .map((type) => ExploreFilterOption(
                    displayName: type.name,
                    parameterValue: type.name,
                  ))
              .toList(),
        )),
    ActionExploreSection(title: "Completed actions", fetchParams: {
      "completed": true,
    }),
  ],
);

ExplorePage learning_explore_page = ExplorePage(
  title: "Learn",
  sections: [
    LearningResourceExploreSection(title: "Learning resources"),
    LearningResourceExploreByCauseSection(
      title: "Learning resource by cause",
    ),
    LearningResourceExploreSection(
      title: "Learning resources by time2",
      filter: ExploreFilter(
        parameterName: "time",
        options: timeBrackets
            .map((bracket) => ExploreFilterOption(
                  displayName: bracket['text'],
                  parameterValue: bracket['text'],
                ))
            .toList(),
      ),
    ),
    LearningResourceExploreSection(
      title: "Completed learning",
      fetchParams: {
        "completed": true,
      },
    ),
  ],
);

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
      link: actions_explore_page,
      description:
          "Take a wide range of actions to drive lasting change for issues you care about",
    ),
    LearningResourceExploreSection(
      title: "Learn",
      link: learning_explore_page,
      description:
          "Learn more about key topics of pressing social and environmental issues",
    ),
    NewsExploreSection(
      title: "News",
      description:
          "Find out what’s going on in the world this week in relation to your chosen causes",
    ),
  ],
);
