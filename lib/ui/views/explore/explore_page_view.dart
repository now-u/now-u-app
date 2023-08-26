import 'package:nowu/assets/components/buttons/darkButton.dart';
import 'package:nowu/assets/components/searchBar.dart';
import 'package:nowu/assets/constants.dart';
import 'package:flutter/material.dart' hide SearchBar;
import 'package:nowu/services/search_service.dart';
import 'package:nowu/ui/views/explore/explore_page_definition.dart';
import 'package:nowu/ui/views/explore/explore_section_view.dart';
import 'package:stacked/stacked.dart';

import 'explore_page_viewmodel.dart';

final double horizontalPadding = CustomPaddingSize.small;

class ExplorePage extends StatelessWidget {
  final BaseResourceSearchFilter? filter;

  ExplorePage({Key? key, this.filter}) : super(key: key);

  final _searchBarFocusNode = FocusNode();

  Widget _header(BuildContext context, ExplorePageViewModel model) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            GestureDetector(
              onTap: model.canGoBack ? model.back : null,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (model.canGoBack)
                      const Icon(Icons.chevron_left, size: 30),
                    Text(
                      'Explore',
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
                padding:const EdgeInsets.only(top: 10),
                child: Container(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding),
					// TODO Replace this with filter pills for causes and action type (all base filter options)
                    // Map section arguments into real sections
                    children: model.sections
                        .where((section) => section.link != null)
                        .map(
                          (section) => Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: DarkButton(
                              section.title,
                              onPressed: () => model.updateFilter(section.link!),
                              size: DarkButtonSize.Large,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget _buildSection(ExploreSectionArguments sectionArgs, ExplorePageViewModel pageViewModel) {
	switch (sectionArgs) {
	  case ActionExploreSectionArgs():
		return ActionExploreSection(sectionArgs, pageViewModel: pageViewModel);
	  case LearningResourceExploreSectionArgs():
		return LearningResourceExploreSection(sectionArgs, pageViewModel: pageViewModel);
	  case CampaignExploreSectionArgs():
		return CampaignExploreSection(sectionArgs, pageViewModel: pageViewModel);
	  case NewsArticleExploreSectionArgs():
		return NewsArticleExploreSection(sectionArgs, pageViewModel: pageViewModel);
	}
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExplorePageViewModel>.reactive(
      viewModelBuilder: () => ExplorePageViewModel(baseFilter: filter),
      builder: (context, model, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                    _header(context, model),
                  ] +
                  model.sections
                      .map((sectionArgs) => _buildSection(sectionArgs, model))
                      .toList(),
            ),
          ),
        );
      },
    );
  }
}

class FilterPill extends StatelessWidget {
	final VoidCallback onClick;
	final String text;
	final bool isSelected;

	FilterPill({
		required this.text,
		required this.onClick,
		required this.isSelected,
	});

	@override
	Widget build(BuildContext context) {
		return Container(
			decoration: BoxDecoration(
				borderRadius: BorderRadius.all(Radius.circular(8.0)),
				// TODO No...
				color: isSelected ? Colors.white : Colors.orange,
				border: Border(
					// TODO COlor of border?
				),
			),
			child: Text(text)
		);
	}
}
