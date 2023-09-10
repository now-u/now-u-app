import 'package:nowu/assets/components/explore_tiles.dart';
import 'package:nowu/assets/constants.dart';
import 'package:flutter/material.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/ui/common/dropdown_filter_chip.dart';
import 'package:nowu/ui/views/explore/explore_page_definition.dart';
import 'package:nowu/ui/views/explore/explore_section_view.dart';
import 'package:nowu/ui/views/explore/tabs/explore_all_tab.dart';
import 'package:nowu/ui/views/explore/tabs/explore_campaign_tab.dart';
import 'package:nowu/ui/views/explore/tabs/explore_news_article_tab.dart';
import 'package:nowu/utils/intersperse.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'explore_page_viewmodel.dart';
import 'explore_page_view.form.dart';
import 'tabs/explore_action_tab.dart';
import 'tabs/explore_learning_resource_tab.dart';

final double horizontalPadding = CustomPaddingSize.small;

@FormView(fields: [FormTextField(name: 'searchBar')])
class ExplorePage extends StackedView<ExplorePageViewModel> with $ExplorePage {
  final BaseResourceSearchFilter filter;

  ExplorePage({Key? key, this.filter = const BaseResourceSearchFilter()})
      : super(key: key);

  final _searchBarFocusNode = FocusNode();

  @override
  ExplorePageViewModel viewModelBuilder(BuildContext context) =>
      ExplorePageViewModel(baseFilter: filter);

  @override
  void onViewModelReady(ExplorePageViewModel viewModel) {
    // TODO
    syncFormWithViewModel(viewModel);
    viewModel.search();
  }

  Widget _header(BuildContext context, ExplorePageViewModel model) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
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
            TabBar.secondary(
              tabs: const [
                const Text('All'),
                const Text('Actions'),
                const Text('Campaigns'),
              ],
              onTap: (_) {
                print('Hello world');
              },
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
                            child: Text(getResourceTypeDisplay(resourceType)),
                          ),
                      ],
                      onChanged: (ResourceType? value) {
                        model.updateFilter(
                          BaseResourceSearchFilter(
                            resourceTypes: value != null ? [value] : null,
                          ),
                        );
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
                            value: cause.id,
                            child: Text(cause.title),
                          ),
                      ],
                      onChanged: (int? value) {
                        model.updateFilter(
                          model.baseFilter.copyWith(
                            causeIds: value != null ? [value] : null,
                          ),
                        );
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
    ExploreSectionArguments sectionArgs,
    ExplorePageViewModel pageViewModel,
  ) {
    switch (sectionArgs) {
      case ActionExploreSectionArgs():
        return ActionExploreSection(sectionArgs, pageViewModel: pageViewModel);
      case LearningResourceExploreSectionArgs():
        return LearningResourceExploreSection(
          sectionArgs,
          pageViewModel: pageViewModel,
        );
      case CampaignExploreSectionArgs():
        return CampaignExploreSection(
          sectionArgs,
          pageViewModel: pageViewModel,
        );
      case NewsArticleExploreSectionArgs():
        return NewsArticleExploreSection(
          sectionArgs,
          pageViewModel: pageViewModel,
        );
    }
  }

  // @override
  // Widget builder(
  //   BuildContext context,
  //   ExplorePageViewModel viewModel,
  //   Widget? child,
  // ) {
  //   return Scaffold(
  //     body: SingleChildScrollView(
  //       child: Column(
  //         children: [
  //               _header(context, viewModel),
  //             ] +
  //             viewModel.sections
  //                 .map((sectionArgs) => _buildSection(sectionArgs, viewModel))
  //                 .toList(),
  //       ),
  //     ),
  //   );
  // }
  @override
  Widget builder(
    BuildContext context,
    ExplorePageViewModel viewModel,
    Widget? child,
  ) {
    return ExploreTabs(viewModel, searchBarController: searchBarController);
  }
}

class ExploreTabData {
  final String title;
  final Widget Function(ExplorePageViewModel) child;

  const ExploreTabData({
    required this.title,
    required this.child,
  });
}

final exploreTabs = [
  ExploreTabData(
    title: 'All',
    child: (viewModel) => ExploreAllTab(viewModel),
  ),
  ExploreTabData(
    title: 'Actions',
    child: (viewModel) => ExploreActionTab(viewModel),
  ),
  ExploreTabData(
    title: 'Learn',
    child: (viewModel) => ExploreLearningResourceTab(viewModel),
  ),
  ExploreTabData(
    title: 'Campaigns',
    child: (viewModel) => ExploreCampaignTab(viewModel),
  ),
  ExploreTabData(
    title: 'News',
    child: (viewModel) => ExploreNewsArticleTab(viewModel),
  ),
];


class ExploreTabs extends StatefulWidget {
  final ExplorePageViewModel viewModel;
  final TextEditingController searchBarController;

  const ExploreTabs(
    this.viewModel, {
    required this.searchBarController,
    super.key,
  });

  @override
  State<ExploreTabs> createState() => _ExploreTabsState();
}

class _ExploreTabsState extends State<ExploreTabs>
    with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: exploreTabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 1,
        shadowColor: CustomColors.greyLight1,
        flexibleSpace: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: 50,
          ),
          child: SearchBar(
            controller: widget.searchBarController,
            leading: const Icon(Icons.search),
            hintText: 'Explore now-u resources',
            onChanged: (value) => widget.viewModel.search(),
          ),
        ),
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          labelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          unselectedLabelColor: Colors.grey,
		  unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
          tabs: exploreTabs.map((tab) => Text(tab.title)).toList(),
		  tabAlignment: TabAlignment.start,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children:
            exploreTabs.map((tab) => tab.child(widget.viewModel)).toList(),
      ),
    );
  }
}
