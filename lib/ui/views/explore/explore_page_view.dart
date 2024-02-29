import 'package:nowu/assets/constants.dart';
import 'package:flutter/material.dart';
import 'package:nowu/ui/views/explore/tabs/explore_all_tab.dart';
import 'package:nowu/ui/views/explore/tabs/explore_campaign_tab.dart';
import 'package:nowu/ui/views/explore/tabs/explore_news_article_tab.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'explore_page_viewmodel.dart';
import 'explore_page_view.form.dart';
import 'tabs/explore_action_tab.dart';
import 'tabs/explore_learning_resource_tab.dart';

final double horizontalPadding = CustomPaddingSize.small;

@FormView(fields: [FormTextField(name: 'searchBar')])
class ExplorePage extends StackedView<ExplorePageViewModel> with $ExplorePage {
  final ExplorePageFilterData? filterData;

  ExplorePage({Key? key, this.filterData}) : super(key: key);

  @override
  ExplorePageViewModel viewModelBuilder(BuildContext context) =>
      ExplorePageViewModel(filterData: filterData);

  @override
  void onViewModelReady(ExplorePageViewModel viewModel) {
    syncFormWithViewModel(viewModel);
    viewModel.search();
  }

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
  final Widget Function(
    ExplorePageViewModel viewModel,
    void Function(ExploreTabKey tab) changeTab,
  ) child;

  const ExploreTabData({
    required this.title,
    required this.child,
  });
}

enum ExploreTabKey {
  ALL,
  CAMPAIGN,
  ACTIONS,
  LEARN,
  NEWS,
}

ExploreTabData getTabData(ExploreTabKey tab) {
  switch (tab) {
    case ExploreTabKey.ALL:
      return ExploreTabData(
        title: 'All',
        child: (viewModel, changeTab) => ExploreAllTab(viewModel, changeTab),
      );
    case ExploreTabKey.ACTIONS:
      return ExploreTabData(
        title: 'Actions',
        child: (viewModel, _) => ExploreActionTab(viewModel),
      );
    case ExploreTabKey.LEARN:
      return ExploreTabData(
        title: 'Learn',
        child: (viewModel, _) => ExploreLearningResourceTab(viewModel),
      );
    case ExploreTabKey.CAMPAIGN:
      return ExploreTabData(
        title: 'Campaigns',
        child: (viewModel, _) => ExploreCampaignTab(viewModel),
      );
    case ExploreTabKey.NEWS:
      return ExploreTabData(
        title: 'News',
        child: (viewModel, _) => ExploreNewsArticleTab(viewModel),
      );
  }
}

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
    _tabController =
        TabController(length: ExploreTabKey.values.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 1,
        shadowColor: CustomColors.greyLight1,
        automaticallyImplyLeading: false,
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
          labelStyle:
              const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          unselectedLabelColor: Colors.grey,
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
          tabs: ExploreTabKey.values
              .map((tab) => Text(getTabData(tab).title))
              .toList(),
          tabAlignment: TabAlignment.start,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: ExploreTabKey.values
            .map(
              (tab) => getTabData(tab).child(
                widget.viewModel,
                (ExploreTabKey tab) => _tabController?.animateTo(tab.index),
              ),
            )
            .toList(),
      ),
    );
  }
}
