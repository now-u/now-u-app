import 'package:nowu/services/router_service.dart';
import 'package:nowu/ui/views/explore/explore_page_definition.dart';
import 'package:nowu/ui/views/explore/explore_page_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:uuid/uuid.dart';
import 'package:nowu/app/app.locator.dart';
import 'package:nowu/models/article.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/search_service.dart';

var uuid = const Uuid();

enum ExploreSectionState {
  Loading,
  Errored,
  Loaded,
}

enum ExploreSectionFilterState {
  Loading,
  Errored,
  Loaded,
}

class ExploreSectionFilterViewModelData<
    FilterT extends ResourceSearchFilter<FilterT>, FilterParamType> {
  ExploreSectionFilterState state = ExploreSectionFilterState.Loading;
  Iterable<ExploreFilterOptionArgs<FilterParamType>> filterOptions = [];
  ExploreFilterArgs<FilterT, FilterParamType> args;

  Set<String> selectedOptions = Set();

  bool optionIsSelected(ExploreFilterOptionArgs option) {
    return selectedOptions.contains(option.displayName);
  }

  // TODO This is a hack, how do we pass this around properly
  Function? reloadTiles;

  int get numOptionsSelected => selectedOptions.length;

  ExploreSectionFilterViewModelData({
    required this.args,
  });

  Future<void> init(Function reloadTiles) async {
    filterOptions = await args.getOptions();
    selectedOptions.add(filterOptions.elementAt(0).displayName);
    state = ExploreSectionFilterState.Loaded;
    this.reloadTiles = reloadTiles;
  }

  FilterT toFilter() {
    final selectedOptions =
        filterOptions.where((option) => optionIsSelected(option));
    return args.optionsToFilter(selectedOptions);
  }

  /// Deselect all options
  void clearSelections() {
    selectedOptions.clear();
  }

  // TODO Move this stuff inot the model to avoid passign round notify maybe?
  void toggleSelectOption(ExploreFilterOptionArgs option) {
    // If an option is being deselected and there is only one selected option
    // then force this option to stay selected.
    if (optionIsSelected(option) && numOptionsSelected == 1) {
      return;
    }

    // If an option is being selected and you cannot have multiple selections,
    // then clear current selections first.
    if (!optionIsSelected(option) && !args.isMulti) {
      clearSelections();
    }

    if (optionIsSelected(option)) {
      selectedOptions.remove(option.displayName);
    } else {
      selectedOptions.add(option.displayName);
    }
    print('Selected options are: ${selectedOptions}');
    reloadTiles!();
  }
}

sealed class ExploreSectionViewModel<
    T extends ExploreTileData,
    FilterT extends ResourceSearchFilter<FilterT>,
    FilterParamType> extends BaseViewModel {
  final _searchService = locator<SearchService>();
  final _causesService = locator<CausesService>();
  final _routerService = locator<RouterService>();

  ExploreSectionArguments<FilterT, FilterParamType> args;
  ExplorePageViewModel? pageViewModel;

  ExploreSectionState state = ExploreSectionState.Loading;
  Iterable<T> tiles = [];

  // TODO Move this into the filter data object and find a sensible name for filter
  ExploreSectionFilterViewModelData<FilterT, FilterParamType>? filterData;

  // TODO Should probably just take args
  ExploreSectionViewModel(this.args, this.pageViewModel)
      : filterData = args.filter != null
            ? ExploreSectionFilterViewModelData(args: args.filter!)
            : null;

  Future<void> handleLink() async {
    if (args.link == null) {
      return;
    }
    if (pageViewModel == null) {
      return _routerService.navigateToExplore(args.link!);
    }
    pageViewModel!.updateFilter(args.link!);
  }

  Future<void> navigateToEmptyExplore() async {
    if (pageViewModel == null) {
      return _routerService.navigateToExplore();
    }
    pageViewModel!.updateFilter(const BaseResourceSearchFilter());
  }

  FilterT get combinedFilter {
    // TODO Get filter working!!
    FilterT? filterParams = filterData?.toFilter();
    FilterT params = filterParams != null
        ? args.baseParams.merge(filterParams)
        : args.baseParams;

    // By default all sections should be filtered by the user's selected causes
    if (params.causeIds == null) {
      params.causeIds = _causesService.userInfo?.selectedCausesIds;
    }

    return params;
  }

  Future<void> init() async {
    try {
      await this.filterData?.init(reloadTiles);
      this.tiles = await _fetchTiles();

      // TODO Wait together
      // final List<Future<void>> futures = [
      // 	_fetchTiles().then((tiles) => this.tiles = tiles),
      // ];
      // if (this.filterData != null) {
      // 	futures.add(this.filterData!.init(notifyListeners));
      // }
      // await Future.wait(futures);
      this.state = ExploreSectionState.Loaded;
    } catch (exception) {
      this.state = ExploreSectionState.Errored;
      // TODO Handle error - log instead of throwing
      throw exception;
    }
    notifyListeners();
  }

  Future<void> reloadTiles() async {
    this.state = ExploreSectionState.Loading;
    notifyListeners();
    this.tiles = await _fetchTiles();
    this.state = ExploreSectionState.Loaded;
    notifyListeners();
  }

  Future<Iterable<T>> _fetchTiles();
  Future<void> tileOnClick(T tileData);
}

class ActionExploreSectionViewModel<FilterParamType>
    extends ExploreSectionViewModel<ActionExploreTileData, ActionSearchFilter,
        FilterParamType> {
  ActionExploreSectionViewModel(ActionExploreSectionArgs<FilterParamType> args,
      ExplorePageViewModel? pageViewModel,)
      : super(args, pageViewModel);

  @override
  _fetchTiles() async {
    print('Fetching actions');
    Iterable<ListAction> resources =
        await _searchService.searchActions(filter: combinedFilter);
    print('Fetched actions');
    return resources.map((resource) {
      bool? isCompleted = _causesService.actionIsComplete(resource.id);
      return ActionExploreTileData(resource, isCompleted);
    });
  }

  @override
  Future<void> tileOnClick(ActionExploreTileData tileData) {
    return _causesService.openAction(tileData.action.id);
  }
}

class LearningResourceExploreSectionViewModel<FilterParamType>
    extends ExploreSectionViewModel<LearningResourceExploreTileData,
        LearningResourceSearchFilter, FilterParamType> {
  LearningResourceExploreSectionViewModel(
    LearningResourceExploreSectionArgs<FilterParamType> args,
    ExplorePageViewModel? pageViewModel,
  ) : super(args, pageViewModel);

  @override
  _fetchTiles() async {
    Iterable<LearningResource> resources =
        await _searchService.searchLearningResources(filter: combinedFilter);
    return resources.map((resource) {
      bool? isCompleted =
          _causesService.learningResourceIsComplete(resource.id);
      return LearningResourceExploreTileData(resource, isCompleted);
    });
  }

  @override
  Future<void> tileOnClick(LearningResourceExploreTileData tileData) async {
    // TODO This double code is shared a lot
    await _causesService.completeLearningResource(tileData.learningResource.id);
	notifyListeners();
    // TODO Can we do this after?
    // TODO If not do we do that else where (notify after navigate)
    return _causesService.openLearningResource(tileData.learningResource);
  }
}

class CampaignExploreSectionViewModel<FilterParamType>
    extends ExploreSectionViewModel<CampaignExploreTileData,
        CampaignSearchFilter, FilterParamType> {
  CampaignExploreSectionViewModel(
    CampaignExploreSectionArgs<FilterParamType> args,
    ExplorePageViewModel? pageViewModel,
  ) : super(args, pageViewModel);

  @override
  _fetchTiles() async {
    Iterable<ListCampaign> resources =
        await _searchService.searchCampaigns(filter: combinedFilter);
    return resources.map((resource) {
      bool? isCompleted = _causesService.campaignIsComplete(resource.id);
      return CampaignExploreTileData(resource, isCompleted);
    });
  }

  @override
  Future<void> tileOnClick(CampaignExploreTileData tileData) async {
    return _causesService.openCampaign(tileData.campaign);
  }
}

class NewsArticleExploreSectionViewModel<FilterParamType>
    extends ExploreSectionViewModel<NewsArticleExploreTileData,
        NewsArticleSearchFilter, FilterParamType> {
  NewsArticleExploreSectionViewModel(
    NewsArticleExploreSectionArgs<FilterParamType> args,
    ExplorePageViewModel? pageViewModel,
  ) : super(args, pageViewModel);

  @override
  _fetchTiles() async {
    Iterable<NewsArticle> resources =
        await _searchService.searchNewsArticles(filter: combinedFilter);
    return resources.map((resource) {
      return NewsArticleExploreTileData(resource);
    });
  }

  @override
  Future<void> tileOnClick(NewsArticleExploreTileData tileData) async {
    return _causesService.openNewArticle(tileData.article);
  }
}
