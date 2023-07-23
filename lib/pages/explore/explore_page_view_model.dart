import 'dart:math';
import 'package:causeApiClient/causeApiClient.dart';
import 'package:nowu/assets/components/explore_tiles.dart';
import 'package:nowu/models/time.dart';
import 'package:nowu/routes.dart';
import 'package:nowu/services/auth.dart';
import 'package:nowu/services/navigation_service.dart';
import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:nowu/services/search_service.dart';

import 'package:nowu/viewmodels/base_model.dart';
import 'package:nowu/locator.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:tuple/tuple.dart';

class ExplorePageArguments {
  final List<ExploreSectionArguments> sections;
  final String title;
  final Map<String, dynamic>? baseParams;

  ExplorePageArguments(
      {required this.sections, required this.title, this.baseParams});

  ExplorePageArguments addBaseParams(Map<String, dynamic> baseParams) {
    return ExplorePageArguments(
        sections: sections,
        title: title,
        baseParams: mergeMaps(baseParams, this.baseParams ?? {}));
  }
}

class ExploreSectionArguments<FilterT extends ResourceFilter<FilterT>> {
  /// Title of the section
  final String title;

  /// Where clicking on the title should go
  final ExplorePageArguments? link;

  /// Description of the section
  final String? description;

  // Params to provide to fetch query
  final FilterT baseParams;

  ///
  final BaseExploreFilter<FilterT>? filter;

  final Color? backgroundColor;

  final ExploreSectionType type;

  ExploreSectionArguments({
    required this.title,
    required this.type,
    required this.filter,
    required this.baseParams,
    required this.description,
    required this.link,
    required this.backgroundColor,
  });

  ExploreSectionArguments<FilterT> addBaseParams(FilterT baseParams) {
    return ExploreSectionArguments(
      title: title,
      // TODO This doesnt quite work as we also need to update the title
      // link: link != null ? link!.addBaseParams(baseParams) : null,
      link: link,
      description: description,
      baseParams: this.baseParams != null ? baseParams.merge(this.baseParams!) : baseParams,
      filter: filter,
      backgroundColor: backgroundColor,
      type: type,
    );
  }
}

class CampaignExploreSectionArgs extends ExploreSectionArguments<CampaignSearchFilter> {
  CampaignExploreSectionArgs({
	required String title,
	BaseExploreFilter<CampaignSearchFilter>? filter,
	ExplorePageArguments? link,
	String? description,
	CampaignSearchFilter? baseParams,
	Color? backgroundColor,
  }): super(
	type: ExploreSectionType.Campaign,
	title: title,
	link: link,
	description: description,
	baseParams: baseParams ?? CampaignSearchFilter(),
	filter: filter,
	backgroundColor: backgroundColor,
  );
}

class ActionExploreSectionArgs extends ExploreSectionArguments<ActionSearchFilter> {
  ActionExploreSectionArgs({
	required String title,
	BaseExploreFilter<ActionSearchFilter>? filter,
	ExplorePageArguments? link,
	String? description,
	ActionSearchFilter? baseParams,
	Color? backgroundColor,
  }): super(
	type: ExploreSectionType.Action,
	title: title,
	link: link,
	description: description,
	baseParams: baseParams ?? ActionSearchFilter(),
	filter: filter,
	backgroundColor: backgroundColor,
  );
}

class LearningResourceExploreSectionArgs extends ExploreSectionArguments<LearningResourceSearchFilter> {
  LearningResourceExploreSectionArgs({
	required String title,
	BaseExploreFilter<LearningResourceSearchFilter>? filter,
	ExplorePageArguments? link,
	String? description,
	LearningResourceSearchFilter? baseParams,
	Color? backgroundColor,
  }): super(
	type: ExploreSectionType.Learning,
	title: title,
	link: link,
	description: description,
	baseParams: baseParams ?? LearningResourceSearchFilter(),
	filter: filter,
	backgroundColor: backgroundColor,
  );
}

class NewsArticleExploreSectionArgs extends ExploreSectionArguments<NewsArticleSearchFilter> {
  NewsArticleExploreSectionArgs({
	required String title,
	BaseExploreFilter<NewsArticleSearchFilter>? filter,
	ExplorePageArguments? link,
	String? description,
	NewsArticleSearchFilter? baseParams,
	Color? backgroundColor,
  }): super(
	// TODO This type shouldn't be required anymore
	type: ExploreSectionType.News,
	title: title,
	link: link,
	description: description,
	baseParams: baseParams ?? NewsArticleSearchFilter(),
	filter: filter,
	backgroundColor: backgroundColor,
  );
}

abstract class BaseExploreFilterOption extends Equatable {
  /// What is displayed to the user
  String get displayName;
  bool get isSelected;
  set isSelected(bool value);

  @override
  List<Object> get props => [displayName];
}

abstract class BaseExploreFilter<FilterT> {
  List<BaseExploreFilterOption> get options;

  /// Whether multiple filter options can be selected at once
  bool get multi;
  ExploreFilterState get state;

  int get numOptionsSelected =>
      options.where((option) => option.isSelected).length;

  /// Deselect all options
  void clearSelections() {
    options.forEach((option) {
      option.isSelected = false;
    });
  }

  void toggleOption(BaseExploreFilterOption option) {
    // If an option is being deselected and there is only one selected option
    // then force this option to stay selected.
    if (option.isSelected && numOptionsSelected == 1) {
      return;
    }

    // If an option is being selected and you cannot have multiple selections,
    // then clear current selections first.
    if (!option.isSelected && !multi) {
      clearSelections();
    }
    option.isSelected = !option.isSelected;
  }

  FilterT toFilter();
  Future<void> init(Function notifyListeners) async {
    // If there are options select the first one
    if (options.length != 0 && numOptionsSelected == 0) {
      options[0].isSelected = true;
    }
    print("Options are: ");
    print(options);
  }
}

// TODO isSelected messing with equatable above. Really isSelected shouldn't live here
class ExploreFilterOption<T> extends BaseExploreFilterOption {
  /// What is displayed to the user
  final String displayName;

  /// The value posted to the api when this is selected
  final T parameterValue;

  /// Whether the filter is selected
  bool isSelected;

  ExploreFilterOption({
    required this.displayName,
    required this.parameterValue,
    this.isSelected = false,
  });
}

enum ExploreFilterState {
  Loading,
  Errored,
  Loaded,
}

class ExploreFilter<ValueT, FilterT> extends BaseExploreFilter<FilterT> {
  FilterT Function(List<ValueT> selectedOptionValues) _toFilter;

  /// The options that can be selected for this filter
  List<ExploreFilterOption<ValueT>>? staticOptions;
  Future<List<ExploreFilterOption<ValueT>>> Function()? getOptions;

  ExploreFilterState state;
  bool multi;

  List<ExploreFilterOption<ValueT>> get options => staticOptions!;

  ExploreFilter({
	required FilterT Function(List<ValueT> selectedOptionValues) toFilter,
    List<ExploreFilterOption<ValueT>>? options,
    this.getOptions,
    this.multi = true,
  })  : assert(options != null || getOptions != null),
		_toFilter = toFilter,
		state = options == null
			? ExploreFilterState.Loading
			: ExploreFilterState.Loaded,
		staticOptions = options;

	Future<void> init(Function notifyListeners) async {
		if (staticOptions == null) {
			state = ExploreFilterState.Loading;
			notifyListeners();
			staticOptions = await getOptions!();
			state = ExploreFilterState.Loaded;
			notifyListeners();
		}
		await super.init(notifyListeners);
	}

	@override
	FilterT toFilter() {
		print("Turning a thing into a thing");
		print(options);
		print(options.map((option) => option.isSelected));
		var selectedOptionValues = options
			.where((option) => option.isSelected)
			.map((option) => option.parameterValue)
			.toList();
		print(selectedOptionValues);
		return _toFilter(selectedOptionValues);
	}
}

// TimeExploreFilter
class TimeExploreFilterOption extends BaseExploreFilterOption {
  /// What is displayed to the user
  final String displayName;

  /// Whether the filter is selected
  bool isSelected;
  double minValue;
  double maxValue;

  TimeExploreFilterOption({
    required this.displayName,
    required this.minValue,
    required this.maxValue,
    this.isSelected = false,
  });
}

abstract class TimeExploreFilter<FilterT> extends BaseExploreFilter<FilterT> {
  /// The name of the parameter to be posted to the api
  final List<TimeExploreFilterOption> options = timeBrackets
      .map((bracket) => TimeExploreFilterOption(
            displayName: bracket['text'],
            minValue: bracket['minTime'].toDouble(),
            maxValue: bracket['maxTime'].toDouble(),
          ))
      .toList();

  bool multi = true;
  ExploreFilterState state = ExploreFilterState.Loaded;

  List<TimeExploreFilterOption> get selectedOptions =>
      options.where((option) => option.isSelected).toList();

  List<Tuple2<double, double>> getTimeBrackets() {
	return selectedOptions.map((option) => Tuple2(option.minValue, option.maxValue)).toList();
  }
}

class ActionTimeExploreFilter extends TimeExploreFilter<ActionSearchFilter> {
	toFilter() {
		return ActionSearchFilter(timeBrackets: getTimeBrackets());
	}
}

class LearningResourceTimeExploreFilter extends TimeExploreFilter<LearningResourceSearchFilter> {
	toFilter() {
		return LearningResourceSearchFilter(timeBrackets: getTimeBrackets());
	}
}

enum ExploreSectionState {
  Loading,
  Errored,
  Loaded,
}

enum ExploreSectionType {
  Action,
  Learning,
  Campaign,
  News,
}

sealed class ExploreTileData {}

sealed class ExploreSection<T extends ExploreTileData, FilterParams extends ResourceFilter<FilterParams>> {
  CausesService _causesService = locator<CausesService>();
  SearchService _searchService = locator<SearchService>();
  AuthenticationService _authService = locator<AuthenticationService>();

  final double tileHeight = 160;

  List<T>? tiles;
  Future<List<T>> fetchTiles(FilterParams filter);

  BaseExploreFilter? get filter => this.args.filter;

  ExploreSection(
    this.args, {
    this.state = ExploreSectionState.Loading,
  });

  final ExploreSectionArguments<FilterParams> args;
  ExploreSectionState state = ExploreSectionState.Loading;

  FilterParams get queryParams {
	FilterParams? filterAdditionalParams = args.filter?.toFilter();
	FilterParams params = filterAdditionalParams != null ? args.baseParams.merge(filterAdditionalParams) : args.baseParams;
    // By default all sections should be filtered by the user's selected causes
	print("Getting params ${params}");
	print("Final params cause ids: ${params.causeIds}");

	if (params.causeIds == null) {
		params.causeIds = _causesService.userInfo!.selectedCausesIds.toList();
	}

	return params;
  }

  void init(Function notifyListeners) async {
    // If its already loaded dont reload
    if (state == ExploreSectionState.Loaded) {
      return;
    }

    reload(notifyListeners);
  }

  void reload(Function notifyListeners) async {
    state = ExploreSectionState.Loading;
    notifyListeners();
    if (args.filter != null) {
      await args.filter!.init(notifyListeners);
    }
    tiles = await fetchTiles(queryParams);
	tiles?.shuffle();
    state = ExploreSectionState.Loaded;
    notifyListeners();
  }
}

mixin ExploreViewModelMixin on BaseModel {
  List<ExploreSection> sections = [];

  void toggleFilterOption(
      ExploreSection section, BaseExploreFilterOption option) {
    section.filter!.toggleOption(option);
    notifyListeners();
    section.reload(notifyListeners);
  }

  void initSections() {
    for (ExploreSection section in sections) {
      section.init(notifyListeners);
    }
  }
}

ExploreSection exploreSectionFromArgs(ExploreSectionArguments args) {
  switch (args) {
    case ActionExploreSectionArgs():
      return ActionExploreSection(args);
    case LearningResourceExploreSectionArgs():
      return LearningResourceExploreSection(args);
    case CampaignExploreSectionArgs():
      return CampaignExploreSection(args);
    case NewsArticleExploreSectionArgs():
      return NewsExploreSection(args);
  }
  // TODO Work out why this is possible - sealed should ensure its not
  throw Exception("Unhandled explore section arguments type");
}

class ExplorePageViewModel extends BaseModel with ExploreViewModelMixin {
  NavigationService _navigationService = locator<NavigationService>();
  final String title;

  void init() {
    initSections();
  }

  ExplorePageViewModel(this.title, List<ExploreSectionArguments> sections,
      {Map<String, dynamic>? baseParams}) {
    // Add the base parameters to the sections
	this.sections = sections.map((args) {
		return exploreSectionFromArgs(
			// TODO Handle filterig across all sections
			// args.addBaseParams(baseParams ?? {})
			args,
		);
    }).toList();
  }

  void changePage(ExplorePageArguments args) {
    _navigationService.navigateTo(Routes.explore, arguments: args);
  }

  bool get canGoBack {
    return _navigationService.canGoBack();
  }

  void back() {
    _navigationService.goBack();
  }

  bool hasLinks() {
    return sections.any((section) => section.args.link != null);
  }

  void navigateToSearchPage() {
    _navigationService.navigateTo(Routes.search);
  }
}

//-- Explore Sections --//
class ActionExploreTileData extends ExploreTileData {
  final ListAction action;
  final bool isCompleted;

  ActionExploreTileData(this.action, this.isCompleted);
}

class ActionExploreSection extends ExploreSection<ActionExploreTileData, ActionSearchFilter> {
  final double tileHeight = 160;

  ActionExploreSection(ExploreSectionArguments<ActionSearchFilter> args) : super(args);

  fetchTiles(filter) async {
    List<ListAction> actions = await _searchService.searchActions(filter: filter);
	return actions.map((action) {
		bool isCompleted = _causesService.actionIsComplete(action.id);
		return ActionExploreTileData(action, isCompleted);
	}).toList();
  }
}

class LearningResourceExploreTileData extends ExploreTileData {
  final LearningResource learningResource;
  final bool isCompleted;

  LearningResourceExploreTileData(this.learningResource, this.isCompleted);
}

class LearningResourceExploreSection extends ExploreSection<LearningResourceExploreTileData, LearningResourceSearchFilter> {
  double tileHeight = 160;

  LearningResourceExploreSection(ExploreSectionArguments<LearningResourceSearchFilter> args) : super(args);

  fetchTiles(filter) async {
    List<LearningResource> learningResources = await _searchService.searchLearningResources(filter: filter);
	return learningResources.map((learningResource) {
		bool isCompleted = _causesService.learningResourceIsComplete(learningResource.id);
		return LearningResourceExploreTileData(learningResource, isCompleted);
	}).toList();
  }
}

// TODO Rename these, they have the same name as the widget
class CampaignExploreTileData extends ExploreTileData {
  final ListCampaign campaign;
  final bool isCompleted;

  CampaignExploreTileData(this.campaign, this.isCompleted);
}

class CampaignExploreSection extends ExploreSection<CampaignExploreTileData, CampaignSearchFilter> {
  double tileHeight = 300;

  CampaignExploreSection(ExploreSectionArguments<CampaignSearchFilter> args) : super(args);

  fetchTiles(params) async {
	final campaigns = await _searchService.searchCampaigns(filter: params);
	return campaigns.map((campaign) {
		bool isCompleted = _causesService.campaignIsComplete(campaign.id);
		return CampaignExploreTileData(campaign, isCompleted);
	}).toList();
  }
}

class NewsArticleExploreTileData extends ExploreTileData {
  final NewsArticle article;

  NewsArticleExploreTileData(this.article);
}

class NewsExploreSection extends ExploreSection<NewsArticleExploreTileData, NewsArticleSearchFilter> {
  double tileHeight = 330;

  NewsExploreSection(ExploreSectionArguments<NewsArticleSearchFilter> args) : super(args);

  fetchTiles(filter) async {
    final newsArticles = await _searchService.searchNewsArticles(filter: filter);
	return newsArticles.map((article) => NewsArticleExploreTileData(article)).toList();
  }
}

//-- Explore Filters --//

abstract class ByCauseExploreFilter<FilterT> extends ExploreFilter<int, FilterT> {
	ByCauseExploreFilter(
		FilterT Function(Iterable<int> selectedOptionValues) toFilter,
	)
      : super(
          multi: true,
          getOptions: () async {
            final CausesService _causesService = locator<CausesService>();
            List<Cause> causes = await _causesService.getCauses();
            return causes
                .map(
                  (Cause cause) => ExploreFilterOption(
                      displayName: cause.title, parameterValue: cause.id),
                )
                .toList();
          },
		  toFilter: toFilter
        );
}

class ActionByCauseExploreFilter extends ByCauseExploreFilter<ActionSearchFilter> {
	ActionByCauseExploreFilter(): super(
		(selectedCauseIds) => ActionSearchFilter(causeIds: selectedCauseIds)
	);
}

class CampaignByCauseExploreFilter extends ByCauseExploreFilter<CampaignSearchFilter> {
	CampaignByCauseExploreFilter(): super(
		(selectedCauseIds) => CampaignSearchFilter(causeIds: selectedCauseIds)
	);
}

class LearningResourceByCauseExploreFilter extends ByCauseExploreFilter<LearningResourceSearchFilter> {
	LearningResourceByCauseExploreFilter(): super(
		(selectedCauseIds) => LearningResourceSearchFilter(causeIds: selectedCauseIds)
	);
}
