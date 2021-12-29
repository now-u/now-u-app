import 'package:app/models/Campaign.dart';
import 'package:app/models/Action.dart';
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
    this.multi = false,
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

  ExploreSectionViewModel(this.params, this.filter);

  Map<String, dynamic>? get queryParams {
    if (filter == null) return params;
    if (params == null) return filter!.toJson();
    return mergeMaps(params!, filter!.toJson());
  }

  Future<List<ExplorableType>> _fetchTiles();
  void fetchTiles() async {
    setBusy(true);
    this.tiles = await _fetchTiles();
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
      : super(params, filter);

  Future<List<ListCampaign>> _fetchTiles() async {
    return await _causesService.getCampaigns(params: queryParams);
  }
}

class ActionExploreSectionViewModel
    extends ExploreSectionViewModel<ListCauseAction> {
  ActionExploreSectionViewModel(
      {Map<String, dynamic>? params, ExploreFilter? filter})
      : super(params, filter);

  Future<List<ListCauseAction>> _fetchTiles() async {
    return await _causesService.getActions(params: queryParams);
  }
}

class NewsExploreSectionViewModel extends ExploreSectionViewModel<Article> {
  NewsExploreSectionViewModel(
      {Map<String, dynamic>? params, ExploreFilter? filter})
      : super(params, filter);

  Future<List<Article>> _fetchTiles() async {
    return await _newsService.getArticles(params: queryParams);
  }
}
