import 'package:collection/collection.dart';
import 'package:nowu/assets/components/buttons/darkButton.dart';
import 'package:nowu/assets/components/searchBar.dart';
import 'package:nowu/assets/constants.dart';
import 'package:nowu/models/Action.dart';
import 'package:nowu/pages/explore/ExploreSection.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/pages/explore/explore_page_view_model.dart';
import 'package:flutter/material.dart' hide SearchBar;
import 'package:stacked/stacked.dart';

final double horizontalPadding = CustomPaddingSize.small;

class ExplorePage extends StatelessWidget {
  final ExplorePageArguments args;

  ExplorePage(this.args, {Key? key}) : super(key: key);

  final _searchBarFocusNode = FocusNode();

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
              horizontal: horizontalPadding,
              vertical: 8,
            ),
            child: SearchBar(
              onTap: () {
                model.navigateToSearchPage();
                _searchBarFocusNode.unfocus();
              },
              focusNode: _searchBarFocusNode,
            ),
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
	CampaignExploreSectionArgs(
		title: "Campaigns of the month",
		baseParams: CampaignSearchFilter(ofTheMonth: true),
	),
	CampaignExploreSectionArgs(
		title: "Recommended campaigns",
		baseParams: CampaignSearchFilter(recommended: true),
	),
	CampaignExploreSectionArgs(
		title: "Campaigns by cause",
		filter: CampaignByCauseExploreFilter(),
	),
	CampaignExploreSectionArgs(
		title: "Completed campaigns",
		baseParams: CampaignSearchFilter(completed: true),
		backgroundColor: CustomColors.lightOrange,
	),
]);

ExplorePageArguments actions_explore_page = ExplorePageArguments(
  title: "Actions",
  sections: [
    ActionExploreSectionArgs(
        title: "Actions of the month",
		baseParams: ActionSearchFilter(ofTheMonth: true),
	),
    ActionExploreSectionArgs(
      title: "Actions by cause",
      filter: ActionByCauseExploreFilter(),
    ),
    ActionExploreSectionArgs(
      title: "Actions by time",
      filter: ActionTimeExploreFilter(),
    ),
    ActionExploreSectionArgs(
      title: "Actions by type",

      filter: ExploreFilter<List<ActionTypeEnum>, ActionSearchFilter>(
        multi: false,
        options: actionTypes
            .map((type) => ExploreFilterOption<List<ActionTypeEnum>>(
                  displayName: type.name,
                  parameterValue: type.subTypes
                ))
            .toList(),
		toFilter: (selectedTypes) {
			print("Converting thing to filter");
			print(selectedTypes.flattened);
			return ActionSearchFilter(types: selectedTypes.flattened);
		},
      ),
    ),
    ActionExploreSectionArgs(
      title: "Completed actions",
	  baseParams: ActionSearchFilter(completed: true),
      backgroundColor: CustomColors.lightOrange,
    ),
  ],
);

ExplorePageArguments learning_explore_page = ExplorePageArguments(
  title: "Learn",
  sections: [
    LearningResourceExploreSectionArgs(
      title: "Learning resources by time",
      filter: LearningResourceTimeExploreFilter(),
    ),
    LearningResourceExploreSectionArgs(
      title: "Learning resource by cause",
      filter: LearningResourceByCauseExploreFilter(),
    ),
    LearningResourceExploreSectionArgs(
      title: "Learning resources",
    ),
    LearningResourceExploreSectionArgs(
      title: "Completed learning",
      backgroundColor: CustomColors.lightOrange,
	  baseParams: LearningResourceSearchFilter(completed: true),
    ),
  ],
);

ExplorePageArguments home_explore_page = ExplorePageArguments(
  title: "Explore",
  sections: [
    ActionExploreSectionArgs(
      title: "Actions",
      link: actions_explore_page,
      description:
          "Take a wide range of actions to drive lasting change for issues you care about",
    ),
    LearningResourceExploreSectionArgs(
      title: "Learn",
      link: learning_explore_page,
      description:
          "Learn more about key topics of pressing social and environmental issues",
    ),
    CampaignExploreSectionArgs(
      title: "Campaigns",
      link: campaigns_explore_page,
      description:
          "Join members of the now-u community in coordinated campaigns to make a difference",
    ),
    NewsArticleExploreSectionArgs(
      title: "News",
      description:
          "Find out what’s going on in the world this week in relation to your chosen causes",
    ),
  ],
);
