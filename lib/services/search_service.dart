import 'package:causeApiClient/causeApiClient.dart';
import 'package:collection/collection.dart';
import 'package:meilisearch/meilisearch.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:nowu/assets/constants.dart';
import 'package:nowu/app/app.locator.dart';
import 'package:nowu/services/causes_service.dart';
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

class BaseResourceSearchFilter {
  String? query;
  Iterable<int>? causeIds;
  // TODO This is really weird because we merge base resource filter with other filters, how do we use this field for those?
  // do we need 2 different filters? One for searching resources or should we just return empty when the resource type is not include
  // for the merge stuff??
  Iterable<ResourceType>? resourceTypes;

  BaseResourceSearchFilter({
    this.query,
    this.causeIds,
    this.resourceTypes,
  });
}

abstract class ResourceSearchFilter<Self extends ResourceSearchFilter<Self>> {
  String? query;
  Iterable<int>? causeIds;
  DateTime? releasedSince;

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

    // TODO Add epoch released at to meilisearch
    // if (filter?.releasedSince != null) {
    // 	filters.add("released_at_epoch > ${filter!.releasedSince!.millisecondsSinceEpoch / 1000}");
    // }

    return filter;
  }

  Self merge(Self other);

  ResourceSearchFilter<Self> mergeBaseFilter(BaseResourceSearchFilter filter) {
    // TODO Add copy with with the freezed package
    this.causeIds = this.causeIds ?? filter.causeIds;
    this.query = this.query ?? filter.query;
    return this;
  }

  SearchQuery toMeilisearchQuery(CausesUser? userInfo);
}

class CampaignSearchFilter extends ResourceSearchFilter<CampaignSearchFilter> {
  bool? ofTheMonth;
  bool? recommended;
  bool? completed;

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

    // TODO REcommenede wha is it called?

    return SearchQuery(
      filter: filter,
    );
  }

  CampaignSearchFilter merge(CampaignSearchFilter other) {
    return CampaignSearchFilter(
      query: query ?? other.query,
      causeIds: causeIds ?? other.causeIds,
      ofTheMonth: ofTheMonth ?? other.ofTheMonth,
      recommended: recommended ?? other.recommended,
      releasedSince: releasedSince ?? other.releasedSince,
      completed: completed ?? other.completed,
    );
  }
}

class ActionSearchFilter extends ResourceSearchFilter<ActionSearchFilter> {
  bool? ofTheMonth;
  bool? recommended;
  bool? completed;
  Iterable<Tuple2<double, double>>? timeBrackets;
  Iterable<ActionTypeEnum>? types;

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

    // TODO REcommenede wha is it called?

    // TODO Action type
    if (types != null) {
      filter.add("action_type IN [${types!.join(',')}]");
    }

    return SearchQuery(
      filter: filter,
    );
  }

  ActionSearchFilter merge(ActionSearchFilter other) {
    return ActionSearchFilter(
      // TODO Update these to have every method!!!! Use freezed?
      query: query ?? other.query,
      causeIds: causeIds ?? other.causeIds,
      ofTheMonth: ofTheMonth ?? other.ofTheMonth,
      recommended: recommended ?? other.recommended,
      releasedSince: releasedSince ?? other.releasedSince,
      types: types ?? other.types,
      completed: completed ?? other.completed,
      timeBrackets: timeBrackets ?? other.timeBrackets,
    );
  }
}

class LearningResourceSearchFilter
    extends ResourceSearchFilter<LearningResourceSearchFilter> {
  bool? ofTheMonth;
  bool? recommended;
  bool? completed;
  Iterable<Tuple2<double, double>>? timeBrackets;

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

    // TODO REcommenede wha is it called?

    return SearchQuery(
      filter: filter,
    );
  }

  LearningResourceSearchFilter merge(LearningResourceSearchFilter other) {
    return LearningResourceSearchFilter(
      query: query ?? other.query,
      causeIds: causeIds ?? other.causeIds,
      ofTheMonth: ofTheMonth ?? other.ofTheMonth,
      recommended: recommended ?? other.recommended,
      releasedSince: releasedSince ?? other.releasedSince,
      completed: completed ?? other.completed,
      timeBrackets: timeBrackets ?? other.timeBrackets,
    );
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
    return const SearchQuery();
  }

  NewsArticleSearchFilter merge(NewsArticleSearchFilter other) {
    return NewsArticleSearchFilter(
      query: query ?? other.query,
      causeIds: causeIds ?? other.causeIds,
      releasedSince: releasedSince ?? other.releasedSince,
    );
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
  final _meiliSearchClient = MeiliSearchClient(
    '$LOCAL_STACK_URL:7700',
    'masterKey',
    const Duration(seconds: 10),
  );

  final CauseApiClient _causeServiceClient = CauseApiClient();
  final CausesService _causesService = locator<CausesService>();

  List<ListAction> _searchHitsToActions(List<Map<String, dynamic>> hits) {
    final results = _causeServiceClient.serializers.deserialize(
      hits,
      specifiedType: const FullType(BuiltList, [FullType(ListAction)]),
    ) as BuiltList<ListAction>;
    return results.asList();
  }

  List<LearningResource> _searchHitsToLearningResources(
    List<Map<String, dynamic>> hits,
  ) {
    final results = _causeServiceClient.serializers.deserialize(
      hits,
      specifiedType: const FullType(BuiltList, [FullType(LearningResource)]),
    ) as BuiltList<LearningResource>;
    return results.asList();
  }

  List<ListCampaign> _searchHitsToCampaign(List<Map<String, dynamic>> hits) {
    final results = _causeServiceClient.serializers.deserialize(
      hits,
      specifiedType: const FullType(BuiltList, [FullType(ListCampaign)]),
    ) as BuiltList<ListCampaign>;
    return results.asList();
  }

  List<NewsArticle> _searchHitsToNewsArticles(List<Map<String, dynamic>> hits) {
    final results = _causeServiceClient.serializers.deserialize(
      hits,
      specifiedType: const FullType(BuiltList, [FullType(NewsArticle)]),
    ) as BuiltList<NewsArticle>;
    return results.asList();
  }

  Future<List<ListAction>> searchActions({ActionSearchFilter? filter}) async {
    final _actionsIndex = _meiliSearchClient.index(SearchIndexName.ACTIONS);
    final result = await _actionsIndex.search(
      filter?.query,
      filter?.toMeilisearchQuery(_causesService.userInfo),
    );
    return _searchHitsToActions(result.hits);
  }

  Future<List<ListCampaign>> searchCampaigns({
    CampaignSearchFilter? filter,
  }) async {
    final campaignsIndex = _meiliSearchClient.index(SearchIndexName.CAMPAIGNS);
    final result = await campaignsIndex.search(
      filter?.query,
      filter?.toMeilisearchQuery(_causesService.userInfo),
    );
    return _searchHitsToCampaign(result.hits);
  }

  Future<List<LearningResource>> searchLearningResources({
    LearningResourceSearchFilter? filter,
  }) async {
    final _learningResourcesIndex =
        _meiliSearchClient.index(SearchIndexName.LEARNING_RESOURCES);
    final result = await _learningResourcesIndex.search(
      filter?.query,
      filter?.toMeilisearchQuery(_causesService.userInfo),
    );
    return _searchHitsToLearningResources(result.hits);
  }

  Future<List<NewsArticle>> searchNewsArticles({
    NewsArticleSearchFilter? filter,
  }) async {
    final _newsArticleIndex =
        _meiliSearchClient.index(SearchIndexName.NEWS_ARTICLES);
    final result = await _newsArticleIndex.search(
      filter?.query,
      filter?.toMeilisearchQuery(_causesService.userInfo),
    );
    return _searchHitsToNewsArticles(result.hits);
  }

  // TODO Find out how to search multiple indexes
  Future<ResourcesSearchResult> searchResources({
    BaseResourceSearchFilter? filter,
  }) async {
    final results = await _meiliSearchClient.multiSearch(
      MultiSearchQuery(
        // TODO Should we put this default stuff into the filters directly??
        queries: (filter?.resourceTypes ?? ResourceType.values)
            .map(
              (resourceType) => IndexSearchQuery(
                indexUid: getResourceTypeIndexName(resourceType),
                query: filter?.query,
                // TODO Can merge with correct type if required
                // TODO This is completely wrong need to do to meilisearch query thing
                // filter: filter,
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
      actions: _searchHitsToActions(getIndexHits(SearchIndexName.ACTIONS)),
      learningResources: _searchHitsToLearningResources(
        getIndexHits(SearchIndexName.LEARNING_RESOURCES),
      ),
      campaigns: _searchHitsToCampaign(getIndexHits(SearchIndexName.CAMPAIGNS)),
      newsArticles: _searchHitsToNewsArticles(
        getIndexHits(SearchIndexName.NEWS_ARTICLES),
      ),
    );
  }
}
