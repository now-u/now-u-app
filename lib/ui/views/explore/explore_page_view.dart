import 'package:nowu/assets/components/searchBar.dart';
import 'package:nowu/assets/constants.dart';
import 'package:flutter/material.dart' hide SearchBar;
import 'package:nowu/services/search_service.dart';
import 'package:nowu/ui/common/dropdown_filter_chip.dart';
import 'package:nowu/ui/views/explore/explore_page_definition.dart';
import 'package:nowu/ui/views/explore/explore_section_view.dart';
import 'package:stacked/stacked.dart';

import 'explore_page_viewmodel.dart';

final double horizontalPadding = CustomPaddingSize.small;

class ExplorePage extends StatelessWidget {
  final BaseResourceSearchFilter filter;

  ExplorePage({Key? key, this.filter = const BaseResourceSearchFilter()})
      : super(key: key);

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
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  children: [
                    DropdownFilterChip<ResourceType>(
                      label: Text(
                        model.baseFilter.resourceTypes?.isNotEmpty == true
                            ? 'Type: ${getResourceTypeDisplay(model.baseFilter.resourceTypes!.first)}'
                            : 'Resource Types',
                        //  selectedCategories.value.isEmpty
                        //      ? 'category'
                        //      : selectedCategories.value.first,
                      ),
                      value: model.baseFilter.resourceTypes?.first,
                      // value: selectedCategories.value.isEmpty
                      //     ? null
                      //     : selectedCategories.value.first,
                      items: [
                        const DropdownMenuItem(value: null, child: Text('All')),
                        for (final resourceType in ResourceType.values)
                          DropdownMenuItem(
                              value: resourceType,
                              child:
                                  Text(getResourceTypeDisplay(resourceType))),
                      ],
                      onChanged: (ResourceType? value) {
                        model.updateFilter(BaseResourceSearchFilter(
                            resourceTypes: value != null ? [value] : null));
                      },
                    ),
                    DropdownFilterChip<int>(
                      label: Text(
                        model.baseFilter.causeIds?.isNotEmpty == true
                            ? 'Cause: ${model.getCauseById(model.baseFilter.causeIds!.first).title}'
                            : 'Causes',
                        //  selectedCategories.value.isEmpty
                        //      ? 'category'
                        //      : selectedCategories.value.first,
                      ),
                      value: model.baseFilter.causeIds?.first,
                      // value: selectedCategories.value.isEmpty
                      //     ? null
                      //     : selectedCategories.value.first,
                      items: [
                        const DropdownMenuItem(value: null, child: Text('All')),
                        for (final cause in model.causes)
                          DropdownMenuItem(
                              value: cause.id, child: Text(cause.title)),
                      ],
                      onChanged: (int? value) {
                        model.updateFilter(model.baseFilter.copyWith(
                            causeIds: value != null ? [value] : null));
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
      ExploreSectionArguments sectionArgs, ExplorePageViewModel pageViewModel) {
    switch (sectionArgs) {
      case ActionExploreSectionArgs():
        return ActionExploreSection(sectionArgs, pageViewModel: pageViewModel);
      case LearningResourceExploreSectionArgs():
        return LearningResourceExploreSection(sectionArgs,
            pageViewModel: pageViewModel);
      case CampaignExploreSectionArgs():
        return CampaignExploreSection(sectionArgs,
            pageViewModel: pageViewModel);
      case NewsArticleExploreSectionArgs():
        return NewsArticleExploreSection(sectionArgs,
            pageViewModel: pageViewModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExplorePageViewModel>.reactive(
      viewModelBuilder: () => ExplorePageViewModel(baseFilter: filter),
      builder: (context, model, child) {
        print(
            'Inside page render ${model.sections.map((sectionArgs) => sectionArgs.baseParams.causeIds).toList()}');
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
