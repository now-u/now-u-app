import 'package:causeApiClient/causeApiClient.dart';
import 'package:flutter/material.dart';
import 'package:meilisearch/meilisearch.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:nowu/locator.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:tuple/tuple.dart';

String timeBracketsToMeilisearchFilter(Iterable<Tuple2<double, double>> timeBrackets) {
	return timeBrackets.map((bracket) => "(time >= ${bracket.item1} AND time <= ${bracket.item2})").join(' OR ');
}

abstract class ResourceFilter<Self extends ResourceFilter<Self>> {
	String? query;
	Iterable<int>? causeIds;
	DateTime? releasedSince;
	
	ResourceFilter({ required this.query, required this.releasedSince, required this.causeIds });

	List<String> _toMeilisearchFilter(Iterable<int>? selectedCauseIds) {
		final List<String> filter = [];

		if (causeIds != null) {
			print("Filtering by $causeIds");
			print("Not filtering by $selectedCauseIds");
			filter.add("causes.id IN [${causeIds!.join(',')}]");
		} else if (selectedCauseIds != null) {
			filter.add("causes.id IN [${selectedCauseIds.join(',')}]");
		}

		// TODO Add epoch released at to meilisearch
		// if (filter?.releasedSince != null) {
		// 	filters.add("released_at_epoch > ${filter!.releasedSince!.millisecondsSinceEpoch / 1000}");
		// }

		return filter;
	}

	Self merge(Self other);
}

class CampaignSearchFilter extends ResourceFilter<CampaignSearchFilter> {
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
	})
		:super(query: query, causeIds: causeIds, releasedSince: releasedSince);

	List<String> toMeilisearchFilter(CausesUser? userInfo) {
		final List<String> filter = super._toMeilisearchFilter(userInfo?.selectedCausesIds);

		if (ofTheMonth != null) {
			filter.add("of_the_month = ${ofTheMonth}");
		}

		if (completed != null) {
			filter.add("${!completed! ? 'NOT ' : ''}id IN [${userInfo != null ? userInfo.completedCampaignIds.join(',') : ''}]");
		}

		// TODO REcommenede wha is it called?

		return filter;
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

class ActionSearchFilter extends ResourceFilter<ActionSearchFilter> {
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
	})
		:super(query: query, causeIds: causeIds, releasedSince: releasedSince);

	List<String> toMeilisearchFilter(CausesUser? userInfo) {
		final List<String> filter = super._toMeilisearchFilter(userInfo?.selectedCausesIds);

		if (ofTheMonth != null) {
			filter.add("of_the_month = ${ofTheMonth}");
		}

		if (completed != null) {
			filter.add("${!completed! ? 'NOT ' : ''}id IN [${userInfo != null ? userInfo.completedActionIds.join(',') : ''}]");
		}

		if (timeBrackets != null) {
			filter.add(timeBracketsToMeilisearchFilter(timeBrackets!));
		}

		// TODO REcommenede wha is it called?

		// TODO Action type
		if (types != null) {
			filter.add("action_type IN [${types!.join(',')}]");
		}

		return filter;
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
			timeBrackets: timeBrackets ?? other.timeBrackets
		);
	}
}

class LearningResourceSearchFilter extends ResourceFilter<LearningResourceSearchFilter> {
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
	})
		:super(query: query, causeIds: causeIds, releasedSince: releasedSince);

	List<String> toMeilisearchFilter(CausesUser? userInfo) {
		final List<String> filter = super._toMeilisearchFilter(userInfo?.selectedCausesIds);

		if (ofTheMonth != null) {
			filter.add("of_the_month = ${ofTheMonth}");
		}
		
		if (completed != null) {
			filter.add("${!completed! ? 'NOT ' : ''}id IN [${userInfo != null ? userInfo.completedLearningResourceIds.join(',') : ''}]");
		}
		
		if (timeBrackets != null) {
			filter.add(timeBracketsToMeilisearchFilter(timeBrackets!));
		}

		// TODO REcommenede wha is it called?

		return filter;
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

// TODO THis might not make sense, does news live inside causes...
class NewsArticleSearchFilter extends ResourceFilter<NewsArticleSearchFilter> {
	NewsArticleSearchFilter({
		String? query,
		Iterable<int>? causeIds,
		DateTime? releasedSince,
	})
		:super(query: query, causeIds: causeIds, releasedSince: releasedSince);

	List<String> toMeilisearchFilter() {
		return [];
	}

	NewsArticleSearchFilter merge(NewsArticleSearchFilter other) {
		return NewsArticleSearchFilter(
			query: query ?? other.query,
			causeIds: causeIds ?? other.causeIds,
			releasedSince: releasedSince ?? other.releasedSince
		);
	}
}

class SearchService {
  // This is a read only API token for the CampaignAction index. If more access is required a new token must be generated
  final _meiliSearchClient = MeiliSearchClient(
    'http://192.168.1.11:7700',
    'masterKey',
  );

  final CauseApiClient _causeServiceClient = CauseApiClient();
  final CausesService _causesService = locator<CausesService>();

  Future<List<ListAction>> searchActions({ ActionSearchFilter? filter }) async {
    final _actionsIndex = _meiliSearchClient.index("actions");

	final result = await _actionsIndex.search(filter?.query, filter: filter?.toMeilisearchFilter(_causesService.userInfo));

    if (result.hits == null) {
      return [];
    }
	// final actions = _causeServiceClient.serializers.deserialize(
	// 	result.hits!,
	// 	specifiedType: const FullType(BuiltList, [FullType(ListAction)]),
	// ) as BuiltList<ListAction>;
    final actions = _causeServiceClient.serializers.deserialize(
      result.hits!,
      specifiedType: const FullType(BuiltList, [FullType(ListAction)]),
    ) as BuiltList<ListAction>;
	return actions.asList();
  }

  Future<List<ListCampaign>> searchCampaigns({ CampaignSearchFilter? filter }) async {
    final campaignsIndex = _meiliSearchClient.index("campaigns");
	print("Searching campaigns with ${filter?.toMeilisearchFilter(_causesService.userInfo)}");
	
    final result = await campaignsIndex.search(filter?.query, filter: filter?.toMeilisearchFilter(_causesService.userInfo));
    if (result.hits == null) {
      return [];
    }
	final campaigns = _causeServiceClient.serializers.deserialize(
		result.hits!,
		specifiedType: const FullType(BuiltList, [FullType(ListCampaign)]),
	) as BuiltList<ListCampaign>;
	return campaigns.asList();
  }
  
  Future<List<LearningResource>> searchLearningResources({ LearningResourceSearchFilter? filter }) async {
    final _learningResourcesIndex = _meiliSearchClient.index("learning_resources");
	print("SEARCHING WITH FILTER: ${filter?.toMeilisearchFilter(_causesService.userInfo)}");
    final result = await _learningResourcesIndex.search(filter?.query, filter: filter?.toMeilisearchFilter(_causesService.userInfo));
    if (result.hits == null) {
      return [];
    }
	final learningResources = _causeServiceClient.serializers.deserialize(
		result.hits!,
		specifiedType: const FullType(BuiltList, [FullType(LearningResource)]),
	) as BuiltList<LearningResource>;
	return learningResources.asList();
  }

  Future<List<NewsArticle>> searchNewsArticles({ NewsArticleSearchFilter? filter }) async {
    final _newsArticleIndex = _meiliSearchClient.index("news_articles");
    final result = await _newsArticleIndex.search(filter?.query, filter: filter?.toMeilisearchFilter());
    if (result.hits == null) {
      return [];
    }
	final newsArticles = _causeServiceClient.serializers.deserialize(
		result.hits!,
		specifiedType: const FullType(BuiltList, [FullType(NewsArticle)]),
	) as BuiltList<NewsArticle>;
	return newsArticles.asList();
  }
}
