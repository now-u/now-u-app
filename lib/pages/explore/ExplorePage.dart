import 'package:nowu/assets/components/buttons/darkButton.dart';
import 'package:nowu/assets/components/searchBar.dart';
import 'package:nowu/assets/constants.dart';
import 'package:nowu/models/Action.dart';
import 'package:nowu/pages/explore/ExploreSection.dart';
import 'package:nowu/viewmodels/explore_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

final double horizontalPadding = CustomPaddingSize.small;

class ExplorePage extends StatelessWidget {
  final ExplorePageArguments args;

  ExplorePage(this.args, {Key? key}) : super(key: key);

  final _searchBarFocusNode = FocusNode();

  List<ExploreSection> buildSections() {
    return this.args.sections.map((sectionArgs) {
      switch (sectionArgs.type) {
        case ExploreSectionType.Action:
          return ActionExploreSection(sectionArgs);
        case ExploreSectionType.Learning:
          return LearningResourceExploreSection(sectionArgs);
        case ExploreSectionType.Campaign:
          return CampaignExploreSection(sectionArgs);
        case ExploreSectionType.News:
          return NewsExploreSection(sectionArgs);
      }
    }).toList() as List<ExploreSection>;
  }

  Widget _header(BuildContext context, ExplorePageViewModel model) {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          GestureDetector(
            onTap: model.canGoBack ? model.back : null,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (model.canGoBack) Icon(Icons.chevron_left, size: 30),
                  Text(
                    model.title,
                    style: exploreHeading,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding, vertical: 8),
            child: SearchBar(onTap: () {
              model.navigateToSearchPage();
            }),
          ),
          if (model.hasLinks())
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Container(
                  height: 50,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      padding:
                          EdgeInsets.symmetric(horizontal: horizontalPadding),
                      // Map section arguments into real sections
                      children: model.sections
                          .where((section) => section.args.link != null)
                          .map((section) => Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: DarkButton(
                                  section.args.title,
                                  onPressed: () =>
                                      model.changePage(section.args.link!),
                                  size: DarkButtonSize.Large,
                                ),
                              ))
                          .toList())),
            )
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExplorePageViewModel>.reactive(
        viewModelBuilder: () => ExplorePageViewModel(args.title, args.sections,
            baseParams: args.baseParams),
        onModelReady: (model) => model.init(),
        builder: (context, model, child) {
          return Scaffold(
              body: SingleChildScrollView(
            child: Column(
                children: [
                      _header(context, model),
                    ] +
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

ExplorePageArguments campaigns_explore_page =
    ExplorePageArguments(title: "Campaigns", sections: [
  ExploreSectionArguments(
      title: "Campaigns of the month",
      baseParams: {
        "of_the_month": true,
      },
      type: ExploreSectionType.Campaign),
  ExploreSectionArguments(
      title: "Recommended campaigns",
      baseParams: {
        "recommended": true,
      },
      type: ExploreSectionType.Campaign),
  ExploreSectionArguments(
    title: "Campaigns by cause",
    filter: ByCauseExploreFilter(),
    type: ExploreSectionType.Campaign,
  ),
  ExploreSectionArguments(
    title: "Completed campaigns",
    baseParams: {
      "completed": true,
    },
    backgroundColor: CustomColors.lightOrange,
    type: ExploreSectionType.Campaign,
  ),
]);

ExplorePageArguments actions_explore_page = ExplorePageArguments(
  title: "Actions",
  sections: [
    ExploreSectionArguments(
        title: "Actions of the month",
        baseParams: {
          "of_the_month": true,
        },
        type: ExploreSectionType.Action),
    ExploreSectionArguments(
      title: "Actions by cause",
      filter: ByCauseExploreFilter(),
      type: ExploreSectionType.Action,
    ),
    ExploreSectionArguments(
      title: "Actions by time",
      filter: TimeExploreFilter(),
      type: ExploreSectionType.Action,
    ),
    ExploreSectionArguments(
      title: "Actions by type",
      filter: ExploreFilter(
        parameterName: "type__in",
        multi: false,
        options: actionTypes
            .map((type) => ExploreFilterOption(
                  displayName: type.name,
                  parameterValue: campaignActionTypeData.values
                      .where((value) => value['type'] == type)
                      .map((value) => value['name'])
                      .toList(),
                ))
            .toList(),
      ),
      type: ExploreSectionType.Action,
    ),
    ExploreSectionArguments(
      title: "Completed actions",
      baseParams: {
        "completed": true,
      },
      backgroundColor: CustomColors.lightOrange,
      type: ExploreSectionType.Action,
    ),
  ],
);

ExplorePageArguments learning_explore_page = ExplorePageArguments(
  title: "Learn",
  sections: [
    ExploreSectionArguments(
      title: "Learning resources by time",
      filter: TimeExploreFilter(),
      type: ExploreSectionType.Learning,
    ),
    ExploreSectionArguments(
      title: "Learning resource by cause",
      filter: ByCauseExploreFilter(),
      type: ExploreSectionType.Learning,
    ),
    ExploreSectionArguments(
      title: "Learning resources",
      type: ExploreSectionType.Learning,
    ),
    ExploreSectionArguments(
      title: "Completed learning",
      baseParams: {
        "completed": true,
      },
      backgroundColor: CustomColors.lightOrange,
      type: ExploreSectionType.Learning,
    ),
  ],
);

ExplorePageArguments home_explore_page = ExplorePageArguments(
  title: "Explore",
  sections: [
    ExploreSectionArguments(
      title: "Actions",
      link: actions_explore_page,
      description:
          "Take a wide range of actions to drive lasting change for issues you care about",
      type: ExploreSectionType.Action,
    ),
    ExploreSectionArguments(
      title: "Learn",
      link: learning_explore_page,
      description:
          "Learn more about key topics of pressing social and environmental issues",
      type: ExploreSectionType.Learning,
    ),
    ExploreSectionArguments(
      title: "Campaigns",
      link: campaigns_explore_page,
      description:
          "Join members of the now-u community in coordinated campaigns to make a difference",
      type: ExploreSectionType.Campaign,
    ),
    ExploreSectionArguments(
      title: "News",
      description:
          "Find out what’s going on in the world this week in relation to your chosen causes",
      type: ExploreSectionType.News,
    ),
  ],
);
