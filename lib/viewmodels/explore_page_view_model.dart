import 'dart:collection';
import 'package:app/assets/components/explore_tiles.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/models/Cause.dart';
import 'package:app/models/Learning.dart';
import 'package:app/models/article.dart';
import 'package:app/services/news_service.dart';
import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'package:app/pages/explore/ExplorePage.dart';
import 'package:app/viewmodels/base_model.dart';
import 'package:app/models/Explorable.dart';
import 'package:app/locator.dart';
import 'package:app/services/causes_service.dart';

class ExploreFilterOption<T> extends Equatable {
  /// What is displayed to the user
  final String displayName;

  /// The value posted to the api when this is selected
  final T parameterValue;

  /// Whether the filter is selected
  bool isSelected;

  ExploreFilterOption(
      {required this.displayName,
      required this.parameterValue,
      this.isSelected = false});

  @override
  List<Object> get props => [displayName];
}

enum ExploreFilterState {
  Loading,
  Errored,
  Loaded,
}

class ExploreFilter {
  /// The name of the parameter to be posted to the api
  String parameterName;

  /// The options that can be selected for this filter
  List<ExploreFilterOption>? staticOptions;
  Future<List<ExploreFilterOption>> Function()? getOptions;

  /// Whether multiple filter options can be selected at once
  bool multi;

  ExploreFilterState state;

  List<ExploreFilterOption> get options => staticOptions!;

  ExploreFilter({
    required this.parameterName,
    List<ExploreFilterOption>? options,
    this.getOptions,
    this.multi = true,
  }): 
    assert (options != null || getOptions != null),
    state = options == null ? ExploreFilterState.Loading : ExploreFilterState.Loaded,
    staticOptions = options;


  void init(Function notifyListeners) async {
    if (staticOptions == null) {
      state = ExploreFilterState.Loading;
      notifyListeners();
      staticOptions = await getOptions!();
      state = ExploreFilterState.Loaded;
      notifyListeners();
    }
  }

  /// Deselect all options
  void clearSelections() {
    options.forEach((option) {
      option.isSelected = false;
    });
  }
  
  void toggleOption(ExploreFilterOption option) {
    // If an option is being selected and you cannot have multiple selections,
    // then clear current selections first.
    if (!option.isSelected && !multi) {
      clearSelections();
    }
    option.isSelected = !option.isSelected;
  }

  Map<String, dynamic> toJson() {
    // If many can be selected return a list
    dynamic value = multi
        ? options
            .where((option) => option.isSelected)
            .map((option) => option.parameterValue)
            .toList()
        : options
            .firstWhereOrNull((option) => option.isSelected)
            ?.parameterValue;

    return {parameterName: value};
  }
}

enum ExploreSectionState {
  Loading,
  Errored,
  Loaded,
}

abstract class ExploreSection<T extends Explorable> {
  CausesService _causesService = locator<CausesService>();

  double tileHeight = 160;
  Future<List<T>> fetchTiles(Map<String, dynamic> params);
  Widget renderTile(T tile);

  ExploreSection({
    required this.title,
    this.description,
    this.link,
    this.baseParams,
    this.filter,
    this.state = ExploreSectionState.Loading,
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
  ExploreFilter? filter;
  List<T>? tiles;

  ExploreSectionState state = ExploreSectionState.Loading;
  
  Map<String, dynamic>? get queryParams {
    if (filter == null) return baseParams;
    if (baseParams == null) return filter!.toJson();
    return mergeMaps(baseParams!, filter!.toJson());
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
      filter!.init(notifyListeners);
    }
    tiles = await fetchTiles(queryParams ?? {});
    state = ExploreSectionState.Loaded;
    notifyListeners();
  }
}

// News: 330 ExploreNewsTile
// Campaign: 300 ExploreCampaignTile
// LearningResource: 160 ExploreLearningTile 
// Action: 160 ExploreActionTile 
// Campaign: 300  ExploreCampaignTile

class ExplorePageViewModel extends BaseModel {
  List<ExploreSection> sections;
  String title;

  final Queue<ExplorePage> previousPages = Queue();

  ExplorePageViewModel(this.sections, this.title);

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
  
  void toggleFilterOption(ExploreSection section, ExploreFilterOption option) {
    section.filter!.toggleOption(option);
    notifyListeners();
    section.reload(notifyListeners);
  }

  void init() {
    for (ExploreSection section in sections) {
      section.init(notifyListeners);
    }
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
  double tileHeight = 160;

  ActionExploreSection({
    required String title,
    String? description,
    ExplorePage? link,
    Map<String, dynamic>? baseParams,
    ExploreFilter? filter,
  }) : super(
    title: title,
    description: description,
    link: link,
    baseParams: baseParams,
    filter: filter,
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
    ExploreFilter? filter,
  }) : super(
    title: title,
    description: description,
    link: link,
    baseParams: baseParams,
    filter: filter,
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
    ExploreFilter? filter,
  }) : super(
    title: title,
    description: description,
    link: link,
    baseParams: baseParams,
    filter: filter,
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
    ExploreFilter? filter,
  }) : super(
    title: title,
    description: description,
    link: link,
    baseParams: baseParams,
    filter: filter,
  );

  Future<List<Article>> fetchTiles(Map<String, dynamic> params) {
    NewsService _newsService = locator<NewsService>();
    return _newsService.getArticles(params: queryParams);
  }

  Widget renderTile(Article tile) => ExploreNewsTile(tile);
}

//-- Explore Filters --//

class ByCauseExploreFilter extends ExploreFilter {
  ByCauseExploreFilter(): 
    super(
        parameterName: "cause__in",
        multi: true,
        getOptions: () async {
          final CausesService _causesService = locator<CausesService>();
          List<ListCause> causes = await _causesService.getCauses();
          return causes.map(
            (ListCause cause) => ExploreFilterOption(
              displayName: cause.title, parameterValue: cause.id),
            ).toList();
        },
    );
}
