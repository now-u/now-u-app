import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nowu/assets/constants.dart';
import 'package:nowu/ui/views/explore/bloc/explore_filter_bloc.dart';
import 'package:nowu/ui/views/explore/bloc/explore_filter_state.dart';
import 'package:nowu/ui/views/explore/tabs/explore_all_tab.dart';
import 'package:nowu/ui/views/explore/tabs/explore_campaign_tab.dart';
import 'package:nowu/ui/views/explore/tabs/explore_news_article_tab.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart' show FormView, FormTextField;
import 'package:auto_route/auto_route.dart';

import 'explore_page_view.form.dart';
import 'explore_page_viewmodel.dart';
import 'tabs/explore_action_tab.dart';
import 'tabs/explore_learning_resource_tab.dart';

final double horizontalPadding = CustomPaddingSize.small;

@RoutePage()
@FormView(fields: [FormTextField(name: 'searchBar')])
class ExploreView extends StackedView<ExplorePageViewModel> with $ExploreView {
  final ExplorePageFilterData? filterData;

  ExploreView({Key? key, this.filterData}) : super(key: key);

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
    return BlocProvider(
      create: (context) => ExploreFilterBloc(),
      child: ExploreTabs(viewModel, searchBarController: searchBarController),
    );
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
  ExplorePageViewModel? _viewModel;
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: ExploreTabKey.values.length, vsync: this);
    _viewModel = widget.viewModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 1,
        shadowColor: CustomColors.greyLight1,
        automaticallyImplyLeading: false,
        flexibleSpace: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: 50,
          ),
          child: BlocBuilder<ExploreFilterBloc, ExploreFilterState>(
            builder: (context, state) {
              return SearchBar(
                controller: widget.searchBarController,
                leading: const Icon(Icons.search),
                hintText: 'Explore now-u resources',
                onChanged: (value) {
                  context
                      .read<ExploreFilterBloc>()
                      .updateFilter(state.copyWith(queryText: value));
                },
              );
            },
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
                (ExploreTabKey tab) {
                  _viewModel?.onTabChanged(tab);
                  _tabController?.animateTo(tab.index);
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
