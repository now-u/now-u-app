import 'dart:collection';
import 'dart:math';
import 'package:app/assets/components/explore_tiles.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/models/Cause.dart';
import 'package:app/models/Learning.dart';
import 'package:app/models/article.dart';
import 'package:app/services/auth.dart';
import 'package:app/services/news_service.dart';
import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'package:app/pages/explore/ExplorePage.dart';
import 'package:app/viewmodels/base_model.dart';
import 'package:app/models/Explorable.dart';
import 'package:app/locator.dart';
import 'package:app/services/causes_service.dart';

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

abstract class ExploreSection<T extends Explorable> {
  CausesService _causesService = locator<CausesService>();
  AuthenticationService _authService = locator<AuthenticationService>();

  final double tileHeight = 160;
  final Color? backgroundColor;

  Future<List<T>> fetchTiles(Map<String, dynamic> params);
  Widget renderTile(T tile);

  ExploreSection({
    required this.title,
    this.description,
    this.link,
    this.baseParams,
    this.filter,
    this.state = ExploreSectionState.Loading,
    this.backgroundColor,
  });

  /// Title of the section
  String title;

  /// Where clicking on the title should go
  ExplorePage? link;

  /// Description of the section
  String? description;

  // Params to provide to fetch query
  Map<String, dynamic>? baseParams;

  ///
  BaseExploreFilter? filter;
  List<T>? tiles;

  ExploreSectionState state = ExploreSectionState.Loading;

  Map<String, dynamic> get queryParams {
    Map<String, dynamic> params = mergeMaps(baseParams ?? {}, filter != null ? filter!.toJson() : {});
    // By default all sections should be filtered by the user's selected causes
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
    if (filter != null) {
      await filter!.init(notifyListeners);
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

class ExplorePageViewModel extends BaseModel with ExploreViewModelMixin {
  String title;

  void init() {
    initSections();
  }

  final Queue<ExplorePage> previousPages = Queue();

  ExplorePageViewModel(this.title, List<ExploreSection> sections) {
    print("Sections are $sections");
    this.sections = sections;
  }

  void changePage(ExplorePage page) {
    update(
      title: page.title,
      sections: page.sections,
    );
  }

  void update(
      {List<ExploreSection>? sections,
      String? title,
      bool saveHistory = true}) {
    if (saveHistory) {
      previousPages
          .addLast(ExplorePage(sections: this.sections, title: this.title));
    }
    this.sections = sections ?? this.sections;
    this.title = title ?? this.title;
    notifyListeners();
    init();
  }

  bool get canBack => previousPages.length != 0;

  void back() {
    if (previousPages.length == 0) {
      return;
    }
    ExplorePage page = previousPages.last;
    previousPages.removeLast();
    update(sections: page.sections, title: page.title, saveHistory: false);
  }
}

//-- Explore Sections --//

class ActionExploreSection extends ExploreSection<ListCauseAction> {
  final double tileHeight = 160;

  ActionExploreSection({
    required String title,
    String? description,
    ExplorePage? link,
    Map<String, dynamic>? baseParams,
    BaseExploreFilter? filter,
    Color? backgroundColor,
  }) : super(
          title: title,
          description: description,
          link: link,
          baseParams: baseParams,
          filter: filter,
          backgroundColor: backgroundColor,
        );

  Future<List<ListCauseAction>> fetchTiles(Map<String, dynamic> params) {
    return _causesService.getActions(params: queryParams);
  }

  Widget renderTile(ListCauseAction tile) => ExploreActionTile(tile);
}

class LearningResourceExploreSection extends ExploreSection<LearningResource> {
  double tileHeight = 160;

  LearningResourceExploreSection({
    required String title,
    String? description,
    ExplorePage? link,
    Map<String, dynamic>? baseParams,
    BaseExploreFilter? filter,
    Color? backgroundColor,
  }) : super(
          title: title,
          description: description,
          link: link,
          baseParams: baseParams,
          filter: filter,
          backgroundColor: backgroundColor,
        );

  Future<List<LearningResource>> fetchTiles(Map<String, dynamic> params) {
    return _causesService.getLearningResources(params: queryParams);
  }

  Widget renderTile(LearningResource tile) => ExploreLearningTile(tile);
}

class CampaignExploreSection extends ExploreSection<ListCampaign> {
  double tileHeight = 300;

  CampaignExploreSection({
    required String title,
    String? description,
    ExplorePage? link,
    Map<String, dynamic>? baseParams,
    BaseExploreFilter? filter,
    Color? backgroundColor,
  }) : super(
          title: title,
          description: description,
          link: link,
          baseParams: baseParams,
          filter: filter,
          backgroundColor: backgroundColor,
        );

  Future<List<ListCampaign>> fetchTiles(Map<String, dynamic> params) {
    return _causesService.getCampaigns(params: queryParams);
  }

  Widget renderTile(ListCampaign tile) => ExploreCampaignTile(tile);
}

class NewsExploreSection extends ExploreSection<Article> {
  double tileHeight = 330;

  NewsExploreSection({
    required String title,
    String? description,
    ExplorePage? link,
    Map<String, dynamic>? baseParams,
    BaseExploreFilter? filter,
    Color? backgroundColor,
  }) : super(
          title: title,
          description: description,
          link: link,
          baseParams: baseParams,
          filter: filter,
          backgroundColor: backgroundColor,
        );

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
