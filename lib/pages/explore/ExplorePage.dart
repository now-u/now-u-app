import 'package:app/assets/components/buttons/darkButton.dart';
import 'package:app/assets/constants.dart';
import 'package:app/models/Action.dart';
import 'package:app/pages/explore/ExploreSection.dart';
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
      child: Column(
        children: [
          GestureDetector(
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
          Container(
              height: 50,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: model.sections
                      .where((section) => section.link != null)
                      .map((section) => Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: DarkButton(
                              section.title,
                              onPressed: () => model.changePage(section.link!),
                              size: DarkButtonSize.Large,
                            ),
                          ))
                      .toList()))
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExplorePageViewModel>.reactive(
        viewModelBuilder: () => ExplorePageViewModel(title, sections),
        onModelReady: (model) => model.init(),
        builder: (context, model, child) {
          return Scaffold(
              body: SingleChildScrollView(
            child: Column(
                children: [_header(context, model)] +
                    model.sections
                        .map((ExploreSection section) => ExploreSectionWidget(
                              data: section,
                              changePage: model.changePage,
                              toggleFilterOption:
                                  (BaseExploreFilterOption option) =>
                                      model.toggleFilterOption(section, option),
                            ))
                        .toList()),
          ));
        });
  }
}

ExplorePage campaigns_explore_page = ExplorePage(title: "Campaigns", sections: [
  CampaignExploreSection(title: "Campaigns of the month", baseParams: {
    "of_the_month": true,
  }),
  CampaignExploreSection(title: "Recommended campaigns", baseParams: {
    "recommended": true,
  }),
  CampaignExploreSection(
    title: "Campaigns by cause",
    filter: ByCauseExploreFilter(),
  ),
  CampaignExploreSection(
    title: "Completed campaigns",
    baseParams: {
      "completed": true,
    },
    backgroundColor: CustomColors.lightOrange,
  ),
]);

ExplorePage actions_explore_page = ExplorePage(
  title: "Actions",
  sections: [
    ActionExploreSection(title: "Actions of the month", baseParams: {
      "of_the_month": true,
    }),
    ActionExploreSection(
      title: "Actions by cause",
      filter: ByCauseExploreFilter(),
    ),
    ActionExploreSection(
      title: "Actions by time",
      filter: TimeExploreFilter(),
    ),
    ActionExploreSection(
        title: "Actions by type",
        filter: ExploreFilter(
          parameterName: "type",
          multi: false,
          options: actionTypes
              .map((type) => ExploreFilterOption(
                    displayName: type.name,
                    parameterValue: type.name,
                  ))
              .toList(),
        )),
    ActionExploreSection(
      title: "Completed actions",
      baseParams: {
        "completed": true,
      },
      backgroundColor: CustomColors.lightOrange,
    ),
  ],
);

ExplorePage learning_explore_page = ExplorePage(
  title: "Learn",
  sections: [
    LearningResourceExploreSection(
      title: "Learning resources by time",
      filter: TimeExploreFilter(),
    ),
    LearningResourceExploreSection(
      title: "Learning resource by cause",
      filter: ByCauseExploreFilter(),
    ),
    LearningResourceExploreSection(title: "Learning resources"),
    LearningResourceExploreSection(
      title: "Completed learning",
      baseParams: {
        "completed": true,
      },
      backgroundColor: CustomColors.lightOrange,
    ),
  ],
);

ExplorePage home_explore_page = ExplorePage(
  title: "Explore",
  sections: [
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
    CampaignExploreSection(
      title: "Campaigns",
      link: campaigns_explore_page,
      description:
          "Join members of the now-u community in coordinated campaigns to make a difference",
    ),
    NewsExploreSection(
      title: "News",
      description:
          "Find out what’s going on in the world this week in relation to your chosen causes",
    ),
  ],
);
