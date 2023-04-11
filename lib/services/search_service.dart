import 'package:json_annotation/json_annotation.dart';
import 'package:meilisearch/meilisearch.dart';
part 'search_service.g.dart';

@JsonSerializable()
class ResourceSearchResult {
  @JsonKey(fromJson: int.parse)
  final int id;
  final String title;
  final String type;

  ResourceSearchResult({
    required this.id,
    required this.title,
    required this.type,
  });

  factory ResourceSearchResult.fromJson(Map<String, dynamic> data) =>
      _$ResourceSearchResultFromJson(data);
}

class SearchService {
  // This is a read only API token for the CampaignAction index. If more access is required a new token must be generated
  final _meiliSearchClient = MeiliSearchClient(
      'https://staging.search.now-u.com',
      '962d6b1b1bef902d274ebfe2a767efc6c19cca15a4e477bebd4e65c7e2628b35');

  Future<List<ResourceSearchResult>> searchResources(String query) async {
    final _actionsIndex = _meiliSearchClient.index("CampaignAction");
    final result = await _actionsIndex.search(query);
    if (result.hits == null) {
      return [];
    }
    return result.hits!.map((e) => ResourceSearchResult.fromJson(e)).toList();
  }
}
