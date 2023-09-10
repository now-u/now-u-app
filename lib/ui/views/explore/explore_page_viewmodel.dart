import 'package:causeApiClient/causeApiClient.dart';
import 'package:collection/collection.dart';
import 'package:meilisearch/meilisearch.dart';
import 'package:nowu/app/app.bottomsheets.dart';

import 'package:nowu/app/app.locator.dart';
import 'package:nowu/assets/constants.dart';
import 'package:nowu/models/time.dart';
import 'package:nowu/services/bottom_sheet_service.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/router_service.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/ui/bottom_sheets/explore_filter/explore_filter_sheet.dart';
import 'package:nowu/ui/views/explore/explore_page_definition.dart';
import 'package:nowu/ui/views/explore/section_filters/by_action_type.dart';
import 'package:nowu/ui/views/explore/section_filters/by_cause.dart';
import 'package:nowu/ui/views/explore/section_filters/by_time.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tuple/tuple.dart';

import 'explore_page_view.form.dart';

enum ExploreSectionType {
  Action,
  Learning,
  Campaign,
  News,
}

sealed class ExploreTileData {}

class ExplorePageViewModel extends FormViewModel {
  final _routerService = locator<RouterService>();
  final _causesService = locator<CausesService>();
  final _searchService = locator<SearchService>();
  final _bottomSheetService = locator<BottomSheetService>();

  BaseResourceSearchFilter searchFilter = const BaseResourceSearchFilter();

  late Set<int> filterCauseIds;
  Set<Tuple2<double, double>> filterTimeBrackets = Set();
  Set<ActionTypeEnum> filterActionTypes = Set();
  bool filterCompleted = false;
  bool filterRecommended = false;
  bool filterNew = false;

  BaseResourceSearchFilter baseFilter;

  ExplorePageViewModel({
    this.baseFilter = const BaseResourceSearchFilter(),
  }) {
    this.filterCauseIds =
        _causesService.userInfo?.selectedCausesIds.toSet() ?? Set();
  }

  List<ListAction> actions = [];
  List<LearningResource> learningResources = [];
  List<ListCampaign> campaigns = [];
  List<NewsArticle> newsArticles = [];
  ResourcesSearchResult allSearchResult = ResourcesSearchResult(
	actions: [],
	learningResources: [],
	campaigns: [],
	newsArticles: [],
  );

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
        causeIds: this.filterCauseIds.isEmpty ? null : filterCauseIds.toList(),
        timeBrackets: this.filterTimeBrackets.isEmpty
            ? null
            : filterTimeBrackets.toList(),
        types:
            this.filterActionTypes.isEmpty ? null : filterActionTypes.toList(),
        completed: filterCompleted == true ? true : null,
        recommended: filterRecommended == true ? true : null,
        releasedSince: filterNew == true
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
        causeIds: this.filterCauseIds.isEmpty ? null : filterCauseIds.toList(),
        timeBrackets: this.filterTimeBrackets.isEmpty
            ? null
            : filterTimeBrackets.toList(),
        // TODO Add learning resource types
        // types:
        //this.filterActionTypes.isEmpty ? null : filterActionTypes.toList(),
        completed: filterCompleted == true ? true : null,
        recommended: filterRecommended == true ? true : null,
        releasedSince: filterNew == true
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
        causeIds: this.filterCauseIds.isEmpty ? null : filterCauseIds.toList(),
        completed: filterCompleted == true ? true : null,
        recommended: filterRecommended == true ? true : null,
        releasedSince: filterNew == true
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
        causeIds: this.filterCauseIds.isEmpty ? null : filterCauseIds.toList(),
        releasedSince: filterNew == true
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
        causeIds: this.filterCauseIds.isEmpty ? null : filterCauseIds.toList(),
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
    filterCompleted = !filterCompleted;
    return search();
  }

  Future<void> toggleFilterRecommended() {
    filterRecommended = !filterRecommended;
    return search();
  }

  Future<void> toggleFilterNew() {
    filterNew = !filterNew;
    return search();
  }

  Future<void> openCausesFilterSheet() async {
    return _openFilterSheet(
      filterName: 'Causes',
      targetParameter: this.filterCauseIds,
      options: causes.map(
        (cause) =>
            ExploreFilterSheetOption(title: cause.title, value: cause.id),
      ),
    );
  }

  Future<void> openTimeBracketsFilterSheet() async {
    return _openFilterSheet(
      filterName: 'Times',
      targetParameter: this.filterTimeBrackets,
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
            .filterActionTypes
            .map(getActionTypeFromSubtype)
            .map((type) => type.name)
            .toSet(),
      ),
    );

    this.filterActionTypes = actionTypes
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
    return _causesService.openLearningResource(learningResource);
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
	return _causesService.learningResourceIsComplete(learningResource.id) == true;
  }
  
  bool isCampaignComplete(ListCampaign campaign) {
	return _causesService.campaignIsComplete(campaign.id) == true;
  }

  List<Cause> get causes => _causesService.causes;

  List<ExploreSectionArguments> get sections {
    final sections = _getSections();
    sections.forEach((section) {
      section.baseParams.mergeBaseFilter(this.baseFilter);
    });
    print('Merged base filter with every section');
    print(sections.map((section) => section.baseParams.causeIds));
    return sections;
  }

  List<ExploreSectionArguments> _getSections() {
    bool isFilterOnlyResource(ResourceType resourceType) {
      return baseFilter.resourceTypes?.length == 1 &&
          baseFilter.resourceTypes!.contains(resourceType);
    }

    if (isFilterOnlyResource(ResourceType.ACTION)) {
      return [
        ActionExploreSectionArgs(
          title: 'Actions of the month',
          baseParams: ActionSearchFilter(ofTheMonth: true),
        ),
        ActionExploreSectionArgs(
          title: 'Actions by cause',
          filter: ActionByCauseExploreFilter(),
        ),
        ActionExploreSectionArgs(
          title: 'Actions by time',
          filter: ActionTimeExploreFilter(),
        ),
        ActionExploreSectionArgs(
          title: 'Actions by type',
          filter: ByActionTypeFilter(),
        ),
        ActionExploreSectionArgs(
          title: 'Completed actions',
          baseParams: ActionSearchFilter(completed: true),
          backgroundColor: CustomColors.lightOrange,
        ),
      ];
    }
    if (isFilterOnlyResource(ResourceType.LEARNING_RESOURCE)) {
      return [
        LearningResourceExploreSectionArgs(
          title: 'Learning resources by time',
          filter: LearningResourceTimeExploreFilter(),
        ),
        LearningResourceExploreSectionArgs(
          title: 'Learning resource by cause',
          filter: LearningResourceByCauseExploreFilter(),
        ),
        LearningResourceExploreSectionArgs(
          title: 'Learning resources',
        ),
        LearningResourceExploreSectionArgs(
          title: 'Completed learning',
          backgroundColor: CustomColors.lightOrange,
          baseParams: LearningResourceSearchFilter(completed: true),
        ),
      ];
    }
    if (isFilterOnlyResource(ResourceType.CAMPAIGN)) {
      return [
        CampaignExploreSectionArgs(
          title: 'Campaigns of the month',
          baseParams: CampaignSearchFilter(ofTheMonth: true),
        ),
        CampaignExploreSectionArgs(
          title: 'Recommended campaigns',
          baseParams: CampaignSearchFilter(recommended: true),
        ),
        CampaignExploreSectionArgs(
          title: 'Campaigns by cause',
          filter: CampaignByCauseExploreFilter(),
        ),
        CampaignExploreSectionArgs(
          title: 'Completed campaigns',
          baseParams: CampaignSearchFilter(completed: true),
          backgroundColor: CustomColors.lightOrange,
        ),
      ];
    }

    return [
      if (baseFilter.resourceTypes == null ||
          baseFilter.resourceTypes!.contains(ResourceType.ACTION))
        ActionExploreSectionArgs(
          title: 'Actions',
          link: const BaseResourceSearchFilter(
              resourceTypes: [ResourceType.ACTION]),
          description:
              'Take a wide range of actions to drive lasting change for issues you care about',
        ),
      if (baseFilter.resourceTypes == null ||
          baseFilter.resourceTypes!.contains(ResourceType.LEARNING_RESOURCE))
        LearningResourceExploreSectionArgs(
          title: 'Learn',
          link: const BaseResourceSearchFilter(
              resourceTypes: [ResourceType.LEARNING_RESOURCE]),
          description:
              'Learn more about key topics of pressing social and environmental issues',
        ),
      if (baseFilter.resourceTypes == null ||
          baseFilter.resourceTypes!.contains(ResourceType.CAMPAIGN))
        CampaignExploreSectionArgs(
          title: 'Campaigns',
          link: const BaseResourceSearchFilter(
              resourceTypes: [ResourceType.CAMPAIGN]),
          description:
              'Join members of the now-u community in coordinated campaigns to make a difference',
        ),
      if (baseFilter.resourceTypes == null ||
          baseFilter.resourceTypes!.contains(ResourceType.NEWS_ARTICLE))
        NewsArticleExploreSectionArgs(
          title: 'News',
          description:
              'Find out what’s going on in the world this week in relation to your chosen causes',
        ),
    ];
  }

  // TODO Merge with base filter rather than replacing
  void updateFilter(BaseResourceSearchFilter args) {
    this.baseFilter = args;
    notifyListeners();
  }

  Cause getCauseById(int id) {
    return _causesService.getCause(id);
  }

  bool hasLinks() {
    return sections.any((section) => section.link != null);
  }

  void navigateToSearchPage() {
    _routerService.navigateToSearchView();
  }
}

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
