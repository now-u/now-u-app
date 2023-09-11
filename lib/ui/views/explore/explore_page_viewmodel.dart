import 'package:causeApiClient/causeApiClient.dart';
import 'package:collection/collection.dart';

import 'package:nowu/app/app.locator.dart';
import 'package:nowu/models/time.dart';
import 'package:nowu/services/bottom_sheet_service.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/ui/bottom_sheets/explore_filter/explore_filter_sheet.dart';
import 'package:stacked/stacked.dart';
import 'package:tuple/tuple.dart';

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

  BaseResourceSearchFilter searchFilter = const BaseResourceSearchFilter();

  late ExplorePageFilterData filterData;

  ExplorePageViewModel({
	ExplorePageFilterData? filterData,
  }) {
    this.filterData = filterData ?? ExplorePageFilterData(
		filterCauseIds: _causesService.userInfo?.selectedCausesIds.toSet() ?? Set(),
	);
  }

  List<Cause> get causes => _causesService.causes;
  List<ListAction> actions = [];
  List<LearningResource> learningResources = [];
  List<ListCampaign> campaigns = [];
  List<NewsArticle> newsArticles = [];
  ResourcesSearchResult? allSearchResult;

  Future<void> search() {
    return Future.wait(
      [
        searchActions(),
        searchLearningResources(),
        searchCampaigns(),
        searchNewsArticles(),
        searchAll(),
      ],
    );
  }

  Future<void> searchActions() async {
    // Remove search fallback to use user causes
    actions = await _searchService.searchActions(
      filter: ActionSearchFilter(
        causeIds: this.filterData.filterCauseIds.isEmpty ? null : filterData.filterCauseIds.toList(),
        timeBrackets: this.filterData.filterTimeBrackets.isEmpty
            ? null
            : filterData.filterTimeBrackets.toList(),
        types:
            this.filterData.filterActionTypes.isEmpty ? null : filterData.filterActionTypes.toList(),
        completed: filterData.filterCompleted == true ? true : null,
        recommended: filterData.filterRecommended == true ? true : null,
        releasedSince: filterData.filterNew == true
            ? (DateTime.now().subtract(const Duration(days: 2)))
            : null,
        query: searchBarValue,
      ),
    );
    notifyListeners();
  }

  Future<void> searchLearningResources() async {
    learningResources = await _searchService.searchLearningResources(
      filter: LearningResourceSearchFilter(
        causeIds: this.filterData.filterCauseIds.isEmpty ? null : filterData.filterCauseIds.toList(),
        timeBrackets: this.filterData.filterTimeBrackets.isEmpty
            ? null
            : filterData.filterTimeBrackets.toList(),
        // TODO Add learning resource types
        // types:
        //this.filterActionTypes.isEmpty ? null : filterActionTypes.toList(),
        completed: filterData.filterCompleted == true ? true : null,
        recommended: filterData.filterRecommended == true ? true : null,
        releasedSince: filterData.filterNew == true
            ? (DateTime.now().subtract(const Duration(days: 2)))
            : null,
        query: searchBarValue,
      ),
    );
    notifyListeners();
  }

  Future<void> searchCampaigns() async {
    campaigns = await _searchService.searchCampaigns(
      filter: CampaignSearchFilter(
        causeIds: this.filterData.filterCauseIds.isEmpty ? null : filterData.filterCauseIds.toList(),
        completed: filterData.filterCompleted == true ? true : null,
        recommended: filterData.filterRecommended == true ? true : null,
        releasedSince: filterData.filterNew == true
            ? (DateTime.now().subtract(const Duration(days: 2)))
            : null,
        query: searchBarValue,
      ),
    );
    notifyListeners();
  }

  Future<void> searchNewsArticles() async {
    newsArticles = await _searchService.searchNewsArticles(
      filter: NewsArticleSearchFilter(
        causeIds: this.filterData.filterCauseIds.isEmpty ? null : filterData.filterCauseIds.toList(),
        releasedSince: filterData.filterNew == true
            ? (DateTime.now().subtract(const Duration(days: 2)))
            : null,
        query: searchBarValue,
      ),
    );
    notifyListeners();
  }

  Future<void> searchAll() async {
    allSearchResult = await _searchService.searchResources(
      filter: BaseResourceSearchFilter(
        // TODO Add released since
        causeIds: this.filterData.filterCauseIds.isEmpty ? null : filterData.filterCauseIds.toList(),
        query: searchBarValue,
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
            .filterData.filterActionTypes
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

  bool isActionComplete(ListAction action) {
    return _causesService.actionIsComplete(action.id) == true;
  }

  bool isLearningResourceComplete(LearningResource learningResource) {
    return _causesService.learningResourceIsComplete(learningResource.id) ==
        true;
  }

  bool isCampaignComplete(ListCampaign campaign) {
    return _causesService.campaignIsComplete(campaign.id) == true;
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
