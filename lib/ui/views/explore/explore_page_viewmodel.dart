import 'package:causeApiClient/causeApiClient.dart';
import 'package:collection/collection.dart';
import 'package:nowu/app/app.locator.dart';
import 'package:nowu/models/time.dart';
import 'package:nowu/services/bottom_sheet_service.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/ui/bottom_sheets/explore_filter/explore_filter_sheet.dart';
import 'package:nowu/utils/new_since.dart';
import 'package:stacked/stacked.dart';
import 'package:tuple/tuple.dart';

import '../../../services/analytics.dart';
import '../../../services/model/search/search_response.dart';
import '../../paging/paging_state.dart';
import 'explore_page_view.dart';
import 'explore_page_view.form.dart';

enum ExploreSectionType {
  Action,
  Learning,
  Campaign,
  News,
}

class ExplorePageFilterData {
  Set<int> filterCauseIds;
  Set<Tuple2<double, double>> filterTimeBrackets = Set();
  Set<ActionTypeEnum> filterActionTypes = Set();
  bool filterCompleted = false;
  bool filterRecommended = false;
  bool filterNew = false;

  ExplorePageFilterData({
    Set<int>? filterCauseIds,
    Set<Tuple2<double, double>>? filterTimeBrackets,
    Set<ActionTypeEnum>? filterActionTypes,
    this.filterCompleted = false,
    this.filterRecommended = false,
    this.filterNew = false,
  })  : this.filterCauseIds = filterCauseIds ?? Set(),
        this.filterTimeBrackets = filterTimeBrackets ?? Set(),
        this.filterActionTypes = filterActionTypes ?? Set();
}

class ExplorePageViewModel extends FormViewModel {
  final _causesService = locator<CausesService>();
  final _searchService = locator<SearchService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _analyticsService = locator<AnalyticsService>();

  BaseResourceSearchFilter searchFilter = const BaseResourceSearchFilter();

  late ExplorePageFilterData filterData;

  ExplorePageViewModel({
    ExplorePageFilterData? filterData,
  }) {
    this.filterData = filterData ??
        ExplorePageFilterData(
          filterCauseIds:
              _causesService.userInfo?.selectedCausesIds.toSet() ?? Set(),
        );
  }

  List<Cause> get causes => _causesService.causes;
  PagingState actions = InitialLoading();
  PagingState learningResources = InitialLoading();
  PagingState campaigns = InitialLoading();
  PagingState newsArticles = InitialLoading();
  ResourcesSearchResult? allSearchResult;

  Future<void> search() {
    return (
      searchActions(),
      searchLearningResources(),
      searchCampaigns(),
      searchNewsArticles(),
      searchAll(),
    ).wait;
  }

  ActionSearchFilter _getActionsFilter() {
    return ActionSearchFilter(
      causeIds: this.filterData.filterCauseIds.isEmpty
          ? null
          : filterData.filterCauseIds.toList(),
      timeBrackets: this.filterData.filterTimeBrackets.isEmpty
          ? null
          : filterData.filterTimeBrackets.toList(),
      types: this.filterData.filterActionTypes.isEmpty
          ? null
          : filterData.filterActionTypes.toList(),
      completed: filterData.filterCompleted == true ? true : null,
      recommended: filterData.filterRecommended == true ? true : null,
      releasedSince: filterData.filterNew == true ? newSinceDate() : null,
      query: searchBarValue,
    );
  }

  Future<void> loadMoreActions() async {
    if (!actions.canLoadMore()) return;

    actions = LoadingMore(items: actions.items);

    // Remove search fallback to use user causes
    SearchResponse<ListAction> response = await _searchService.searchActions(
      offset: actions.offset(),
      filter: _getActionsFilter(),
    );

    actions = Data(
      items: actions.items + response.items,
      hasReachedMax: response.hasReachedMax,
    );

    notifyListeners();
  }

  Future<void> searchActions() async {
    SearchResponse<ListAction> response = await _searchService.searchActions(
      filter: _getActionsFilter(),
    );

    actions = Data(
      items: response.items,
      hasReachedMax: response.hasReachedMax,
    );

    notifyListeners();
  }

  LearningResourceSearchFilter _getLearningResourcesFilter() {
    return LearningResourceSearchFilter(
      causeIds: this.filterData.filterCauseIds.isEmpty
          ? null
          : filterData.filterCauseIds.toList(),
      timeBrackets: this.filterData.filterTimeBrackets.isEmpty
          ? null
          : filterData.filterTimeBrackets.toList(),
      // TODO Add learning resource types
      // types:
      //this.filterActionTypes.isEmpty ? null : filterActionTypes.toList(),
      completed: filterData.filterCompleted == true ? true : null,
      recommended: filterData.filterRecommended == true ? true : null,
      releasedSince: filterData.filterNew == true ? newSinceDate() : null,
      query: searchBarValue,
    );
  }

  Future<void> loadMoreLearningResources() async {
    if (!learningResources.canLoadMore()) return;

    learningResources = LoadingMore(items: learningResources.items);

    SearchResponse<LearningResource> response =
        await _searchService.searchLearningResources(
      offset: learningResources.offset(),
      filter: _getLearningResourcesFilter(),
    );

    learningResources = Data(
      items: learningResources.items + response.items,
      hasReachedMax: response.hasReachedMax,
    );

    notifyListeners();
  }

  Future<void> searchLearningResources() async {
    SearchResponse<LearningResource> response =
        await _searchService.searchLearningResources(
      filter: _getLearningResourcesFilter(),
    );

    learningResources = Data(
      items: response.items,
      hasReachedMax: response.hasReachedMax,
    );

    notifyListeners();
  }

  CampaignSearchFilter _getCampaignsFilter() {
    return CampaignSearchFilter(
      causeIds: this.filterData.filterCauseIds.isEmpty
          ? null
          : filterData.filterCauseIds.toList(),
      completed: filterData.filterCompleted == true ? true : null,
      recommended: filterData.filterRecommended == true ? true : null,
      releasedSince: filterData.filterNew == true ? newSinceDate() : null,
      query: searchBarValue,
    );
  }

  Future<void> loadMoreCampaigns() async {
    if (!campaigns.canLoadMore()) return;

    campaigns = LoadingMore(items: campaigns.items);

    SearchResponse<ListCampaign> response =
        await _searchService.searchCampaigns(
      filter: _getCampaignsFilter(),
      offset: campaigns.offset(),
    );

    campaigns = Data(
      items: campaigns.items + response.items,
      hasReachedMax: response.hasReachedMax,
    );

    notifyListeners();
  }

  Future<void> searchCampaigns() async {
    SearchResponse<ListCampaign> response =
        await _searchService.searchCampaigns(
      filter: _getCampaignsFilter(),
    );

    campaigns = Data(
      items: response.items,
      hasReachedMax: response.hasReachedMax,
    );

    notifyListeners();
  }

  NewsArticleSearchFilter _getNewsArticlesFilter() {
    return NewsArticleSearchFilter(
      causeIds: this.filterData.filterCauseIds.isEmpty
          ? null
          : filterData.filterCauseIds.toList(),
      releasedSince: filterData.filterNew == true ? newSinceDate() : null,
      query: searchBarValue,
    );
  }

  Future<void> loadMoreNewsArticles() async {
    if (!newsArticles.canLoadMore()) return;

    newsArticles = LoadingMore(items: newsArticles.items);

    SearchResponse<NewsArticle> response =
        await _searchService.searchNewsArticles(
      filter: _getNewsArticlesFilter(),
      offset: newsArticles.offset(),
    );

    newsArticles = Data(
      items: newsArticles.items + response.items,
      hasReachedMax: response.hasReachedMax,
    );

    notifyListeners();
  }

  Future<void> searchNewsArticles() async {
    SearchResponse<NewsArticle> response =
        await _searchService.searchNewsArticles(
      filter: _getNewsArticlesFilter(),
    );

    newsArticles = Data(
      items: response.items,
      hasReachedMax: response.hasReachedMax,
    );

    notifyListeners();
  }

  Future<void> searchAll() async {
    allSearchResult = await _searchService.searchResources(
      filter: BaseResourceSearchFilter(
        // TODO Add released since
        causeIds: this.filterData.filterCauseIds.isEmpty
            ? null
            : filterData.filterCauseIds.toList(),
        query: searchBarValue,
        releasedSince: filterData.filterNew == true ? newSinceDate() : null,
      ),
    );
    notifyListeners();
  }

  Future<void> _openFilterSheet<T>({
    required String filterName,
    required Set<T> targetParameter,
    required Iterable<ExploreFilterSheetOption<T>> options,
  }) async {
    final outputSelection = await _bottomSheetService.showExploreFilterSheet<T>(
      ExploreFilterSheetData(
        filterName: filterName,
        options: options.toList(),
        initialSelectedValues: targetParameter,
      ),
    );

    targetParameter = outputSelection ?? Set();
    search();
  }

  Future<void> toggleFilterCompleted() {
    filterData.filterCompleted = !filterData.filterCompleted;
    return search();
  }

  Future<void> toggleFilterRecommended() {
    filterData.filterRecommended = !filterData.filterRecommended;
    return search();
  }

  Future<void> toggleFilterNew() {
    filterData.filterNew = !filterData.filterNew;
    return search();
  }

  Future<void> openCausesFilterSheet() async {
    return _openFilterSheet(
      filterName: 'Causes',
      targetParameter: this.filterData.filterCauseIds,
      options: causes.map(
        (cause) =>
            ExploreFilterSheetOption(title: cause.title, value: cause.id),
      ),
    );
  }

  Future<void> openTimeBracketsFilterSheet() async {
    return _openFilterSheet(
      filterName: 'Times',
      targetParameter: this.filterData.filterTimeBrackets,
      options: timeBrackets.map(
        (timeBracket) => ExploreFilterSheetOption(
          title: timeBracket.text,
          value: Tuple2(timeBracket.minTime, timeBracket.maxTime),
        ),
      ),
    );
  }

  Future<void> openActionTypesFilterSheet() async {
    final selectedActionTypes =
        await _bottomSheetService.showExploreFilterSheet<String>(
      ExploreFilterSheetData(
        filterName: 'Action type',
        options: actionTypes
            .map(
              (type) => ExploreFilterSheetOption(
                title: type.name,
                value: type.name,
              ),
            )
            .toList(),
        initialSelectedValues: this
            .filterData
            .filterActionTypes
            .map(getActionTypeFromSubtype)
            .map((type) => type.name)
            .toSet(),
      ),
    );

    this.filterData.filterActionTypes = actionTypes
        .where((type) => selectedActionTypes?.contains(type.name) == true)
        .map((type) => type.subTypes)
        .flattened
        .toSet();
    search();
  }

  Future<void> openAction(ListAction action) {
    return _causesService.openAction(action.id);
  }

  Future<void> openLearningResource(LearningResource learningResource) {
    return _causesService
        .openLearningResource(learningResource)
        .then((value) => notifyListeners());
  }

  Future<void> openCampaign(ListCampaign campaign) {
    return _causesService.openCampaign(campaign);
  }

  Future<void> openNewsArticle(NewsArticle article) {
    return _causesService.openNewArticle(article);
  }

  bool? isActionComplete(ListAction action) {
    return _causesService.actionIsComplete(action.id);
  }

  bool? isLearningResourceComplete(LearningResource learningResource) {
    return _causesService.learningResourceIsComplete(learningResource.id);
  }

  bool? isCampaignComplete(ListCampaign campaign) {
    return _causesService.campaignIsComplete(campaign.id);
  }

  void onTabChanged(ExploreTabKey tab) {
    _analyticsService.setCustomRoute('explore_${tab.toString()}');
  }
}

sealed class ExploreTileData {}

// TODO Move out of this file
//-- Explore Sections --//
class ActionExploreTileData extends ExploreTileData {
  final ListAction action;
  final bool? isCompleted;

  ActionExploreTileData(this.action, this.isCompleted);
}

class LearningResourceExploreTileData extends ExploreTileData {
  final LearningResource learningResource;
  final bool? isCompleted;

  LearningResourceExploreTileData(this.learningResource, this.isCompleted);
}

// TODO Rename these, they have the same name as the widget
class CampaignExploreTileData extends ExploreTileData {
  final ListCampaign campaign;
  final bool? isCompleted;

  CampaignExploreTileData(this.campaign, this.isCompleted);
}

class NewsArticleExploreTileData extends ExploreTileData {
  final NewsArticle article;

  NewsArticleExploreTileData(this.article);
}
