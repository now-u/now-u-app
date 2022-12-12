import 'dart:collection';
import 'dart:math';
import 'package:app/assets/components/explore_tiles.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/models/Cause.dart';
import 'package:app/models/Learning.dart';
import 'package:app/models/article.dart';
import 'package:app/routes.dart';
import 'package:app/services/auth.dart';
import 'package:app/services/navigation_service.dart';
import 'package:app/services/news_service.dart';
import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'package:app/viewmodels/base_model.dart';
import 'package:app/models/Explorable.dart';
import 'package:app/locator.dart';
import 'package:app/services/causes_service.dart';

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

class ExploreSectionArguments {
  /// Title of the section
  final String title;

  /// Where clicking on the title should go
  final ExplorePageArguments? link;

  /// Description of the section
  final String? description;

  // Params to provide to fetch query
  final Map<String, dynamic>? baseParams;

  ///
  final BaseExploreFilter? filter;

  final Color? backgroundColor;

  final ExploreSectionType type;

  ExploreSectionArguments({
    required this.title,
    required this.type,
    this.description,
    this.link,
    this.baseParams,
    this.filter,
    this.backgroundColor,
  });

  ExploreSectionArguments addBaseParams(Map<String, dynamic> baseParams) {
    return ExploreSectionArguments(
      title: title,
      // TODO This doesnt quite work as we also need to update the title
      // link: link != null ? link!.addBaseParams(baseParams) : null,
      link: link,
      description: description,
      baseParams: mergeMaps(baseParams, this.baseParams ?? {}),
      filter: filter,
      backgroundColor: backgroundColor,
      type: type,
    );
  }
}

abstract class BaseExploreFilterOption extends Equatable {
  /// What is displayed to the user
  String get displayName;
  bool get isSelected;
  set isSelected(bool value);

  @override
  List<Object> get props => [displayName];
}

abstract class BaseExploreFilter {
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

  Map<String, dynamic> toJson();
  Future<void> init(Function notifyListeners) async {
    // If there are options select the first one
    if (options.length != 0 && numOptionsSelected == 0) {
      options[0].isSelected = true;
    }
    print("Options are: ");
    print(options);
  }
}

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

class ExploreFilter extends BaseExploreFilter {
  /// The name of the parameter to be posted to the api
  String parameterName;

  /// The options that can be selected for this filter
  List<ExploreFilterOption>? staticOptions;
  Future<List<ExploreFilterOption>> Function()? getOptions;

  ExploreFilterState state;
  bool multi;

  List<ExploreFilterOption> get options => staticOptions!;

  ExploreFilter({
    required this.parameterName,
    List<ExploreFilterOption>? options,
    this.getOptions,
    this.multi = true,
  })  : assert(options != null || getOptions != null),
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

  Map<String, dynamic> toJson() {
    // If many can be selected return a list
    dynamic value = multi
        ? staticOptions == null
            ? []
            : options
                .where((option) => option.isSelected)
                .map((option) => option.parameterValue)
                .toList()
        : staticOptions == null
            ? null
            : options
                .firstWhereOrNull((option) => option.isSelected)
                ?.parameterValue;

    return {parameterName: value};
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

class TimeExploreFilter extends BaseExploreFilter {
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

  Map<String, dynamic> toJson() {
    double minTime =
        selectedOptions.map((option) => option.minValue).reduce(min);
    double maxTime =
        selectedOptions.map((option) => option.maxValue).reduce(max);
    if (maxTime == double.infinity) {
      return {
        "time__gte": minTime,
      };
    }

    print("Converting to JSON");
    print("Max is: ${maxTime}");
    print("Min is: ${minTime}");

    return {
      "time__lte": maxTime,
      "time__gte": minTime,
    };
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

abstract class ExploreSection<T extends Explorable> {
  CausesService _causesService = locator<CausesService>();
  AuthenticationService _authService = locator<AuthenticationService>();

  final double tileHeight = 160;

  List<T>? tiles;
  Future<List<T>> fetchTiles(Map<String, dynamic> params);
  Widget renderTile(T tile);

  BaseExploreFilter? get filter => this.args.filter;

  ExploreSection(
    this.args, {
    this.state = ExploreSectionState.Loading,
  });

  final ExploreSectionArguments args;
  ExploreSectionState state = ExploreSectionState.Loading;

  Map<String, dynamic> get queryParams {
    Map<String, dynamic> params = mergeMaps(args.baseParams ?? {},
        args.filter != null ? args.filter!.toJson() : {});
    // By default all sections should be filtered by the user's selected causes
    print("Getting params ${params}");
    if (!params.containsKey("cause__in") && _authService.currentUser != null) {
      params["cause__in"] = _authService.currentUser!.selectedCauseIds;
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
  switch (args.type) {
    case ExploreSectionType.Campaign:
      return CampaignExploreSection(args);
    case ExploreSectionType.Learning:
      return LearningResourceExploreSection(args);
    case ExploreSectionType.Action:
      return ActionExploreSection(args);
    case ExploreSectionType.News:
      return NewsExploreSection(args);
  }
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
      return exploreSectionFromArgs(args.addBaseParams(baseParams ?? {}));
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
}

//-- Explore Sections --//

class ActionExploreSection extends ExploreSection<ListCauseAction> {
  final double tileHeight = 160;

  ActionExploreSection(ExploreSectionArguments args) : super(args);

  Future<List<ListCauseAction>> fetchTiles(Map<String, dynamic> params) {
    return _causesService.getActions(params: queryParams);
  }

  Widget renderTile(ListCauseAction tile) => ExploreActionTile(tile);
}

class LearningResourceExploreSection extends ExploreSection<LearningResource> {
  double tileHeight = 160;

  LearningResourceExploreSection(ExploreSectionArguments args) : super(args);

  Future<List<LearningResource>> fetchTiles(Map<String, dynamic> params) {
    return _causesService.getLearningResources(params: queryParams);
  }

  Widget renderTile(LearningResource tile) => ExploreLearningTile(tile);
}

class CampaignExploreSection extends ExploreSection<ListCampaign> {
  double tileHeight = 300;

  CampaignExploreSection(ExploreSectionArguments args) : super(args);

  Future<List<ListCampaign>> fetchTiles(Map<String, dynamic> params) {
    return _causesService.getCampaigns(params: queryParams);
  }

  Widget renderTile(ListCampaign tile) => ExploreCampaignTile(tile);
}

class NewsExploreSection extends ExploreSection<Article> {
  double tileHeight = 330;

  NewsExploreSection(ExploreSectionArguments args) : super(args);

  Future<List<Article>> fetchTiles(Map<String, dynamic> params) {
    NewsService _newsService = locator<NewsService>();
    return _newsService.getArticles(params: queryParams);
  }

  Widget renderTile(Article tile) => ExploreNewsTile(tile);
}

//-- Explore Filters --//

class ByCauseExploreFilter extends ExploreFilter {
  ByCauseExploreFilter()
      : super(
          parameterName: "cause__in",
          multi: true,
          getOptions: () async {
            final CausesService _causesService = locator<CausesService>();
            List<ListCause> causes = await _causesService.getCauses();
            return causes
                .map(
                  (ListCause cause) => ExploreFilterOption(
                      displayName: cause.title, parameterValue: cause.id),
                )
                .toList();
          },
        );
}
