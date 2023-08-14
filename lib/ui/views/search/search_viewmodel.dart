import 'package:collection/collection.dart';
import 'package:nowu/app/app.locator.dart';
import 'package:nowu/models/article.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/router_service.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/ui/views/search/search_view.form.dart';
import 'package:stacked/stacked.dart';

const TYPE_PREFIX = 'type:';

class SearchViewModel extends FormViewModel {
  final _searchService = locator<SearchService>();
  final _routerService = locator<RouterService>();
  final _causesService = locator<CausesService>();

  // TODO Make sealed resource type which this thing can be... Potentially we need to wrap generated types?
  ResourcesSearchResult? searchResult = null;

  String resourceTypeSearchTerm(ResourceType resourceType) {
    switch (resourceType) {
      case ResourceType.ACTION:
        return 'action';
      case ResourceType.LEARNING_RESOURCE:
        return 'learning';
      case ResourceType.CAMPAIGN:
        return 'campaign';
      case ResourceType.NEWS_ARTICLE:
        return 'news';
    }
  }

  ResourceType? _parseTypeSearchTerm(String searchTerm) {
    final typeString = searchTerm.substring(TYPE_PREFIX.length);
    return ResourceType.values.firstWhereOrNull(
      (resourceType) => resourceTypeSearchTerm(resourceType) == typeString,
    );
  }

  BaseResourceSearchFilter _parseSearchValue() {
    final searchTerms = searchValueValue?.split(' ') ?? [];

    final searchGroups = searchTerms.groupListsBy((term) {
      if (term.startsWith(TYPE_PREFIX)) {
        return TYPE_PREFIX;
      } else {
        return '';
      }
    });

    final resourceTypes = searchGroups[TYPE_PREFIX]
        ?.map((term) => _parseTypeSearchTerm(term))
        .whereNotNull();
    return BaseResourceSearchFilter(
      query: searchGroups['']?.join(' '),
      resourceTypes: resourceTypes != [] ? resourceTypes : null,
    );
  }

  // TODO Hide see more button after this filter has been applied
  // Work on a more generic way of handling this filtering maybe/at least store which filters are applied in the view model
  void addTypeSearchTerm(ResourceType resourceType) {
    // TODO Move cursor to after the input
    setSearchValue(
      ["$TYPE_PREFIX${resourceTypeSearchTerm(resourceType)}", searchValueValue]
          .join(' '),
    );
  }

  void search() async {
    searchResult =
        await _searchService.searchResources(filter: _parseSearchValue());
    notifyListeners();
  }

  void setSearchValue(String value) {
    searchValueValue = value;
    search();
  }

  void clearSearchValue() {
    setSearchValue('');
  }

  void openAction(ListAction action) {
    _causesService.openAction(action.id);
  }

  void openCampaign(ListCampaign campaign) {
    _causesService.openCampaign(campaign);
  }

  void openLearningResource(LearningResource learningResource) {
    _causesService.openLearningResource(learningResource);
  }

  void openNewsArticle(NewsArticle article) {
    _causesService.openNewArticle(article);
  }

  void navigateBack() {
    _routerService.back();
  }

  int numberOfNonEmptySections() {
    return [
      searchResult?.actions.isEmpty,
      searchResult?.campaigns.isEmpty,
      searchResult?.campaigns.isEmpty,
      searchResult?.newsArticles.isEmpty
    ].where((element) => element != true).length;
  }
}
