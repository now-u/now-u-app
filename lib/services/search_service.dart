import 'dart:math';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:causeApiClient/causeApiClient.dart'
    hide NewsArticle, ListAction, ListCampaign, LearningResource;
import 'package:causeApiClient/causeApiClient.dart' as Api;
import 'package:collection/collection.dart';
import 'package:meilisearch/meilisearch.dart';
import 'package:nowu/locator.dart';
import 'package:nowu/assets/constants.dart';
import 'package:nowu/models/article.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/model/search/search_response.dart';
import 'package:tuple/tuple.dart';

class SearchIndexName {
  static const ACTIONS = 'actions';
  static const LEARNING_RESOURCES = 'learning_resources';
  static const CAMPAIGNS = 'campaigns';
  static const NEWS_ARTICLES = 'news_articles';
}

String timeBracketsToMeilisearchFilter(
  Iterable<Tuple2<double, double>> timeBrackets,
) {
  return timeBrackets
      .map(
        (bracket) => '(time >= ${bracket.item1} AND time <= ${bracket.item2})',
      )
      .join(' OR ');
}

String recommendedToMeiliSearchFilter() {
  return 'suggested = true';
}

String newToMeiliSearchFilter(
  Iterable<Tuple2<double, double>> timeBrackets,
) {
  return 'release_at_timestamp > ${DateTime.now().subtract(const Duration(days: 2)).millisecondsSinceEpoch / 1000}';
}

// TODO Use composition for this
class BaseResourceSearchFilter {
  final String? query;
  final Iterable<int>? causeIds;

  // TODO This is really weird because we merge base resource filter with other filters, how do we use this field for those?
  // do we need 2 different filters? One for searching resources or should we just return empty when the resource type is not include
  // for the merge stuff??
  final Iterable<ResourceType>? resourceTypes;
  final DateTime? releasedSince;

  // TODO Add released since
  const BaseResourceSearchFilter({
    this.query,
    this.causeIds,
    this.resourceTypes,
    this.releasedSince,
  });

  // TODO Use freezed to generate this
  BaseResourceSearchFilter copyWith({
    String? query,
    Iterable<int>? causeIds,
    Iterable<ResourceType>? resourceTypes,
  }) {
    return BaseResourceSearchFilter(
      query: query ?? this.query,
      causeIds: causeIds ?? this.causeIds,
      resourceTypes: resourceTypes ?? this.resourceTypes,
    );
  }

  // TODO Duplicate code going on here!
  List<String> toMeilisearchFilter() {
    final List<String> filter = [];

    if (causeIds != null) {
      filter.add("causes.id IN [${causeIds!.join(',')}]");
    }

    if (releasedSince != null) {
      filter.add(
        'release_at_timestamp > ${releasedSince!.millisecondsSinceEpoch / 1000}',
      );
    }

    return filter;
  }
}

sealed class ResourceSearchFilter<Self extends ResourceSearchFilter<Self>> {
  final String? query;
  final Iterable<int>? causeIds;
  final DateTime? releasedSince;

  ResourceSearchFilter({
    required this.query,
    required this.releasedSince,
    required this.causeIds,
  });

  List<String> _toMeilisearchFilter(Iterable<int>? selectedCauseIds) {
    final List<String> filter = [];

    if (causeIds != null) {
      print('Filtering by $causeIds');
      print('Not filtering by $selectedCauseIds');
      filter.add("causes.id IN [${causeIds!.join(',')}]");
    } else if (selectedCauseIds != null) {
      print('Filtering by selected cause ids: $selectedCauseIds');
      filter.add("causes.id IN [${selectedCauseIds.join(',')}]");
    }

    if (releasedSince != null) {
      filter.add(
        'release_at_timestamp > ${releasedSince!.millisecondsSinceEpoch / 1000}',
      );
    }

    return filter;
  }

  SearchQuery toMeilisearchQuery(CausesUser? userInfo);
}

class CampaignSearchFilter extends ResourceSearchFilter<CampaignSearchFilter> {
  final bool? ofTheMonth;
  final bool? recommended;
  final bool? completed;

  CampaignSearchFilter({
    this.ofTheMonth,
    this.recommended,
    this.completed,
    String? query,
    Iterable<int>? causeIds,
    DateTime? releasedSince,
  }) : super(query: query, causeIds: causeIds, releasedSince: releasedSince);

  SearchQuery toMeilisearchQuery(CausesUser? userInfo) {
    final List<String> filter =
        super._toMeilisearchFilter(userInfo?.selectedCausesIds);

    if (ofTheMonth != null) {
      filter.add('of_the_month = ${ofTheMonth}');
    }

    if (completed != null) {
      filter.add(
        "${!completed! ? 'NOT ' : ''}id IN [${userInfo != null ? userInfo.completedCampaignIds.join(',') : ''}]",
      );
    }

    if (recommended == true) {
      filter.add(recommendedToMeiliSearchFilter());
    }

    return SearchQuery(
      filter: filter,
    );
  }
}

class ActionSearchFilter extends ResourceSearchFilter<ActionSearchFilter> {
  final bool? ofTheMonth;
  final bool? recommended;
  final bool? completed;
  final Iterable<Tuple2<double, double>>? timeBrackets;
  final Iterable<ActionTypeEnum>? types;

  ActionSearchFilter({
    this.ofTheMonth,
    this.recommended,
    this.completed,
    this.timeBrackets,
    this.types,
    String? query,
    Iterable<int>? causeIds,
    DateTime? releasedSince,
  }) : super(query: query, causeIds: causeIds, releasedSince: releasedSince);

  SearchQuery toMeilisearchQuery(CausesUser? userInfo) {
    final List<String> filter =
        super._toMeilisearchFilter(userInfo?.selectedCausesIds);

    if (ofTheMonth != null) {
      filter.add('of_the_month = ${ofTheMonth}');
    }

    if (completed != null) {
      filter.add(
        "${!completed! ? 'NOT ' : ''}id IN [${userInfo != null ? userInfo.completedActionIds.join(',') : ''}]",
      );
    }

    if (timeBrackets != null) {
      filter.add(timeBracketsToMeilisearchFilter(timeBrackets!));
    }

    if (recommended == true) {
      filter.add(recommendedToMeiliSearchFilter());
    }

    // TODO Released since

    // TODO Action type
    if (types != null) {
      filter.add("action_type IN [${types!.join(',')}]");
    }

    return SearchQuery(
      filter: filter,
    );
  }
}

class LearningResourceSearchFilter
    extends ResourceSearchFilter<LearningResourceSearchFilter> {
  final bool? ofTheMonth;
  final bool? recommended;
  final bool? completed;
  final Iterable<Tuple2<double, double>>? timeBrackets;

  LearningResourceSearchFilter({
    this.ofTheMonth,
    this.recommended,
    this.completed,
    this.timeBrackets,
    String? query,
    Iterable<int>? causeIds,
    DateTime? releasedSince,
  }) : super(query: query, causeIds: causeIds, releasedSince: releasedSince);

  SearchQuery toMeilisearchQuery(CausesUser? userInfo) {
    final List<String> filter =
        super._toMeilisearchFilter(userInfo?.selectedCausesIds);

    if (ofTheMonth != null) {
      filter.add('of_the_month = ${ofTheMonth}');
    }

    if (completed != null) {
      filter.add(
        "${!completed! ? 'NOT ' : ''}id IN [${userInfo != null ? userInfo.completedLearningResourceIds.join(',') : ''}]",
      );
    }

    if (timeBrackets != null) {
      filter.add(timeBracketsToMeilisearchFilter(timeBrackets!));
    }

    if (recommended == true) {
      filter.add(recommendedToMeiliSearchFilter());
    }

    return SearchQuery(filter: filter);
  }
}

// TODO THis might not make sense, doeResourceSearchFilterside causes...
class NewsArticleSearchFilter
    extends ResourceSearchFilter<NewsArticleSearchFilter> {
  NewsArticleSearchFilter({
    String? query,
    Iterable<int>? causeIds,
    DateTime? releasedSince,
  }) : super(query: query, causeIds: causeIds, releasedSince: releasedSince);

  SearchQuery toMeilisearchQuery(CausesUser? userInfo) {
    final List<String> filter =
        super._toMeilisearchFilter(userInfo?.selectedCausesIds);
    return SearchQuery(filter: filter, sort: ['published_at_timestamp:desc']);
  }
}

class ResourcesSearchResult {
  final Iterable<ListAction> actions;
  final Iterable<LearningResource> learningResources;
  final Iterable<ListCampaign> campaigns;
  final Iterable<NewsArticle> newsArticles;

  ResourcesSearchResult({
    required this.actions,
    required this.learningResources,
    required this.campaigns,
    required this.newsArticles,
  });
}

// TODO do this somehwere central and maybe use sealed type
String getResourceTypeDisplay(ResourceType resourceType) {
  switch (resourceType) {
    case ResourceType.ACTION:
      return 'Action';
    case ResourceType.LEARNING_RESOURCE:
      return 'Learning';
    case ResourceType.CAMPAIGN:
      return 'Campaign';
    case ResourceType.NEWS_ARTICLE:
      return 'News';
  }
}

// TODO do this somehwere central and maybe use sealed type
enum ResourceType {
  ACTION,
  LEARNING_RESOURCE,
  NEWS_ARTICLE,
  CAMPAIGN,
}

String getResourceTypeIndexName(ResourceType resourceType) {
  switch (resourceType) {
    case ResourceType.ACTION:
      return SearchIndexName.ACTIONS;
    case ResourceType.LEARNING_RESOURCE:
      return SearchIndexName.LEARNING_RESOURCES;
    case ResourceType.CAMPAIGN:
      return SearchIndexName.CAMPAIGNS;
    case ResourceType.NEWS_ARTICLE:
      return SearchIndexName.NEWS_ARTICLES;
  }
}

class SearchService {
  // This is a read only API token for the CampaignAction index. If more access is required a new token must be generated
  // TODO Add custom dio with sentry enabled
  final _meiliSearchClient = MeiliSearchClient(
    SEARCH_SERVICE_URL,
    SEARCH_SERVICE_KEY,
    const Duration(seconds: 10),
  );

  final _causeServiceClient = CauseApiClient();
  final _causesService = locator<CausesService>();

  var _random = Random();

  void updateShuffleSeed() {
    _random = Random();
  }

  List<T> _shuffleList<T>(List<T> list) {
    final newList = List<T>.from(list);
    newList.shuffle(_random);
    return newList;
  }

  List<T> _orderSearchResults<T>(List<T> list, SearchQuery? query) {
    // If the list has already been sorted by query then don't change
    if (query?.sort != null) {
      return list;
    }

    return _shuffleList(list);
  }

  List<ListAction> _searchHitsToActions(List<Map<String, dynamic>> hits) {
    final results = _causeServiceClient.serializers.deserialize(
      hits,
      specifiedType: const FullType(BuiltList, [FullType(Api.ListAction)]),
    ) as BuiltList<Api.ListAction>;
    return results.map(ListAction.fromApiModel).toList();
  }

  List<LearningResource> _searchHitsToLearningResources(
    List<Map<String, dynamic>> hits,
  ) {
    final results = _causeServiceClient.serializers.deserialize(
      hits,
      specifiedType: const FullType(BuiltList, [FullType(Api.LearningResource)]),
    ) as BuiltList<Api.LearningResource>;
    return results.map(LearningResource.fromApiModel).toList();
  }

  List<ListCampaign> _searchHitsToCampaign(List<Map<String, dynamic>> hits) {
    final results = _causeServiceClient.serializers.deserialize(
      hits,
      specifiedType: const FullType(BuiltList, [FullType(Api.ListCampaign)]),
    ) as BuiltList<Api.ListCampaign>;
    return results.map(ListCampaign.fromApiModel).toList();
  }

  List<NewsArticle> _searchHitsToNewsArticles(List<Map<String, dynamic>> hits) {
    final results = _causeServiceClient.serializers.deserialize(
      hits,
      specifiedType: const FullType(BuiltList, [FullType(Api.NewsArticle)]),
    ) as BuiltList<Api.NewsArticle>;
    return results.map((e) => NewsArticle(e)).toList();
  }

  Future<List<T>> _searchIndex<T>(
    MeiliSearchIndex index,
    ResourceSearchFilter? resourceSearchFilter,
    List<T> Function(List<Map<String, dynamic>>) responseSerializer,
    int offset,
    int limit,
  ) async {
    final searchQuery =
        resourceSearchFilter?.toMeilisearchQuery(_causesService.userInfo);
    final result = await index.search(
      resourceSearchFilter?.query,
      searchQuery?.copyWith(limit: limit, offset: offset),
    );
    return responseSerializer(_orderSearchResults(result.hits, searchQuery));
  }

  Future<SearchResponse<ListAction>> searchActions({
    ActionSearchFilter? filter,
    int offset = 0,
  }) async {
    const limit = 20;

    return _searchIndex(
      _meiliSearchClient.index(SearchIndexName.ACTIONS),
      filter,
      _searchHitsToActions,
      offset,
      limit,
    ).then(
      (value) => SearchResponse(
        items: value,
        hasReachedMax: value.length < limit,
      ),
    );
  }

  Future<SearchResponse<ListCampaign>> searchCampaigns({
    CampaignSearchFilter? filter,
    int offset = 0,
  }) async {
    const limit = 20;

    return _searchIndex(
      _meiliSearchClient.index(SearchIndexName.CAMPAIGNS),
      filter,
      _searchHitsToCampaign,
      offset,
      limit,
    ).then(
      (value) => SearchResponse(
        items: value,
        hasReachedMax: value.length < limit,
      ),
    );
  }

  Future<SearchResponse<LearningResource>> searchLearningResources({
    LearningResourceSearchFilter? filter,
    int offset = 0,
  }) async {
    const limit = 20;

    return _searchIndex(
      _meiliSearchClient.index(SearchIndexName.LEARNING_RESOURCES),
      filter,
      _searchHitsToLearningResources,
      offset,
      limit,
    ).then(
      (value) => SearchResponse(
        items: value,
        hasReachedMax: value.length < limit,
      ),
    );
  }

  Future<SearchResponse<NewsArticle>> searchNewsArticles({
    NewsArticleSearchFilter? filter,
    int offset = 0,
  }) async {
    const limit = 20;

    return _searchIndex(
      _meiliSearchClient.index(SearchIndexName.NEWS_ARTICLES),
      filter,
      _searchHitsToNewsArticles,
      offset,
      limit,
    ).then(
      (value) => SearchResponse(
        items: value,
        hasReachedMax: value.length < limit,
      ),
    );
  }

  // TODO Find out how to search multiple indexes
  Future<ResourcesSearchResult> searchResources({
    BaseResourceSearchFilter? filter,
  }) async {
    final searchQuery = filter?.toMeilisearchFilter();
    final results = await _meiliSearchClient.multiSearch(
      MultiSearchQuery(
        // TODO Should we put this default stuff into the filters directly??
        queries: (filter?.resourceTypes ?? ResourceType.values)
            .map(
              (resourceType) => IndexSearchQuery(
                indexUid: getResourceTypeIndexName(resourceType),
                query: filter?.query,
                filter: searchQuery,
              ),
            )
            .toList(),
      ),
    );

    List<Map<String, dynamic>> getIndexHits(String indexName) {
      // TODO Should we have null and [] to make it clear if the index was searched or not?
      return results.results
              .firstWhereOrNull(
                (indexResult) => indexResult.indexUid == indexName,
              )
              ?.hits ??
          [];
    }

    return ResourcesSearchResult(
      // For now the order is never defined so we can just use null
      actions: _searchHitsToActions(
        _orderSearchResults(getIndexHits(SearchIndexName.ACTIONS), null),
      ),
      learningResources: _searchHitsToLearningResources(
        _orderSearchResults(
          getIndexHits(SearchIndexName.LEARNING_RESOURCES),
          null,
        ),
      ),
      campaigns: _searchHitsToCampaign(
        _orderSearchResults(getIndexHits(SearchIndexName.CAMPAIGNS), null),
      ),
      newsArticles: _searchHitsToNewsArticles(
        _orderSearchResults(getIndexHits(SearchIndexName.NEWS_ARTICLES), null),
      ),
    );
  }
}
