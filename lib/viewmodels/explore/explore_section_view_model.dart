import 'package:app/models/Campaign.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/Cause.dart';
import 'package:app/models/Learning.dart';
import 'package:app/models/article.dart';
import 'package:app/services/causes_service.dart';
import 'package:app/services/news_service.dart';
import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';
import 'package:app/models/Explorable.dart';
import 'package:app/viewmodels/base_model.dart';
import 'package:app/locator.dart';

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

class ExploreFilter {
  /// The name of the parameter to be posted to the api
  final String parameterName;

  /// The options that can be selected for this filter
  final List<ExploreFilterOption> options;

  /// Whether multiple filter options can be selected at once
  final bool multi;

  const ExploreFilter({
    required this.parameterName,
    required this.options,
    this.multi = true,
  });

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

abstract class ExploreSectionViewModel<ExplorableType extends Explorable>
    extends BaseModel {
  final CausesService _causesService = locator<CausesService>();
  final NewsService _newsService = locator<NewsService>();

  Map<String, dynamic>? params;
  ExploreFilter? filter;
  List<ExplorableType>? tiles;
  bool error = false;

  ExploreSectionViewModel(
    this.params, {
    this.filter,
  });

  Map<String, dynamic>? get queryParams {
    if (filter == null) return params;
    if (params == null) return filter!.toJson();
    return mergeMaps(params!, filter!.toJson());
  }

  Future<List<ExplorableType>> fetchTiles();

  void init() async {
    setBusy(true);
    this.tiles = await fetchTiles();
    notifyListeners();
    setBusy(false);
  }

  void toggleFilterOption(ExploreFilterOption option) {
    filter!.toggleOption(option);
    notifyListeners();
  }
}

class CampaignExploreSectionViewModel
    extends ExploreSectionViewModel<ListCampaign> {
  CampaignExploreSectionViewModel(
      {Map<String, dynamic>? params, ExploreFilter? filter})
      : super(params, filter: filter);

  Future<List<ListCampaign>> fetchTiles() async {
    return await _causesService.getCampaigns(params: queryParams);
  }
}

mixin ByCauseFilterMixin<T extends Explorable> on ExploreSectionViewModel<T> {
  @override
  void init() async {
    super.init();

    setBusy(true);
    List<ListCause> causes = await _causesService.getCauses();
    this.filter = ExploreFilter(
      parameterName: "cause",
      options: causes
          .map(
            (ListCause cause) => ExploreFilterOption(
                displayName: cause.title, parameterValue: cause.id),
          )
          .toList(),
    );
    notifyListeners();
    setBusy(false);
  }
}

class CampaignExploreByCauseSectionViewModel
    extends CampaignExploreSectionViewModel
    with ByCauseFilterMixin<ListCampaign> {
  CampaignExploreByCauseSectionViewModel() : super();
}

class ActionExploreSectionViewModel
    extends ExploreSectionViewModel<ListCauseAction> {
  ActionExploreSectionViewModel(
      {Map<String, dynamic>? params, ExploreFilter? filter})
      : super(params, filter: filter);

  Future<List<ListCauseAction>> fetchTiles() async {
    return await _causesService.getActions(params: queryParams);
  }
}

class LearningResourceExploreSectionViewModel
    extends ExploreSectionViewModel<LearningResource> {
  LearningResourceExploreSectionViewModel(
      {Map<String, dynamic>? params, ExploreFilter? filter})
      : super(params, filter: filter);

  Future<List<LearningResource>> fetchTiles() async {
    return await _causesService.getLearningResources(params: queryParams);
  }
}

class LearningResourceExploreByCauseSectionViewModel
    extends LearningResourceExploreSectionViewModel
    with ByCauseFilterMixin<LearningResource> {
  LearningResourceExploreByCauseSectionViewModel() : super();
}

class ActionExploreByCauseSectionViewModel extends ActionExploreSectionViewModel
    with ByCauseFilterMixin<ListCauseAction> {
  ActionExploreByCauseSectionViewModel() : super();
}

class NewsExploreSectionViewModel extends ExploreSectionViewModel<Article> {
  NewsExploreSectionViewModel(
      {Map<String, dynamic>? params, ExploreFilter? filter})
      : super(params, filter: filter);

  Future<List<Article>> fetchTiles() async {
    return await _newsService.getArticles(params: queryParams);
  }
}
